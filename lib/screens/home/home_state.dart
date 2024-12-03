import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class ArtNetFoundNodes extends HomeState {
  @override
  List<Object?> get props => [];
}

class ArtNetNoFoundNodes extends HomeState {
  @override
  List<Object?> get props => [];
}

class ArtNetScanning extends HomeState {
  ScanState scanState;
  int foundDevices;
  ArtNetScanning({
    required this.foundDevices,
    required this.scanState,
  });
  @override
  List<Object?> get props => [foundDevices, scanState];
}

enum ScanState {
  firstScan,
  getIpInfo,
}


//  <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
//     <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
//     <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
