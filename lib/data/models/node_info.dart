import 'dart:io';

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
    this.ledsPerGroup,
  }) {
    universe = (netSwitch << 8) | swIn0;
  }

  Map<String, dynamic> toMap() {
    return {
      'ipAddress': ipAddress.address,
      'netmask': netmask?.address ?? "XXX.XXX.XXX.XXX",
      'gateWay': gateWay?.address ?? "XXX.XXX.XXX.XXX",
      'macAddress': macAddress,
      'dhcpEnabled': dhcpEnabled ? 1 : 0,
      'dhcpCapable': dhcpCapable ? 1 : 0,
      'isAvailable': isAvailable ? 1 : 0,
      'longName': longName,
      'shortName': shortName,
      'swIn0': swIn0,
      'netSwitch': netSwitch,
      'universe': universe,
      'numberOfLeds': numberOfLeds ?? -1,
      'colorModel': colorModel?.toString() ?? 'unknown',
      'nodeOutputType': nodeOutputType?.toString() ?? 'unknown',
      'ledsPerGroup': ledsPerGroup ?? -1,
      'nodeLightConfiguration': nodeLightConfiguration != null
          ? nodeLightConfiguration!.toMap()
          : "unknown",
    };
  }

  factory ArtNetNode.fromMap(Map<String, dynamic> map) {
    return ArtNetNode(
      ipAddress: InternetAddress(map['ipAddress']),
      netmask: InternetAddress(map['netmask']),
      gateWay: InternetAddress(map['gateWay']),
      macAddress: map['macAddress'],
      dhcpEnabled: map['dhcpEnabled'] == 1,
      dhcpCapable: map['dhcpCapable'] == 1,
      isAvailable: map['isAvailable'] == 1,
      longName: map['longName'],
      shortName: map['shortName'],
      swIn0: map['swIn0'],
      netSwitch: map['netSwitch'],
      universe: map['universe'],
      numberOfLeds: map['numberOfLeds'] != -1 ? map['numberOfLeds'] : null,
      colorModel: SynOutColorModel.values.firstWhere(
          (e) => e.toString() == map['colorModel'],
          orElse: () => SynOutColorModel.unknown),
      nodeOutputType: SynOutOutputType.values.firstWhere(
          (e) => e.toString() == map['nodeOutputType'],
          orElse: () => SynOutOutputType.unknown),
      ledsPerGroup: map['ledsPerGroup'] != -1 ? map['ledsPerGroup'] : null,
      nodeLightConfiguration: map['nodeLightConfiguration'] != "unknown"
          ? NodeLightConfiguration.fromMap(
              Map<String, dynamic>.from(map['nodeLightConfiguration']))
          : null,
    );
  }
}
