import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/chart_data.dart';

class GrafikSection extends StatelessWidget {
  final String title;
  final String minMaxInfo;
  final List<ChartData> chartData;
  final String xAxisLabelFormat;
  final String selectedPeriod;

  GrafikSection({
    required this.title,
    required this.minMaxInfo,
    required this.chartData,
    required this.xAxisLabelFormat,
    required this.selectedPeriod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            minMaxInfo,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 8),
          Container(
            height: 200,
            child: SfCartesianChart(
              legend: Legend(isVisible: true, position: LegendPosition.top),
              tooltipBehavior: TooltipBehavior(
                enable: true, // Aktifkan tooltip
                header: 'Detail', // Judul tooltip
                format: 'point.x : point.y', // Format untuk menampilkan data
              ),
              primaryXAxis: selectedPeriod == 'Per Hari'
                  ? CategoryAxis()
                  : DateTimeAxis(
                      dateFormat: DateFormat(xAxisLabelFormat),
                      intervalType: DateTimeIntervalType.minutes,  // Menggunakan interval per menit
                      interval: 30, // Menampilkan data setiap 30 menit
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      labelRotation: 45,
                    ),
              primaryYAxis: NumericAxis(minimum: 0, maximum: 50, interval: 10),
              series: <CartesianSeries>[
                LineSeries<ChartData, dynamic>(
                  name: 'Suhu',
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => selectedPeriod == 'Per Hari'
                      ? DateFormat('E').format(data.time)
                      : data.time,
                  yValueMapper: (ChartData data, _) => data.suhu,
                  markerSettings: MarkerSettings(isVisible: true),
                  color: Colors.red,
                ),
                LineSeries<ChartData, dynamic>(
                  name: 'Kekeruhan',
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => selectedPeriod == 'Per Hari'
                      ? DateFormat('E').format(data.time)
                      : data.time,
                  yValueMapper: (ChartData data, _) => data.kekeruhan,
                  markerSettings: MarkerSettings(isVisible: true),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
