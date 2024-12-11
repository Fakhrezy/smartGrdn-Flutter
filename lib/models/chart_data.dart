class ChartData {
  final DateTime time;
  final double suhu;
  final double kekeruhan;

  ChartData(this.time, this.suhu, this.kekeruhan);

  static Map<String, double> getMaxValues(List<ChartData> dataList) {
    double maxSuhu = -double.infinity;
    double maxKekeruhan = -double.infinity;

    for (var data in dataList) {
      if (data.suhu > maxSuhu) maxSuhu = data.suhu;
      if (data.kekeruhan > maxKekeruhan) maxKekeruhan = data.kekeruhan;
    }

    return {'suhu': maxSuhu, 'kekeruhan': maxKekeruhan};
  }

  static Map<String, double> getMinValues(List<ChartData> dataList) {
    double minSuhu = double.infinity;
    double minKekeruhan = double.infinity;

    for (var data in dataList) {
      if (data.suhu < minSuhu) minSuhu = data.suhu;
      if (data.kekeruhan < minKekeruhan) minKekeruhan = data.kekeruhan;
    }

    return {'suhu': minSuhu, 'kekeruhan': minKekeruhan};
  }

  static Map<String, double> getAvgValues(List<ChartData> dataList) {
    double totalSuhu = 0;
    double totalKekeruhan = 0;

    for (var data in dataList) {
      totalSuhu += data.suhu;
      totalKekeruhan += data.kekeruhan;
    }

    int count = dataList.length;
    return {'suhu': totalSuhu / count, 'kekeruhan': totalKekeruhan / count};
  }
}

