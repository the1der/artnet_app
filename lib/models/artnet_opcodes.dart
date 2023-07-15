import 'dart:ffi';

class Opcode {
  static const int opPoll = 0x2000;
  static const int opPollReply = 0x2100;
  static const int opDiagData = 0x2300;
  static const int opCommand = 0x2400;
  static const int opOutput = 0x5000;
  static const int opNzs = 0x5100;
  static const int opAddress = 0x6000;
  static const int opInput = 0x7000;
  static const int opTodRequest = 0x8000;
  static const int opTodData = 0x8100;
  static const int opTodControl = 0x8200;
  static const int opRdm = 0x8300;
  static const int opRdmSub = 0x8400;
  static const int opVideoSetup = 0xa010;
  static const int opVideopalette = 0xa020;
  static const int opVideoData = 0xa040;
  static const int opMacMaster = 0xf000;
  static const int opMacSlave = 0xf100;
  static const int opFirmwareMaster = 0xf200;
  static const int opFirmwareReply = 0xf300;
  static const int opFileTnMaster = 0xf400;
  static const int opFileFnMaster = 0xf500;
  static const int opFileFnReply = 0xf600;
  static const int opIpProg = 0xf800;
  static const int opIpProgReply = 0xf900;
  static const int opMedia = 0x9000;
  static const int opMediaPatch = 0x9100;
  static const int opMediaControl = 0x9200;
  static const int opMediaContrlReply = 0x9300;
  static const int opTimeCode = 0x9700;
  static const int opTimeSync = 0x9800;
  static const int opTrigger = 0x9900;
  static const int opDirectory = 0x9a00;
  static const int opDirectoryReply = 0x9b00;
}
