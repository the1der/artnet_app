import 'package:flutter/material.dart';

class GradientBox extends StatelessWidget {
  GradientBox({
    super.key,
    required this.child,
  });
  Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: const [0.1, 0.5, 1],
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              const Color(0x00FFFFFF),
              const Color(0xFFF7B531).withOpacity(0.1),
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
