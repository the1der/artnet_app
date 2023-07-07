import 'dart:io';

class ArtNetNode {
  InternetAddress nodeIp;
  InternetAddress? netMask;
  String longName, shortName, macAddress;
  bool dhcpEnabled, dhcpCapable;

  ArtNetNode({
    required this.nodeIp,
    required this.longName,
    required this.shortName,
    required this.macAddress,
    required this.dhcpCapable,
    required this.dhcpEnabled,
  });
}
