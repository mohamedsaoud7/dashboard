import 'package:fitness_dashboard_ui/const/constant.dart';
import 'package:fitness_dashboard_ui/data/pie_chart_data.dart';
import 'package:fitness_dashboard_ui/services/casetypeFetch.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late Future<List<Map<String, dynamic>>> futureCaseTypes;
  late ChartData chartData;

  @override
  void initState() {
    super.initState();
    futureCaseTypes = fetchCaseTypes().then((caseTypes) => mapIdToName(caseTypes));
    chartData = ChartData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: futureCaseTypes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data found'));
        } else {
          List<PieChartSectionData> pieChartData = chartData.getPieChartData(snapshot.data!);
          return SizedBox(
            height: 200,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 70,
                    startDegreeOffset: -90,
                    sections: pieChartData,
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: defaultPadding),
                      Text(
                        "70%",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              height: 0.5,
                            ),
                      ),
                      const SizedBox(height: 8),
                      const Text("of 100%"),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
