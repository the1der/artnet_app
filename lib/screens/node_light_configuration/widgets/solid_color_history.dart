import 'package:artnet_app/data/models/node_light_configuration.dart';
import 'package:artnet_app/domain/repositories/solid_config_history_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SolidColorHistory extends StatefulWidget {
  SolidColorHistory({
    super.key,
    required this.onConfigSelected,
    required this.historyList,
  });
  Function(SolidColorConfigParameters) onConfigSelected;
  List<SolidColorConfigParameters> historyList;

  @override
  State<SolidColorHistory> createState() => _SolidColorHistoryState();
}

class _SolidColorHistoryState extends State<SolidColorHistory> {
  List<Widget> historyWidgets = [];

  void fillWidgets(BuildContext context) {
    historyWidgets = [];

    for (SolidColorConfigParameters configuration in widget.historyList) {
      historyWidgets.add(
        Padding(
          padding: EdgeInsets.all(0.005.sh),
          child: InkWell(
            borderRadius: BorderRadius.circular(
              12.r,
            ),
            child: Container(
              height: 0.04.sh,
              width: 0.04.sh,
              decoration: BoxDecoration(
                  color: configuration.color,
                  borderRadius: BorderRadius.circular(
                    12.r,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: configuration.color.withOpacity(0.6), // Glow color
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ]),
            ),
            onTap: () {
              widget.onConfigSelected(configuration);
            },
          ),
        ),
      );
    }
    historyWidgets = historyWidgets.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    fillWidgets(context);
    return SizedBox(
      height: 0.075.sh,
      width: 0.95.sw,
      child: Row(
        children: [
          GestureDetector(
            onLongPress: () async {
              SolidColorHistortyRepositoryImpl().clearHistory();
              setState(() {});
            },
            child: SizedBox(
              height: 0.075.sh,
              width: 0.075.sh,
              child: Icon(
                Icons.history_rounded,
                color: Theme.of(context).colorScheme.onSurface,
                size: 0.04.sh,
              ),
            ),
          ),
          SizedBox(
            width: 0.95.sw - 0.075.sh,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: historyWidgets,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
