import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:artnet_app/data/models/artnet_opcodes.dart';
import 'package:artnet_app/data/models/node_info.dart';
import 'package:artnet_app/data/models/op_ip_prog_packet.dart';
import 'package:udp/udp.dart';

class ArtNetModule {
  ArtNetModule.__();
  static UDP? sender;
  static List<ArtNetNode> scanResults = [];
  static const String protcolID = 'Art-Net';
  static const int ver = 63488;
  static Future<bool> sendOpPollRequest() async {
    await init();
    // log('Sending ArtPollRequest');
    // bool = false;
    Uint8List packet = Uint8List(16);
    packet.setAll(0, protcolID.codeUnits);
    packet.setAll(7, [0x00]);
    packet.setAll(8, opCodeToPacket(Opcode.opPoll));
    packet.setAll(10, opCodeToPacket(ver));
    packet.setAll(12, [0x60]);
    packet.setAll(13, [0x00]);
    try {
      await sender!.send(packet, Endpoint.broadcast(port: const Port(6454)));
    } catch (e) {
      // log("Sending failed");
      return false;
    }
    // log('Sent');
    return true;
  }

  static Future<bool> sendOpIpProg(
      {required OpIpProgPacket opIpProgPacket, ArtNetNode? artNetNode}) async {
    await init();
    // log('Sending OpIpProgPacket');
    int commad = 0;
    Uint8List packet = Uint8List(30);
    packet.setAll(0, protcolID.codeUnits);
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

    try {
      if (artNetNode == null) {
        await sender!.send(packet, Endpoint.broadcast(port: const Port(6454)));
      } else {
        await sender!.send(packet,
            Endpoint.unicast(artNetNode.ipAddress, port: const Port(6454)));
      }
    } catch (e) {
      // log("Sending failed");
      return false;
    }
    // log('Sent');
    // log(packet.toString());
    return true;
  }

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
      // log("Unable to bind to post 6454");
      sender = await UDP.bind(Endpoint.any(port: const Port(6454)));
    }
    // log('Socket bound to ${sender!.socket!.address.address}:${sender!.socket!.port}');
  }

  static Future handleRecieve(DateTime killTime) async {
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
            default:
            // log("Unhandled opCode: $opCode");
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
    if (String.fromCharCodes(recvBuffer.sublist(0, 7)) != "Art-Net") {
      // log('Not Art-Net packet: Wrong packet ID');
      return -1;
    }
    if (recvBuffer.length < 11) {
      // log('Not Art-Net packet: Packet too short');
      return -1;
    }
    return ((recvBuffer[9] << 8) | recvBuffer[8]);
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
      dhcpCapable: ((recvBuffer[212] & 0x04) >> 2 == 1),
      dhcpEnabled: ((recvBuffer[212] & 0x02) >> 1 == 1),
    );
    if (isNodeExist(artNetNode) == -1) scanResults.add(artNetNode);
  }

  static void decOpIpProgReply(Uint8List recvBuffer) {
    InternetAddress nodeIp, nodeNetMask, nodeGateWay;
    nodeIp = InternetAddress.fromRawAddress(recvBuffer.sublist(16, 20));
    nodeNetMask = InternetAddress.fromRawAddress(recvBuffer.sublist(20, 24));
    nodeGateWay = InternetAddress.fromRawAddress(recvBuffer.sublist(26, 30));
    int pos = isIpExist(nodeIp);
    if (pos != -1) {
      scanResults[pos].netmask = nodeNetMask;
      scanResults[pos].gateWay = nodeGateWay;
      // log(nodeGateWay.address.toString());
    }
  }

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
