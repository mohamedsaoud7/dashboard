import 'dart:convert';

import 'package:fitness_dashboard_ui/model/health_model.dart';
import 'package:fitness_dashboard_ui/util/responsive.dart';
import 'package:fitness_dashboard_ui/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ActivityDetailsCard extends StatefulWidget {
  const ActivityDetailsCard({Key? key}) : super(key: key);

  @override
  _ActivityDetailsCardState createState() => _ActivityDetailsCardState();
}

class _ActivityDetailsCardState extends State<ActivityDetailsCard> {
  List<HealthModel> healthData = [
    HealthModel(
        icon: 'assets/icons/fallback_icon.png', value: "0", title: "Fallbacks"),
    HealthModel(icon: 'assets/icons/feedback_icon.png', value: "0", title: "Feedbacks"),
    HealthModel(
        icon: 'assets/icons/negative_icon.webp',
        value: "0",
        title: "Negative Feedback"),
    HealthModel(
        icon: 'assets/icons/good_icon.png', value: "0", title: "Positive Feedback"),
  ];

  @override
  void initState() {
    super.initState();
    _fetchFallbackData();
    _fetchFeedbackData();
  }

  Future<void> _fetchFallbackData() async {
    final apiUrl = "http://localhost:5282/api/Fallback/total";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          healthData[0].value = response.body.toString();
        });
      } else {
        throw Exception('Failed to load total feedbacks');
      }
    } catch (e) {
      print('Failed to load feedback data: $e');
      // Handle error, e.g., show a snackbar
    }
  }

  Future<void> _fetchFeedbackData() async {
    final apiUrl =
        "http://localhost:5282/Feedback/summary"; 

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          healthData[1].value =
              data['totalFeedbacks'].toString(); // Update total feedbacks
          healthData[2].value =
              data['negativeFeedbacks'].toString(); // Update negative feedbacks
          healthData[3].value =
              data['positiveFeedbacks'].toString(); // Update positive feedbacks
        });
      } else {
        throw Exception('Failed to load feedback data');
      }
    } catch (e) {
      print('Failed to load feedback data: $e');
      // Handle error, e.g., show a snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: healthData.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
        crossAxisSpacing: Responsive.isMobile(context) ? 12 : 15,
        mainAxisSpacing: 12.0,
      ),
      itemBuilder: (context, index) => CustomCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              healthData[index].icon,
              width: 30,
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 4),
              child: Text(
                healthData[index].value,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              healthData[index].title,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
