import 'dart:typed_data';
import 'dart:convert';

import 'package:artnet_app/services/artnet_module.dart';

class SynOutPacket {
  static const int opCode = 0xC000;

  final bool programmingEnabled;
  final SynOutOutputType? outputType;
  final SynOutColorModel? colorModel;
  final int cableSelect;
  final int? numberOfLeds;
  final int? ledsPerGroup;

  const SynOutPacket({
    required this.programmingEnabled,
    this.outputType,
    this.colorModel,
    this.cableSelect = 0,
    this.numberOfLeds,
    this.ledsPerGroup,
  });

  Uint8List toBytes() {
    final buffer = Uint8List(19);
    final data = ByteData.view(buffer.buffer);
    int offset = 0;

    final idBytes = utf8.encode(ArtNetModule.synProtocolID);
    buffer.setRange(offset, offset + idBytes.length, idBytes);
    offset += 10;

    data.setUint16(offset, opCode, Endian.little);
    offset += 2;

    data.setUint8(offset, programmingEnabled ? 1 : 0);
    offset += 1;

    // Output type (1 byte)
    data.setUint8(
        13, (outputType?.value ?? 0x00) | (outputType != null ? 0x80 : 0x00));
    offset += 1;

    // Color model (1 byte)
    data.setUint8(offset,
        (colorModel?.value ?? 0x00) | (colorModel != null ? 0x80 : 0x00));
    offset += 1;

    // Cable select (1 byte)
    data.setUint8(offset, cableSelect);
    offset += 1;

    // Number of LEDs (2 bytes)
    if (numberOfLeds != null) {
      data.setUint8(offset, ((numberOfLeds! >> 8) & 0xFF) | 0x80);
      data.setUint8(offset + 1, numberOfLeds! & 0xFF);
    } else {
      data.setUint16(offset, 0x0000, Endian.big);
    }
    offset += 2;

    // LEDs per group (1 byte)
    data.setUint8(
        offset, (ledsPerGroup ?? 0x00) | (ledsPerGroup != null ? 0x80 : 0x00));
    offset += 1;

    return buffer;
  }
}

enum SynOutOutputType {
  sk6812(0x00),
  sk6812Alt1(0x01),
  sk6812Alt2(0x02),
  unknown(0xFF);

  final int value;
  const SynOutOutputType(this.value);
}

enum SynOutColorModel {
  rgb(0x00),
  rgbw(0x01),
  rgbww(0x02),
  unknown(0xFF);

  final int value;
  const SynOutColorModel(this.value);
}
