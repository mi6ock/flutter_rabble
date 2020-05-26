import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:charts_flutter/src/text_element.dart' as ChartText;
import 'package:charts_flutter/src/text_style.dart' as ChartStyle;
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  await initializeDateFormatting('ja_JP');
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(),
      body: Builder(builder: (context) {
        return TimeSeriesRangeAnnotationMarginChart.withSampleData();
      }),
    ),
  ));
}

class TimeSeriesRangeAnnotationMarginChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  final Size size = Size(300, 250);

  TimeSeriesRangeAnnotationMarginChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory TimeSeriesRangeAnnotationMarginChart.withSampleData() {
    return new TimeSeriesRangeAnnotationMarginChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(seriesList,
        animate: animate,
        primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec: new charts.BasicNumericTickProviderSpec(
            zeroBound: false,
            dataIsInWholeNumbers: true,
          ),
        ),
        layoutConfig: new charts.LayoutConfig(
            leftMarginSpec: new charts.MarginSpec.fixedPixel(20),
            topMarginSpec: new charts.MarginSpec.fixedPixel(10),
            rightMarginSpec: new charts.MarginSpec.fixedPixel(10),
            bottomMarginSpec: new charts.MarginSpec.fixedPixel(10)),
        domainAxis: charts.DateTimeAxisSpec(
          tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
            day: charts.TimeFormatterSpec(format: 'd', transitionFormat: 'dd'),
          ),
        ),
        behaviors: [
          // Define one domain and two measure annotations configured to render
          // labels in the chart margins.
          new charts.LinePointHighlighter(
              symbolRenderer: CustomCircleSymbolRenderere()),
          new charts.SelectNearest(
              eventTrigger: charts.SelectionTrigger.tapAndDrag),
//          new charts.RangeAnnotation([
//            new charts.RangeAnnotationSegment(
//              33,
//              67,
//              charts.RangeAnnotationAxisType.measure,
//              labelDirection: charts.AnnotationLabelDirection.vertical,
//              labelAnchor: charts.AnnotationLabelAnchor.end,
//              color: Color(r: 253, g: 247, b: 219),
//            ),
//          ],
          new charts.RangeAnnotation([
            new charts.RangeAnnotationSegment(
              48,
              67,
              charts.RangeAnnotationAxisType.measure,
              labelDirection: charts.AnnotationLabelDirection.vertical,
              labelAnchor: charts.AnnotationLabelAnchor.end,
              color: Color(r: 253, g: 247, b: 219),
            ),
          ], defaultLabelPosition: charts.AnnotationLabelPosition.margin),
        ],
        selectionModels: [
          charts.SelectionModelConfig(
              changedListener: (charts.SelectionModel model) {
            // StringからDate

            var formatter = DateFormat('yyyy/MM/dd(E)\n HH:mm', "ja_JP");
            var formatted = formatter
                .format(model.selectedDatum[0].datum.time); // DateからString
            if (model.hasDatumSelection) {
              ToolTipMgre.setTitle({
                'time': '${formatted}',
                'mentalacitivity':
                    '${model.selectedDatum[0].datum.mentalActivity}'
              });
            }
          })
        ]);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2017, 10, 11), 50),
      new TimeSeriesSales(new DateTime(2017, 10, 12), 51),
      new TimeSeriesSales(new DateTime(2017, 10, 13), 54),
      new TimeSeriesSales(new DateTime(2017, 10, 14), 55),
      new TimeSeriesSales(new DateTime(2017, 10, 15), 56),
      new TimeSeriesSales(new DateTime(2017, 10, 16), 59),
      new TimeSeriesSales(new DateTime(2017, 10, 17), 61),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.mentalActivity,
        data: data,
        colorFn: (TimeSeriesSales sales, _) => Color(r: 61, g: 164, b: 181),
      )
    ];
  }
}

class CustomCircleSymbolRenderere extends CircleSymbolRenderer {
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

    textStyle.color = Color.black;
    textStyle.fontSize = 12;
    double control = 0;

    if (bounds.left < 43) {
      control = 43;
    } else if (bounds.left > 280) {
      control = -43;
    }

    print(bounds);
    print(control);
    canvas.drawRRect(
        Rectangle(bounds.left - 35 + control, bounds.top + 10,
            bounds.width + 86, bounds.height + 50),
        fill: Color(r: 222, g: 222, b: 222),
        stroke: Color.black,
        roundTopLeft: true,
        roundBottomLeft: true,
        roundBottomRight: true,
        roundTopRight: true,
        radius: 6.0);

    canvas.drawText(
        ChartText.TextElement(
            "${ToolTipMgre.time}\n心の活量値\n${ToolTipMgre.mentalacitivity} mimo",
            style: textStyle),
        (bounds.left - 30 + control).round(),
        (bounds.top + 18).round());
  }
}

class ToolTipMgre {
  static String time;
  static String mentalacitivity;

  static setTitle(Map<String, dynamic> data) {
    if (data['time'] != null && data['time'].length > 0) {
      time = data['time'];
    }

    if (data['mentalacitivity'] != null && data['mentalacitivity'].length > 0) {
      mentalacitivity = data['mentalacitivity'];
    }
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int mentalActivity;

  TimeSeriesSales(this.time, this.mentalActivity);
}
