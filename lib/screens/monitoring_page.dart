import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/chart_data.dart';
import '../widgets/status_card.dart';

class MonitoringPage extends StatefulWidget {
  @override
  _MonitoringPageState createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  List<ChartData> data = [];
  double suhu = 0.0, kekeruhan = 0.0;
  late TooltipBehavior _tooltipBehavior; // Tooltip instance

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true, // Enable tooltip
      tooltipPosition: TooltipPosition.pointer, // Tooltip will appear near the pointer
      duration: 2, // Duration before tooltip disappears
    );
    fetchDataFromFirebase();
  }

  Future<void> fetchDataFromFirebase() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('sensor_data');
    DataSnapshot snapshot = await ref.get();

    if (snapshot.exists && snapshot.value is List) {
      List<dynamic> values = snapshot.value as List<dynamic>;
      List<ChartData> tempData = [];
      double latestSuhu = 0.0, latestKekeruhan = 0.0;

      for (var value in values) {
        if (value != null && value is Map) {
          DateTime? timestamp = value['ts'] is String
              ? DateTime.tryParse(value['ts'])
              : null;
          double suhu = value['suhu']?.toDouble() ?? 0.0;
          double kekeruhan = value['kekeruhan']?.toDouble() ?? 0.0;

          if (timestamp != null) {
            tempData.add(ChartData(timestamp, suhu, kekeruhan));
            latestSuhu = suhu;
            latestKekeruhan = kekeruhan;
          }
        }
      }

      // Sort data by timestamp in descending order (latest first)
      tempData.sort((a, b) => b.time.compareTo(a.time));

      // Take the latest 10 entries
      tempData = tempData.take(10).toList();

      setState(() {
        data = tempData;
        suhu = latestSuhu;
        kekeruhan = latestKekeruhan;
      });
    } else {
      debugPrint("Data is not a List or doesn't exist.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Smart Garden"),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Text("Monitoring", style: TextStyle(fontSize: 20)),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                height: 250,
                width: MediaQuery.of(context).size.width * 0.9,
                child: data.isNotEmpty
                    ? SfCartesianChart(
                        primaryXAxis: DateTimeAxis(
                          intervalType: DateTimeIntervalType.hours,
                          dateFormat: DateFormat.Hm(),
                          title: AxisTitle(text: 'Jam'),
                        ),
                        primaryYAxis: NumericAxis(
                          minimum: 0, // Set minimum value to 0
                          maximum: data.isNotEmpty
                              ? data.map((d) => d.suhu).reduce((a, b) => a > b ? a : b) + 5
                              : 50,
                          interval: 5, // Interval for the Y-axis
                          title: AxisTitle(text: 'Nilai'),
                        ),
                        legend: Legend(isVisible: true, position: LegendPosition.top),
                        tooltipBehavior: _tooltipBehavior, // Add tooltip behavior
                        series: <CartesianSeries>[
                          LineSeries<ChartData, DateTime>(
                            name: 'Suhu',
                            dataSource: data,
                            xValueMapper: (ChartData data, _) => data.time,
                            yValueMapper: (ChartData data, _) => data.suhu,
                            markerSettings: MarkerSettings(isVisible: true, color: Colors.white),
                            color: Colors.red,
                          ),
                          LineSeries<ChartData, DateTime>(
                            name: 'Kekeruhan',
                            dataSource: data,
                            xValueMapper: (ChartData data, _) => data.time,
                            yValueMapper: (ChartData data, _) => data.kekeruhan,
                            markerSettings: MarkerSettings(isVisible: true, color: Colors.white),
                            color: Colors.blue,
                          ),
                        ],
                      )
                    : Center(child: CircularProgressIndicator()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatusCard(
                    title: "Suhu",
                    value: "${suhu.toStringAsFixed(1)} °C",
                    icon: Icons.thermostat,
                  ),
                  StatusCard(
                    title: "Kekeruhan",
                    value: "${kekeruhan.toStringAsFixed(1)} NTU",
                    icon: Icons.opacity,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
