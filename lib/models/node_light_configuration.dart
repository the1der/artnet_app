import 'package:flutter/material.dart';

class NodeLightConfiguration {}

class SolidColorConfigParameters extends NodeLightConfiguration {
  SolidColorConfigParameters({required this.color});
  Color color;
}
