import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:artnet_app/data/models/node_light_configuration.dart';
import 'package:artnet_app/data/models/packets_models/syn_out_packet.dart';

class ArtNetNode {
  // Node IP Address
  InternetAddress ipAddress;
  InternetAddress? netmask;
  InternetAddress? gateWay;
  String macAddress;
  bool dhcpEnabled, dhcpCapable;

  bool isAvailable;

  // ArtAddress
  String longName;
  String shortName;
  int swIn0;
  int netSwitch;
  int universe;

  // SynOut
  int? numberOfLeds;
  SynOutColorModel? colorModel;
  SynOutOutputType? nodeOutputType;
  int? ledsPerGroup;

  NodeLightConfiguration? nodeLightConfiguration;
  ArtNetNode({
    required this.ipAddress,
    required this.longName,
    required this.shortName,
    required this.macAddress,
    required this.dhcpCapable,
    required this.dhcpEnabled,
    required this.swIn0,
    required this.netSwitch,
    this.universe = 0,
    this.isAvailable = false,
    this.nodeLightConfiguration,
    this.numberOfLeds,
    this.netmask,
    this.gateWay,
    this.colorModel,
    this.nodeOutputType,
  }) {
    universe = (netSwitch << 8) | swIn0;
  }
}
