import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          body: Builder(builder: (context) {
            return VitalityUtterancesComboChart.withSampleData();
          }),
        ),
      ),
    );

class VitalityUtterancesComboChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  VitalityUtterancesComboChart(this.seriesList, {this.animate});

  factory VitalityUtterancesComboChart.withSampleData() {
    return VitalityUtterancesComboChart(
      _createSampleData(),
      animate: false,
    );ｇ
  }

  @override
  Widget build(BuildContext context) {
    return charts.OrdinalComboChart(seriesList,
        animate: animate,
        layoutConfig: charts.LayoutConfig(
            leftMarginSpec: charts.MarginSpec.fixedPixel(20),
            topMarginSpec: null,
            bottomMarginSpec: null,
            rightMarginSpec: null),
        defaultRenderer: charts.BarRendererConfig(
          strokeWidthPx: 10,
          groupingType: charts.BarGroupingType.grouped,
        ),
        customSeriesRenderers: [
          charts.LineRendererConfig(customRendererId: 'customLine')
        ]);
  }

  static List<charts.Series<TimeSeriesValue, String>> _createSampleData() {
    final tablevalueData = [
      TimeSeriesValue('2014', 5),
      TimeSeriesValue('2015', 25),
      TimeSeriesValue('2016', 100),
      TimeSeriesValue('2017', 75),
      TimeSeriesValue('2018', 25),
      TimeSeriesValue('2019', 100),
      TimeSeriesValue('2020', 75),
    ];

    final mobileevalueData = [
      TimeSeriesValue('2014', 15),
      TimeSeriesValue('2015', 55),
      TimeSeriesValue('2016', 300),
      TimeSeriesValue('2017', 400),
      TimeSeriesValue('2018', 55),
      TimeSeriesValue('2019', 300),
      TimeSeriesValue('2020', 400),
    ];

    return [
      charts.Series<TimeSeriesValue, String>(
          id: 'utterances',
          colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
          domainFn: (TimeSeriesValue value, _) => value.dataTime,
          measureFn: (TimeSeriesValue value, _) => value.value,
          data: tablevalueData),
      charts.Series<TimeSeriesValue, String>(
          id: 'vitality',
          colorFn: (TimeSeriesValue sales, _) =>
              charts.Color(r: 61, g: 164, b: 181),
          domainFn: (TimeSeriesValue value, _) => value.dataTime,
          measureFn: (TimeSeriesValue value, _) => value.value,
          data: mobileevalueData)
        // Configure our custom line renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customLine'),
    ];
  }
}

class TimeSeriesValue {
  TimeSeriesValue(this.dataTime, this.value);

  final String dataTime;
  final int value;
}
