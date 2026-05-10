import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/gradient_borders.dart';

// ignore: must_be_immutable
class GlassBox extends StatelessWidget {
  GlassBox({
    super.key,
    required this.child,
    required this.height,
    required this.width,
    this.boxColor,
  });
  Color? boxColor;
  Widget child;
  double width, height;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.transparent,
      ),
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
            clipBehavior: Clip.antiAlias,
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
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
            clipBehavior: Clip.antiAlias,
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: child,
          )
        ],
      ),
    );
  }
}

class GlassBoxTwo extends StatelessWidget {
  const GlassBoxTwo({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.boxColor,
    this.borderGradient,
    this.boxGradient,
    this.borderRadius,
    this.shape,
    this.padding,
  });
  final Color? boxColor;
  final Widget child;
  final double? width;
  final double? height;
  final Gradient? boxGradient;
  final Gradient? borderGradient;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape? shape;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
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
            width: width,
            height: height,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(30),
              shape: shape ?? BoxShape.rectangle,
              borderRadius: shape == BoxShape.circle
                  ? null
                  : borderRadius ?? BorderRadius.circular(20.r),
              border: GradientBoxBorder(
                gradient: borderGradient ??
                    const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 197, 255, 255),
                        Colors.cyan,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomLeft,
                    ),
              ),
              gradient: boxGradient ??
                  LinearGradient(
                    colors: [
                      boxColor?.withOpacity(0.1) ??
                          const Color.fromARGB(255, 197, 255, 255)
                              .withOpacity(0.15),
                      Colors.cyan.withOpacity(0.05),
                    ],
                  ),
            ),
          ),
          Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 15.0),
            child: child,
          )
        ],
      ),
    );
  }
}
