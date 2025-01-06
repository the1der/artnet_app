import 'package:flutter/material.dart';

class NodeLightConfiguration {}

class SolidColorConfigParameters extends NodeLightConfiguration {
  SolidColorConfigParameters({
    required this.color,
    this.id,
  });
  Color color;
  int? id;

  factory SolidColorConfigParameters.fromMap(Map<String, dynamic> map) {
    return SolidColorConfigParameters(
      id: map['id'] as int?,
      color: Color(map['color'] as int),
    );
  }

  // Converts a User object into a map (used when inserting/updating data in a database or API)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'color': color.value,
    };
  }
}

class PatternConfigParameters extends NodeLightConfiguration {
  PatternConfigParameters({
    this.id,
  });
  int? id;

  factory PatternConfigParameters.fromMap(Map<String, dynamic> map) {
    return PatternConfigParameters(
      id: map['id'] as int?,
    );
  }

  // Converts a User object into a map (used when inserting/updating data in a database or API)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}

class GradientConfigParameters extends NodeLightConfiguration {
  GradientConfigParameters({
    this.id,
  });
  int? id;

  factory GradientConfigParameters.fromMap(Map<String, dynamic> map) {
    return GradientConfigParameters(
      id: map['id'] as int?,
    );
  }

  // Converts a User object into a map (used when inserting/updating data in a database or API)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}
