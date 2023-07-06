import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NodeBox extends StatelessWidget {
  const NodeBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.08,
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
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.13),
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.15),
                  Colors.white.withOpacity(0.05),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.08,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Short Name HellAre",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "7B.9C.A4.D3.20.B0",
                      style: TextStyle(
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
                    const Text(
                      "192.168.1.2",
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 18,
                      ),
                    ),
                    RichText(
                      text: const TextSpan(
                        text: "DHCP: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                            text: "ON",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                // SizedBox(
                //   width: 10,
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
