import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NetMaskSeparator extends StatelessWidget {
  NetMaskSeparator({super.key, required this.netMask});
  InternetAddress netMask;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 5,
            ),
            Text(
              netMask.address,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w100,
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 1,
                color: Colors.white,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
