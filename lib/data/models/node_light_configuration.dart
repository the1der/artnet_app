import 'dart:convert';

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
    required this.pattern,
  });

  int? id;
  List<PatternSlice> pattern;

  /// Convert `PatternConfigParameters` to a Map for database storage.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pattern': jsonEncode(pattern.map((e) => e.toMap()).toList()),
    };
  }

  /// Create `PatternConfigParameters` from a Map retrieved from the database.
  factory PatternConfigParameters.fromMap(Map<String, dynamic> map) {
    return PatternConfigParameters(
      id: map['id'] as int?,
      pattern: (jsonDecode(map['pattern']) as List<dynamic>)
          .map((e) => PatternSlice.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  bool isEqual(PatternConfigParameters opperand) {
    if (opperand.pattern.length != pattern.length) {
      return false;
    } else {
      for (int i = 0; i < pattern.length; i++) {
        if (opperand.pattern[i] != pattern[i]) return false;
      }
    }
    return true;
  }
}

class PatternSlice {
  PatternSlice({
    required this.color,
    required this.length,
  });

  Color color;
  int length;

  Map<String, dynamic> toMap() {
    return {
      'color': color.value,
      'length': length,
    };
  }

  factory PatternSlice.fromMap(Map<String, dynamic> map) {
    return PatternSlice(
      color: Color(map['color']),
      length: map['length'],
    );
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
