import 'package:artnet_app/data/models/node_light_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SolidColorHistory extends StatelessWidget {
  SolidColorHistory({
    super.key,
    required this.onConfigSelected,
  });
  Function(SolidColorConfigParameters) onConfigSelected;
  List<SolidColorConfigParameters> historyList = [
    SolidColorConfigParameters(color: Colors.red),
    SolidColorConfigParameters(color: Colors.amber),
    SolidColorConfigParameters(color: Colors.green),
    SolidColorConfigParameters(color: Colors.blue),
    SolidColorConfigParameters(color: Colors.pink),
    SolidColorConfigParameters(color: Colors.purple),
    SolidColorConfigParameters(color: Colors.orange),
    SolidColorConfigParameters(color: Colors.cyan),
  ];
  List<Widget> historyWidgets = [];
  void fillWidgets(BuildContext context) {
    historyWidgets = [];

    historyList.forEach((configuration) {
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
              ),
            ),
            onTap: () {
              onConfigSelected(configuration);
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    fillWidgets(context);
    return Container(
      height: 0.075.sh,
      width: 0.95.sw,
      child: Row(
        children: [
          Container(
            height: 0.075.sh,
            width: 0.075.sh,
            child: Icon(
              Icons.history_rounded,
              color: Theme.of(context).colorScheme.onSurface,
              size: 0.04.sh,
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
