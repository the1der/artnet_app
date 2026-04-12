import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:artnet_app/data/models/artnet_opcodes.dart';
import 'package:artnet_app/data/models/node_info.dart';
import 'package:artnet_app/data/models/node_light_configuration.dart';
import 'package:artnet_app/data/models/packets_models/op_ip_prog_packet.dart';
import 'package:artnet_app/data/models/packets_models/syn_out_packet.dart';
import 'package:artnet_app/data/models/syn_opcodes.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:udp/udp.dart';
import 'package:flutter/material.dart';

class ArtNetModule {
  ArtNetModule.__();
  static const String artnetProtocolID = 'Art-Net';
  static const String synProtocolID = 'SYNTHESIS';
  static const int ver = 63488;

  static UDP? sender;
  static List<ArtNetNode> scanResults = [];
  static Iterable<int> opCodeToPacket(int opCode) {
    Uint8List buffer = Uint8List(4);
    final byteData = ByteData.view(buffer.buffer);
    byteData.setInt32(0, opCode, Endian.little);
    return [buffer[0], buffer[1]];
  }

  static Future init() async {
    try {
      sender = await UDP.bind(Endpoint.any(port: const Port(6454)));
    } catch (e) {
      log("Unable to bind to post 6454");
      sender = await UDP.bind(Endpoint.any(port: const Port(6454)));
    }
    // log('Socket bound to ${sender!.socket!.address.address}:${sender!.socket!.port}');
  }

  static Future handleRecieve(DateTime killTime,
      {ArtNetNode? artNetNode}) async {
    bool doneListening = false;
    sender!.asStream().listen((event) {
      if (event != null) {
        int opCode = checkOpcode(event.data);
        if (opCode > 0) {
          switch (opCode) {
            case Opcode.opPollReply:
              // log("OpPollReply");
              decOpPollReply(event.data);
              break;

            case Opcode.opIpProgReply:
              // log("OpIpProgReply");
              decOpIpProgReply(event.data);
              break;
            case SynOpcodes.synOutReply:
              log("SynIpProgReply");
              decodeSynOutReply(event.data, artNetNode!);
              break;
            default:
              log("Unhandled opCode: $opCode");
          }
          doneListening = true;
        }
      }
    });
    while (!doneListening) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (DateTime.now().compareTo(killTime) >= 0) break;
    }
    // log('Done listeing');
  }

  static int checkOpcode(Uint8List recvBuffer) {
    int opCode = -1;
    if (String.fromCharCodes(recvBuffer.sublist(0, 7)) == "Art-Net") {
      opCode = ((recvBuffer[9] << 8) | recvBuffer[8]);
      log("Art-Net received opcode: 0x${opCode.toRadixString(16).toUpperCase()}");
    } else if (String.fromCharCodes(recvBuffer.sublist(0, 9)) == "SYNTHESIS") {
      opCode = ((recvBuffer[11] << 8) | recvBuffer[10]);
      log("SYNTHESIS received opcode: 0x${opCode.toRadixString(16).toUpperCase()}");
    } else {
      log('Not Art-Net or SYNTHESIS packet: Wrong packet ID');
      opCode = -1;
    }
    if (recvBuffer.length < 11) {
      log('Not Art-Net packet: Packet too short');
      opCode = -1;
    }
    return opCode;
  }

  ///*****************OpPoll********************///
  static Future<bool> sendOpPollRequest() async {
    await init();
    // log('Sending ArtPollRequest');
    // bool = false;
    Uint8List packet = Uint8List(16);
    packet.setAll(0, artnetProtocolID.codeUnits);
    packet.setAll(7, [0x00]);
    packet.setAll(8, opCodeToPacket(Opcode.opPoll));
    packet.setAll(10, opCodeToPacket(ver));
    packet.setAll(12, [0x60]);
    packet.setAll(13, [0x00]);
    try {
      // await sender!.send(packet, Endpoint.broadcast(port: const Port(6454)));
      await sender!.send(
          packet,
          Endpoint.unicast(InternetAddress("10.0.2.2"),
              port: const Port(6454)));
    } catch (e) {
      // log("Sending failed");
      return false;
    }
    // log('Sent');
    return true;
  }

  static void decOpPollReply(Uint8List recvBuffer) {
    ArtNetNode artNetNode = ArtNetNode(
      ipAddress: InternetAddress.fromRawAddress(recvBuffer.sublist(207, 211)),
      longName: String.fromCharCodes(recvBuffer.sublist(44, 108)),
      shortName: String.fromCharCodes(recvBuffer.sublist(26, 44)),
      macAddress: recvBuffer
          .sublist(201, 207)
          .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
          .join(':'),
      swIn0: recvBuffer[174],
      netSwitch: recvBuffer[19],
      dhcpCapable: ((recvBuffer[212] & 0x04) >> 2 == 1),
      dhcpEnabled: ((recvBuffer[212] & 0x02) >> 1 == 1),
    );
    if (isNodeExist(artNetNode) == -1) {
      artNetNode.isAvailable = true;
      scanResults.add(artNetNode);
    }
  }

  void sendDmxPacket({
    required SolidColorConfigParameters solidColorConfigParameters,
    required ArtNetNode artNetNode,
  }) async {
    int dmxLength =
        (artNetNode.numberOfLeds! / artNetNode.ledsPerGroup!).toInt() *
            (artNetNode.colorModel!.value + 3);

    Uint8List header = Uint8List(18);
    ByteData headerData = ByteData.view(header.buffer);

    Uint8List dmxData = Uint8List(512);

    Uint8List finalPacket = Uint8List(530);

    final Uint8List idBytes = utf8.encode(ArtNetModule.artnetProtocolID);
    final int numberOfGroupsPerPacket =
        (dmxLength / (artNetNode.colorModel!.value + 3)).toInt();
    final int numberOfGroups =
        (artNetNode.numberOfLeds! / artNetNode.ledsPerGroup!).toInt();

    int offset = 0;
    //ID
    header.setRange(offset, offset + idBytes.length, idBytes);
    offset += 8;

    //Opcode
    headerData.setUint16(offset, Opcode.opOutput, Endian.little);
    offset += 2;

    //Version
    headerData.setUint8(offset, 14);
    offset += 1;
    headerData.setUint8(offset, 0);
    offset += 1;

    //Sequence
    headerData.setUint8(offset, 0);
    offset += 1;

    //Physical
    headerData.setUint8(offset, 0);
    offset += 1;

    final int channelsPerGroup = artNetNode.colorModel!.value + 3;
    final int iterations = (numberOfGroups / numberOfGroupsPerPacket).ceil();

    for (int i = 0; i < iterations; i++) {
      final bool isLastPacket = i == iterations - 1;

      final int groupsInThisPacket = isLastPacket
          ? numberOfGroups - (numberOfGroupsPerPacket * (iterations - 1))
          : numberOfGroupsPerPacket;

      dmxLength = groupsInThisPacket * channelsPerGroup;

      //Universe
      headerData.setUint16(14, artNetNode.universe + i, Endian.little);
      offset += 2;

      //Length
      headerData.setUint16(16, dmxLength, Endian.big);
      offset += 2;

      for (int j = 0; j < groupsInThisPacket; j++) {
        final int baseIndex = j * channelsPerGroup;

        dmxData[baseIndex] = solidColorConfigParameters.color.red;
        dmxData[baseIndex + 1] = solidColorConfigParameters.color.green;
        dmxData[baseIndex + 2] = solidColorConfigParameters.color.blue;

        // Extra channels depending on color model
        switch (artNetNode.colorModel!.value) {
          case 1: // RGBW
            dmxData[baseIndex + 3] = 0;
            break;
          case 2: // RGBWW
            dmxData[baseIndex + 3] = 0;
            dmxData[baseIndex + 4] = 0;
            break;
        }
      }
    }

    Uint8List packetBuffer = header.buffer.asUint8List();
    packetBuffer.setRange(18, 18 + dmxLength, dmxData.sublist(0, dmxLength));

    await init();

    try {
      await sender!.send(packetBuffer,
          Endpoint.unicast(artNetNode.ipAddress, port: const Port(6454)));
    } catch (e) {
      // log("Sending failed");
    }
  }

  ///******************end*of*OpPoll**********************///

  ///*****************OpIpProg********************///
  static Uint8List createOpIpProgPacket(OpIpProgPacket opIpProgPacket) {
    int commad = 0;
    Uint8List packet = Uint8List(30);
    packet.setAll(0, artnetProtocolID.codeUnits);
    packet.setAll(7, [0x00]);
    packet.setAll(8, opCodeToPacket(Opcode.opIpProg));
    packet.setAll(10, opCodeToPacket(ver));
    packet.setAll(15, [0x00]);

    if (opIpProgPacket.ip != null) {
      packet.setAll(16, opIpProgPacket.ip?.rawAddress as Iterable<int>);
      commad = commad | 0x04;
      commad = commad | 0x80;
    }

    if (opIpProgPacket.netMask != null) {
      packet.setAll(20, opIpProgPacket.netMask?.rawAddress as Iterable<int>);
      commad = commad | 0x02;
      commad = commad | 0x80;
    }

    if (opIpProgPacket.gateWay != null) {
      packet.setAll(26, opIpProgPacket.gateWay?.rawAddress as Iterable<int>);
      commad = commad | 0x10;
      commad = commad | 0x80;
    }

    if (opIpProgPacket.enableDHCP == true) {
      commad = commad | 0x40;
      commad = commad | 0x80;
    }

    if (opIpProgPacket.resetValues == true) {
      commad = commad | 0x08;
      commad = commad | 0x80;
    }
    // log("commad : $commad");
    packet.setAll(14, [commad & 0xFF]);
    return packet;
  }

  static Future<bool> sendOpIpProg({
    required OpIpProgPacket opIpProgPacket,
    required ArtNetNode artNetNode,
  }) async {
    await init();
    // log('Sending OpIpProgPacket');
    Uint8List packet = createOpIpProgPacket(opIpProgPacket);
    try {
      await sender!.send(packet,
          Endpoint.unicast(artNetNode.ipAddress, port: const Port(6454)));
    } catch (e) {
      return false;
    }
    return true;
  }

  static Future<List<bool>> sendOpIpProgMulti(
      {required OpIpProgPacket opIpProgPacket,
      required List<ArtNetNode> artNetNodes}) async {
    await init();
    List<bool> results =
        List.filled(artNetNodes.isNotEmpty ? artNetNodes.length : 1, true);
    // log('Sending OpIpProgPacket');
    Uint8List packet = createOpIpProgPacket(opIpProgPacket);
    if (artNetNodes.isNotEmpty) {
      for (ArtNetNode node in artNetNodes) {
        try {
          await sender!.send(
              packet, Endpoint.unicast(node.ipAddress, port: const Port(6454)));
        } catch (e) {
          try {
            results[artNetNodes.indexOf(node)] = false;
          } catch (e) {
            results.first = false;
          }
        }
      }
    } else {
      await sender!.send(packet, Endpoint.broadcast(port: const Port(6454)));
    }

    return results;
  }

  static void decOpIpProgReply(Uint8List recvBuffer) {
    InternetAddress nodeIp, nodeNetMask, nodeGateWay;
    nodeIp = InternetAddress.fromRawAddress(recvBuffer.sublist(16, 20));
    nodeNetMask = InternetAddress.fromRawAddress(recvBuffer.sublist(20, 24));
    nodeGateWay = InternetAddress.fromRawAddress(recvBuffer.sublist(28, 32));
    int pos = isIpExist(nodeIp);
    if (pos != -1) {
      scanResults[pos].netmask = nodeNetMask;
      scanResults[pos].gateWay = nodeGateWay;
      // log(nodeGateWay.address.toString());
    }
  }

  ///******************end*of*OpIpProg**********************///

  ///************************synOut*************************///
  static Future<bool> sendSynOut(
      {SynOutPacket synOutPacket =
          const SynOutPacket(programmingEnabled: false),
      required ArtNetNode artNetNode}) async {
    await init();
    // log('Sending SynOut Packet');
    Uint8List packet = synOutPacket.toBytes();
    try {
      await sender!.send(packet,
          Endpoint.unicast(artNetNode.ipAddress, port: const Port(6454)));
    } catch (e) {
      return false;
    }
    return true;
  }

  // static void decSynOutReply(Uint8List recvBuffer) {}
  static void decodeSynOutReply(Uint8List recvBuffer, ArtNetNode artNetNode) {
    if (recvBuffer.lengthInBytes < 8) {
      // Using lengthInBytes for clarity with Uint8List
      throw const FormatException(
          'Reply data too short to contain SynOutReply header.');
    }
    ByteData data = recvBuffer.buffer.asByteData();
    int outputTypeByte = data.getUint8(13);
    int colorModelByte = data.getUint8(14);
    int numberOfLeds = data.getUint8(16) + data.getUint8(17) * 256;
    int ledsPerGroup = data.getUint8(18);
    if (isNodeExist(artNetNode) != -1) {
      int index = isNodeExist(artNetNode);
      ArtNetModule.scanResults[index].colorModel =
          SynOutColorModel.values[colorModelByte];
      ArtNetModule.scanResults[index].nodeOutputType =
          SynOutOutputType.values[outputTypeByte];
      ArtNetModule.scanResults[index].numberOfLeds = numberOfLeds;
      ArtNetModule.scanResults[index].ledsPerGroup = ledsPerGroup;
    }
  }

  ///*******************end*of*synOut***********************///
  static int isNodeExist(ArtNetNode artNetNode) {
    if (scanResults.isEmpty) return -1;
    for (int i = 0; i < scanResults.length; i++) {
      if (artNetNode.macAddress == scanResults[i].macAddress) return i;
    }

    return -1;
  }

  static int isIpExist(InternetAddress nodeIp) {
    if (scanResults.isEmpty) return -1;
    for (int i = 0; i < scanResults.length; i++) {
      if (nodeIp == scanResults[i].ipAddress) return i;
    }

    return -1;
  }
}
