import 'package:artnet_app/screens/home/widgets/gradient_box.dart';
import 'package:artnet_app/screens/home/widgets/node_box.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GradientBox(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            NodeBox(),
            SizedBox(
              height: 20,
            ),
            NodeBox(),
          ],
        ),
      ),
    ));
  }
}
