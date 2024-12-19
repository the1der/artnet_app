import 'dart:io';

import 'package:artnet_app/models/node_configuration.dart';

class ArtNetNode {
  InternetAddress ipAddress;
  InternetAddress? netmask;
  InternetAddress? gateWay;
  String longName;
  String shortName;
  String macAddress;
  bool dhcpEnabled, dhcpCapable;
  NodeConfiguration? nodeConfiguration;
  bool isAvailable;
  ArtNetNode({
    required this.ipAddress,
    required this.longName,
    required this.shortName,
    required this.macAddress,
    required this.dhcpCapable,
    required this.dhcpEnabled,
    this.isAvailable = false,
    this.nodeConfiguration,
    this.netmask,
    this.gateWay,
  });
}
