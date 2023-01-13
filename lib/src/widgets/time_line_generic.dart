import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineGeneric extends StatelessWidget {
  const TimeLineGeneric({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<Widget> data;

  @override
  Widget build(BuildContext context) {
    const lineColor = Color.fromARGB(255, 71, 133, 255);
    return Row(
      children: data
          .asMap()
          .entries
          .map(
            (w) => SizedBox(
              width: 200,
              height: 80.0,
              child: TimelineTile(
                isFirst: w.key == 0,
                isLast: w.key == data.length -1,
                axis: TimelineAxis.horizontal,
                alignment: TimelineAlign.end,
                indicatorStyle: const IndicatorStyle(
                  color: lineColor,
                  height: 16 
                ),
                afterLineStyle: const LineStyle(
                  color: lineColor
                ),
                beforeLineStyle: const LineStyle(
                  color: lineColor 
                ),
                startChild: Container(
                  child: w.value,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
