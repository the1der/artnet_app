import 'package:artnet_app/models/op_ip_prog_packet.dart';
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
        scanState: ScanState.getIpInfo,
      ));

      await ArtNetModule.sendOpIpProg(opIpProgPacket: OpIpProgPacket());
      killTime = DateTime.now().add(const Duration(seconds: 5));
      while (true) {
        await ArtNetModule.handleRecieve(killTime);
        if (DateTime.now().compareTo(killTime) >= 0) {
          ArtNetModule.sender?.close();
          break;
        }
      }
      if (ArtNetModule.scanResults.isNotEmpty) {
        emit(ArtNetFoundNodes());
      } else {
        emit(ArtNetNoFoundNodes());
      }
    });
  }
}
