import 'dart:developer';
import 'dart:io';

import 'package:artnet_app/data/models/node_info.dart';
import 'package:artnet_app/data/models/node_light_configuration.dart';
import 'package:artnet_app/data/models/packets_models/op_ip_prog_packet.dart';
import 'package:artnet_app/data/models/packets_models/syn_out_packet.dart';
import 'package:artnet_app/services/artnet_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:artnet_app/screens/home/home_event.dart';
import 'package:artnet_app/screens/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<ArtNetStartScan>((event, emit) async {
      ArtNetModule.scanResults = [];
      DateTime killTime = DateTime.now().add(const Duration(seconds: 5));
      emit(ArtNetScanning(
        foundDevices: ArtNetModule.scanResults.length,
        scanState: ScanState.firstScan,
      ));
      await ArtNetModule.sendOpPollRequest();
      while (true) {
        await ArtNetModule.handleRecieve(killTime);

        if (DateTime.now().compareTo(killTime) >= 0) {
          ArtNetModule.sender?.close();
          break;
        }
      }
      emit(ArtNetScanning(
        foundDevices: ArtNetModule.scanResults.length,
        scanState: ScanState.getNodeInfo,
      ));

      await ArtNetModule.sendOpIpProgMulti(
          opIpProgPacket: OpIpProgPacket(),
          artNetNodes: ArtNetModule.scanResults);
      killTime =
          DateTime.now().add(const Duration(seconds: 2, milliseconds: 500));
      while (true) {
        await ArtNetModule.handleRecieve(killTime);
        if (DateTime.now().compareTo(killTime) >= 0) {
          ArtNetModule.sender?.close();
          break;
        }
      }
      ArtNetModule.scanResults.forEach((node) async {
        bool result = await ArtNetModule.sendSynOut(
            artNetNode: node,
            synOutPacket: const SynOutPacket(programmingEnabled: false));
        log(result.toString());
        killTime =
            DateTime.now().add(const Duration(seconds: 1, milliseconds: 500));
        while (true) {
          await ArtNetModule.handleRecieve(killTime, artNetNode: node);
          if (DateTime.now().compareTo(killTime) >= 0) {
            ArtNetModule.sender?.close();
            break;
          }
        }
      });
      ArtNetModule.scanResults.addAll([
        ArtNetNode(
          ipAddress: InternetAddress("192.168.1.2"),
          longName: "Node longName",
          netmask: InternetAddress("255.255.255.0"),
          shortName: "Node short Name",
          macAddress: "9F:1A:3D:AB:C4:22",
          isAvailable: true,
          dhcpCapable: false,
          dhcpEnabled: true,
          netSwitch: 1,
          swIn0: 0,
        ),
        ArtNetNode(
          ipAddress: InternetAddress("192.168.1.10"),
          longName: "Node longName",
          netmask: InternetAddress("255.255.255.0"),
          shortName: "ESP32 Node two",
          macAddress: "9F:4A:3C:AF:C4:75",
          dhcpCapable: false,
          dhcpEnabled: true,
          isAvailable: true,
          netSwitch: 0,
          swIn0: 1,
          nodeLightConfiguration: NodeLightConfiguration(),
        ),
        ArtNetNode(
          ipAddress: InternetAddress("192.168.1.21"),
          longName: "Node longName",
          shortName: "Hello Node one one",
          macAddress: "9A:1C:3A:CB:DF:12",
          netmask: InternetAddress("255.255.255.0"),
          netSwitch: 2,
          swIn0: 3,
          dhcpCapable: false,
          dhcpEnabled: false,
        )
      ]);
      emit(ArtnetSearchDone());
    });
  }
}
