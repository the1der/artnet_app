import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class GlassBox extends StatelessWidget {
  GlassBox({
    super.key,
    required this.child,
    required this.boxHeight,
    required this.boxWidth,
    this.boxColor,
  });
  Color? boxColor;
  Widget child;
  double boxWidth, boxHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxWidth,
      height: boxHeight,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4,
              sigmaY: 4,
            ),
          ),
          Container(
            width: boxWidth,
            height: boxHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.13),
              ),
              gradient: LinearGradient(
                colors: [
                  boxColor?.withOpacity(0.15) ?? Colors.white.withOpacity(0.15),
                  boxColor?.withOpacity(0.05) ?? Colors.white.withOpacity(0.05),
                ],
              ),
            ),
          ),
          Container(
            width: boxWidth,
            height: boxHeight,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: child,
          )
        ],
      ),
    );
  }
}

class GlassBoxTwo extends StatelessWidget {
  GlassBoxTwo({
    super.key,
    required this.child,
    required this.boxHeight,
    required this.boxWidth,
    this.boxColor,
  });
  Color? boxColor;
  Widget child;
  double boxWidth, boxHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxWidth,
      height: boxHeight,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4,
              sigmaY: 4,
            ),
          ),
          Container(
            width: boxWidth,
            height: boxHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: GradientBoxBorder(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Color(0xFF9EC474),
                  ],
                ),
              ),
              gradient: LinearGradient(
                colors: [
                  boxColor?.withOpacity(0.1) ?? Colors.white.withOpacity(0.15),
                  Colors.black.withOpacity(0.05),
                ],
              ),
            ),
          ),
          Container(
            width: boxWidth,
            height: boxHeight,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: child,
          )
        ],
      ),
    );
  }
}
