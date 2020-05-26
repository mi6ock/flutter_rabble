import 'dart:math' hide log;

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:charts_flutter/src/text_element.dart' as ChartText;
import 'package:charts_flutter/src/text_style.dart' as ChartStyle;
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Builder(builder: (context) {
          return StackedBarChart.withSampleData();
        }),
      ),
    ));

class StackedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedBarChart(this.seriesList, {this.animate});

  /// Creates a stacked [BarChart] with sample data and no transition.
  factory StackedBarChart.withSampleData() {
    return StackedBarChart(
      _createSampleData(),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: charts.BarChart(
        seriesList,
        animate: animate,
        barGroupingType: charts.BarGroupingType.stacked,
        behaviors: [
          new charts.LinePointHighlighter(
              symbolRenderer: CustomCircleSymbolRenderer()),
          new charts.SelectNearest(
              eventTrigger: charts.SelectionTrigger.tapAndDrag)
        ],
        selectionModels: [
          charts.SelectionModelConfig(
            type: charts.SelectionModelType.info,
            changedListener: (charts.SelectionModel model) {
              if (model.hasDatumSelection) {
                ToolTipMgr.setTitle({
                  'workingTime': '${model.selectedDatum[0].datum.time}',
                  'overtime': '${model.selectedDatum[1].datum.time}'
                });
              }
            },
          )
        ],
      ),
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<WorkingHours, String>> _createSampleData() {
    final desktopSalesData = [
      WorkingHours('1', 1, 160),
      WorkingHours('1', 2, 152),
      WorkingHours('1', 3, 140),
      WorkingHours('1', 4, 162),
      WorkingHours('1', 5, 160),
      WorkingHours('1', 6, 152),
      WorkingHours('1', 7, 140),
      WorkingHours('1', 8, 162),
      WorkingHours('1', 9, 160),
      WorkingHours('1', 10, 152),
      WorkingHours('1', 11, 140),
      WorkingHours('1', 12, 162),
    ];

    final tableSalesData = [
      WorkingHours('2', 1, 10),
      WorkingHours('2', 2, 50),
      WorkingHours('2', 3, 90),
      WorkingHours('2', 4, 162),
      WorkingHours('2', 5, 0),
      WorkingHours('2', 6, 0),
      WorkingHours('2', 7, 0),
      WorkingHours('2', 8, 80),
      WorkingHours('2', 9, 1),
      WorkingHours('2', 10, 152),
      WorkingHours('2', 11, 30),
      WorkingHours('2', 12, 0),
    ];

    return [
      charts.Series<WorkingHours, String>(
        id: 'overtime',
        domainFn: (WorkingHours hours, _) => hours.month.toString(),
        measureFn: (WorkingHours hours, _) => hours.time,
        data: tableSalesData,
        fillColorFn: (WorkingHours hours, _) => Color(r: 255, g: 0, b: 0),
      ),
      charts.Series<WorkingHours, String>(
        id: 'working',
        domainFn: (WorkingHours hours, _) => hours.month.toString(),
        measureFn: (WorkingHours hours, _) => hours.time,
        data: desktopSalesData,
        fillColorFn: (WorkingHours hours, _) => Color(r: 0, g: 255, b: 0),
      ),
    ];
  }
}

class ToolTipMgr {
  static String type;
  static String workingTime;
  static String overtime;

  static setTitle(Map<String, dynamic> data) {
    if (data['type'] != null && data['type'].length > 0) {
      type = data['type'];
    }

    if (data['workingTime'] != null && data['workingTime'].length > 0) {
      workingTime = data['workingTime'];
    }

    if (data['overtime'] != null && data['overtime'].length > 0) {
      overtime = data['overtime'];
    }
  }
}

class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  double height = 100;
  double pointY = 0;
  double pointX = 0;

  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      Color fillColor,
      FillPatternType fillPattern,
      Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);

    ChartStyle.TextStyle textStyle = ChartStyle.TextStyle();

    textStyle.color = Color.white;
    textStyle.fontSize = 15;

    // ラベルを描写
    if (pointX != bounds.left) {
      pointX = bounds.left;
      pointY = bounds.top;
    } else if (pointX == bounds.left) {
      canvas.drawRRect(
          Rectangle(
              bounds.left - 5, pointY, bounds.width + 50, bounds.height + 10),
          fill: Color.black,
          roundTopLeft: true,
          roundBottomLeft: true,
          roundBottomRight: true,
          roundTopRight: true,
          radius: 6.0);

      canvas.drawText(
          ChartText.TextElement(ToolTipMgr.workingTime, style: textStyle),
          (bounds.left).round(),
          (pointY).round());
      if (int.parse(ToolTipMgr.overtime) > 0) {
        var pointSet = 0;
        if (bounds.top - pointY < 10) pointSet = 20;
        canvas.drawRRect(
            Rectangle(bounds.left - 5, bounds.top - pointSet, bounds.width + 50,
                bounds.height + 10),
            fill: Color.black,
            roundTopLeft: true,
            roundBottomLeft: true,
            roundBottomRight: true,
            roundTopRight: true,
            radius: 6.0);

        canvas.drawText(
            ChartText.TextElement(ToolTipMgr.overtime, style: textStyle),
            (bounds.left).round(),
            (bounds.top + 2 - pointSet).round());
      } else {
        canvas.drawRRect(
          Rectangle(bounds.left - 5, bounds.top, bounds.width + 50,
              bounds.height + 10),
          fill: Color.black,
          roundTopLeft: true,
          roundBottomLeft: true,
          roundBottomRight: true,
          roundTopRight: true,
          radius: 6.0,
        );

        canvas.drawText(
            ChartText.TextElement(ToolTipMgr.workingTime, style: textStyle),
            (bounds.left).round(),
            (bounds.top + 2).round());
      }
    }
  }
}

class WorkingHours {
  WorkingHours(
    this.type,
    this.month,
    this.time,
  );

  final String type;
  final int month;
  final int time;
}
