import 'dart:ui';
import 'package:artnet_app/models/node_info.dart';
import 'package:artnet_app/screens/home/widgets/glass_box.dart';
import 'package:artnet_app/screens/node_light_configuration/node_light_configuration_screen.dart';
import 'package:artnet_app/screens/node_settings/node_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NodeBox extends StatefulWidget {
  ArtNetNode artNetNode;
  NodeBox({super.key, required this.artNetNode});

  @override
  State<NodeBox> createState() => _NodeBoxState();
}

class _NodeBoxState extends State<NodeBox> {
  bool _isExpanded = false;
  bool _showExtraInfo = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.01.sh),
      child: InkWell(
        onTap: () {
          _isExpanded = !_isExpanded;
          if (!_isExpanded) _showExtraInfo = false;
          setState(() {});
        },
        borderRadius: BorderRadius.circular(15.r),
        child: AnimatedContainer(
          width: 0.95.sw,
          height: _isExpanded ? 0.16.sh : 0.08.sh,
          duration: Duration(milliseconds: 300),
          onEnd: () {
            if (_isExpanded) _showExtraInfo = true;

            setState(() {});
          },
          padding: EdgeInsets.symmetric(
            vertical: 0.015.sh,
            horizontal: 0.035.sw,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: widget.artNetNode.isAvailable
                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.05)
                : Colors.grey.withOpacity(0.1),
            border: Border(
              left: BorderSide(
                color: !widget.artNetNode.isAvailable
                    ? Colors.grey
                    : widget.artNetNode.nodeConfiguration == null
                        ? Colors.amber
                        : Colors.green,
                width: 0.015.sw,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: _isExpanded
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  Text(
                    widget.artNetNode.shortName,
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  _showExtraInfo
                      ? Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "IP: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.sp,
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.artNetNode.ipAddress.address,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "MAC: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.sp,
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.artNetNode.macAddress,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "DHCP: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.sp,
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.artNetNode.dhcpEnabled
                                        ? "ON"
                                        : "OFF",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.sp,
                                      color: widget.artNetNode.dhcpEnabled
                                          ? Colors.green
                                          : Colors.red[700],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                ],
              ),
              SizedBox(
                child: Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(10.r),
                      child: GlassBoxTwo(
                        height: 0.05.sh,
                        width: 0.05.sh,
                        borderRadius: BorderRadius.circular(10.r),
                        padding: EdgeInsets.zero,
                        borderGradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.75),
                            Colors.white.withOpacity(0.3),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxGradient: LinearGradient(
                          colors: [
                            Colors.red.withOpacity(0.1),
                            Colors.white.withOpacity(0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        child: Icon(
                          Icons.lightbulb_outline_rounded,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NodeLightConfigurationScreen(
                              artNetNode: widget.artNetNode,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 0.02.sw,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(10.r),
                      child: GlassBoxTwo(
                        height: 0.05.sh,
                        width: 0.05.sh,
                        borderRadius: BorderRadius.circular(10.r),
                        padding: EdgeInsets.zero,
                        borderGradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.75),
                            Colors.white.withOpacity(0.3),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxGradient: LinearGradient(
                          colors: [
                            Colors.red.withOpacity(0.1),
                            Colors.white.withOpacity(0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        child: Icon(
                          Icons.settings_outlined,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NodeSettings(
                              artNetNode: widget.artNetNode,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
