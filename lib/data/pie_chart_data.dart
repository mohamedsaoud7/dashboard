import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fitness_dashboard_ui/const/constant.dart';

class ChartData {
  List<PieChartSectionData> getPieChartData(
      List<Map<String, dynamic>> caseTypes) {
    return caseTypes.map((caseType) {
      return PieChartSectionData(
        color: _getColorForCaseType(caseType['name']),
        value: caseType['count'].toDouble(),
        title: caseType['name'],
        showTitle: true,
        radius: 25,
      );
    }).toList();
  }

  Color _getColorForCaseType(String name) {
    switch (name) {
      case 'Accident':
        return primaryColor;
      case 'Investigation':
        return const Color(0xFF26E5FF);
      case 'Recovery':
        return Color.fromARGB(255, 130, 125, 108);
      case 'Recall':
        return Colors.blue;
      case 'Mediation':
        return Colors.green;
      case 'Plan Care':
        return Colors.yellow;
      case 'Death':
        return Colors.black;
      case 'Illness':
        return Colors.grey;
      case 'Missing':
        return Colors.red;
      default:
        return primaryColor.withOpacity(0.1);
    }
  }
}
