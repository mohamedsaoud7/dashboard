import 'package:fitness_dashboard_ui/services/casetypeFetch.dart';
import 'package:fitness_dashboard_ui/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';

class SummaryDetails extends StatefulWidget {
  const SummaryDetails({super.key});

  @override
  _SummaryDetailsState createState() => _SummaryDetailsState();
}

class _SummaryDetailsState extends State<SummaryDetails> {
  late Future<List<Map<String, dynamic>>> futureDetails;

  @override
  void initState() {
    super.initState();
    futureDetails = fetchAndMapCaseTypes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: futureDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Failed to load details'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No details available'));
        }

        final details = snapshot.data!;
        return CustomCard(
          color: const Color(0xFF2F353E),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: details.map((detail) {
              return buildDetails(detail['name'], detail['count'].toString());
            }).toList(),
          ),
        );
      },
    );
  }

  Widget buildDetails(String key, String value) {
    return Column(
      children: [
        Text(
          key,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
