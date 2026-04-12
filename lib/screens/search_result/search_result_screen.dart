import 'dart:io';

import 'package:artnet_app/data/models/node_light_configuration.dart';
import 'package:artnet_app/data/models/node_info.dart';
import 'package:artnet_app/screens/home/widgets/glass_box.dart';
import 'package:artnet_app/screens/home/widgets/node_box.dart';
import 'package:artnet_app/services/artnet_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  List<Widget> nodeWidgetsList = [];
  List<ArtNetNode> nodesList =
      []; // TODO : replace by ArtnetModule.searchResult

  List<Widget> createNodesList(List<ArtNetNode> nodesList) {
    List<NodeBox> nodeBoxList = [];
    for (ArtNetNode artNetNode in nodesList) {
      nodeBoxList.add(NodeBox(artNetNode: artNetNode));
    }
    return nodeBoxList;
  }

  @override
  void initState() {
    super.initState();
    nodesList = ArtNetModule.scanResults;
    nodeWidgetsList = createNodesList(nodesList);
  }

  @override
  Widget build(BuildContext context) {
    nodeWidgetsList = createNodesList(nodesList);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Available nodes",
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: 1.sh,
          width: 1.sw,
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.bottomLeft,
            //   end: Alignment.topRight,
            //   colors: <Color>[
            //     Theme.of(context).colorScheme.primary.withAlpha(50),
            //     Theme.of(context).colorScheme.surface.withAlpha(10),
            //   ],
            // ),
            color: Theme.of(context).colorScheme.surface.withAlpha(255),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 0.075.sh,
                width: 0.95.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GlassBoxTwo(
                      height: 0.05.sh,
                      width: 0.05.sh,
                      borderRadius: BorderRadius.circular(10.r),
                      padding: EdgeInsets.zero,
                      borderGradient: LinearGradient(
                        colors: [
                          Colors.white.withAlpha(192),
                          Colors.white.withAlpha(77),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxGradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary.withAlpha(25),
                          Colors.white.withAlpha(5),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      child: Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                    SizedBox(
                      width: 0.01.sw,
                    ),
                    GlassBoxTwo(
                      height: 0.05.sh,
                      width: 0.05.sh,
                      borderRadius: BorderRadius.circular(10.r),
                      padding: EdgeInsets.zero,
                      borderGradient: LinearGradient(
                        colors: [
                          Colors.white.withAlpha(192),
                          Colors.white.withAlpha(77),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxGradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary.withAlpha(25),
                          Colors.white.withAlpha(5),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      child: Icon(
                        Icons.sort_outlined,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: nodeWidgetsList,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
