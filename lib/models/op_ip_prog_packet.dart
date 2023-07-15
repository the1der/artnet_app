import 'dart:io';

class OpIpProgPacket {
  InternetAddress? ip, netMask, gateWay;
  bool? enableDHCP, resetValues;

  OpIpProgPacket({
    this.ip,
    this.gateWay,
    this.netMask,
    this.enableDHCP,
    this.resetValues,
  });
}
