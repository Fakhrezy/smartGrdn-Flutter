import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/grafik_section.dart';
import '../models/chart_data.dart';

class GrafikPage extends StatefulWidget {
  final List<ChartData> sensorDataList;

  GrafikPage({required this.sensorDataList});

  @override
  _GrafikPageState createState() => _GrafikPageState();
}

class _GrafikPageState extends State<GrafikPage> {
  String _selectedPeriod = 'Per Jam';

  @override
  Widget build(BuildContext context) {
    final maxValues = ChartData.getMaxValues(widget.sensorDataList);
    final minValues = ChartData.getMinValues(widget.sensorDataList);
    final avgValues = ChartData.getAvgValues(widget.sensorDataList);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Grafik Sensor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButton<String>(
                value: _selectedPeriod,
                icon: Icon(Icons.arrow_drop_down),
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPeriod = newValue!;
                  });
                },
                items: <String>['Per Jam', 'Per Hari']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 24),

              GrafikSection(
                title: "Grafik Maksimum",
                minMaxInfo: "Maksimum suhu: ${maxValues['suhu']}°C, Maksimum kekeruhan: ${maxValues['kekeruhan']}",
                chartData: _getData('max'),
                xAxisLabelFormat: _getXAxisFormat(),
                selectedPeriod: _selectedPeriod,  // Menambahkan selectedPeriod
              ),
              SizedBox(height: 24),

              GrafikSection(
                title: "Grafik Minimum",
                minMaxInfo: "Minimum suhu: ${minValues['suhu']}°C, Minimum kekeruhan: ${minValues['kekeruhan']}",
                chartData: _getData('min'),
                xAxisLabelFormat: _getXAxisFormat(),
                selectedPeriod: _selectedPeriod,  // Menambahkan selectedPeriod
              ),
              SizedBox(height: 24),

              GrafikSection(
                title: "Grafik Rata-Rata",
                minMaxInfo: "Rata-rata suhu: ${avgValues['suhu']}°C, Rata-rata kekeruhan: ${avgValues['kekeruhan']}",
                chartData: _getData('avg'),
                xAxisLabelFormat: _getXAxisFormat(),
                selectedPeriod: _selectedPeriod,  // Menambahkan selectedPeriod
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getXAxisFormat() {
    switch (_selectedPeriod) {
      case 'Per Jam':
        return 'HH:mm';
      case 'Per Hari':
        return 'E';
      default:
        return 'HH:mm';
    }
  }

  List<ChartData> _getData(String type) {
    Map<String, List<ChartData>> groupedData = _groupDataByPeriod();
    List<ChartData> resultData = [];

    groupedData.forEach((key, dataList) {
      double suhuResult = type == 'max' ? -double.infinity : (type == 'min' ? double.infinity : 0.0);
      double kekeruhanResult = type == 'max' ? -double.infinity : (type == 'min' ? double.infinity : 0.0);
      DateTime groupTime;

      if (_selectedPeriod == 'Per Hari') {
        groupTime = DateTime.now();
      } else {
        groupTime = DateFormat('yyyy-MM-dd HH').parse(key);
      }

      for (var data in dataList) {
        if (type == 'max') {
          if (data.suhu > suhuResult) suhuResult = data.suhu;
          if (data.kekeruhan > kekeruhanResult) kekeruhanResult = data.kekeruhan;
        } else if (type == 'min') {
          if (data.suhu < suhuResult) suhuResult = data.suhu;
          if (data.kekeruhan < kekeruhanResult) kekeruhanResult = data.kekeruhan;
        } else {
          suhuResult += data.suhu;
          kekeruhanResult += data.kekeruhan;
        }
      }

      if (type == 'avg') {
        int count = dataList.length;
        suhuResult /= count;
        kekeruhanResult /= count;
      }

      resultData.add(ChartData(groupTime, suhuResult, kekeruhanResult));
    });

    return resultData;
  }

  Map<String, List<ChartData>> _groupDataByPeriod() {
    Map<String, List<ChartData>> groupedData = {};
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    for (var data in widget.sensorDataList) {
      if (data.time.isBefore(startOfWeek)) continue;

      String key = _selectedPeriod == 'Per Jam'
          ? DateFormat('yyyy-MM-dd HH').format(data.time)
          : DateFormat('E').format(data.time);

      if (!groupedData.containsKey(key)) {
        groupedData[key] = [];
      }

      groupedData[key]!.add(data);
    }

    return groupedData;
  }
}
