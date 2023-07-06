import 'dart:io';

class Node {
  InternetAddress nodeIp;
  InternetAddress? netMask;
  String longName, shortName, macAddress;
  bool dhcpEnabled, dhcpCapable;

  Node({
    required this.nodeIp,
    required this.longName,
    required this.shortName,
    required this.macAddress,
    required this.dhcpCapable,
    required this.dhcpEnabled,
  });
}
