import 'dart:io';

import 'package:artnet_app/models/node_info.dart';
import 'package:artnet_app/screens/home/home_bloc.dart';
import 'package:artnet_app/screens/home/home_event.dart';
import 'package:artnet_app/screens/home/home_state.dart';
import 'package:artnet_app/screens/home/widgets/glass_box.dart';
import 'package:artnet_app/screens/home/widgets/gradient_box.dart';
import 'package:artnet_app/screens/home/widgets/netmask_separator.dart';
import 'package:artnet_app/screens/home/widgets/node_box.dart';
import 'package:artnet_app/services/artnet_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  List<Widget> createNodeList(List<ArtNetNode> nodeList) {
    List<NodeBox> nodeBoxList = [];
    for (int i = 0; i < nodeList.length; i++) {
      nodeBoxList.add(NodeBox(artNetNode: nodeList[i]));
    }
    return nodeBoxList;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
              body: GradientBox(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 0.10.sh,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ShaderMask(
                          child: Icon(
                            Icons.token_outlined,
                            size: 0.1.sw,
                            color: Colors.white,
                          ),
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: <Color>[
                                Theme.of(context).colorScheme.primary,
                                const Color(0xFF9EC474),
                              ],
                            ).createShader(bounds);
                          },
                        ),
                        SizedBox(
                          width: 0.025.sw,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: state is HomeInitial ? 0.1 : 0.7.sh,
                    child: SingleChildScrollView(
                      child: state is ArtNetNoFoundNodes
                          ? Container(
                              height: 0.40.sw,
                              width: 0.40.sw,
                              color: Colors.white,
                              child: const Text("No Nodes"),
                            )
                          : state is ArtNetFoundNodes
                              ? Column(
                                  children:
                                      createNodeList(ArtNetModule.scanResults),
                                )
                              : Container(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 0.15.sh,
                    child: InkWell(
                      child: GlassBoxTwo(
                        boxWidth: 0.4.sw,
                        boxHeight: 0.07.sh,
                        boxColor: Theme.of(context).colorScheme.primary,
                        child: ShaderMask(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "SCAN",
                                style: TextStyle(
                                  // color: Theme.of(context).colorScheme.primary,
                                  fontSize: 70.sp,
                                ),
                              ),
                              Icon(
                                Icons.wifi_find,
                                size: 0.065.sw,
                                // color: Theme.of(context).colorScheme.primary,
                              )
                            ],
                          ),
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: <Color>[
                                Theme.of(context).colorScheme.primary,
                                const Color(0xFF9EC474),
                              ],
                            ).createShader(bounds);
                          },
                        ),
                      ),
                      onTap: () {
                        context.read<HomeBloc>().add(ArtNetStartScan());
                      },
                    ),
                  )
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
