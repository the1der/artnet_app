import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetMaskSeparator extends StatelessWidget {
  NetMaskSeparator({super.key, required this.netMask});
  InternetAddress netMask;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width * 0.95,
      width: 0.95.sw,
      child: Padding(
        padding: EdgeInsets.only(top: 0.015.sh, bottom: 0.005.sh),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 0.01.sw,
            ),
            Text(
              netMask.address,
              style: TextStyle(
                fontSize: 45.sp,
                fontWeight: FontWeight.w100,
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
              child: Container(
                height: 0.001.sh,
                // height: 1,
                color: Colors.white,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
