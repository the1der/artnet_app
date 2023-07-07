import 'dart:ui';
import 'package:artnet_app/models/node_info.dart';
import 'package:artnet_app/screens/home/widgets/glass_box.dart';
import 'package:flutter/material.dart';

class NodeBox extends StatelessWidget {
  ArtNetNode artNetNode;
  NodeBox({super.key, required this.artNetNode});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
      child: GlassBox(
        boxWidth: MediaQuery.of(context).size.width * 0.95,
        boxHeight: MediaQuery.of(context).size.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  artNetNode.shortName,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  artNetNode.macAddress,
                  style: const TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 18,
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  artNetNode.nodeIp.address,
                  style: const TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 18,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "DHCP: ",
                    style: const TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 18,
                    ),
                    children: [
                      artNetNode.dhcpEnabled
                          ? const TextSpan(
                              text: "ON",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            )
                          : TextSpan(
                              text: "OFF",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.red[700],
                              ),
                            ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
