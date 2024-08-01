import 'package:fitness_dashboard_ui/model/userfallback.dart';
import 'package:fitness_dashboard_ui/services/fallbackFetch.dart';
import 'package:flutter/material.dart';

class UseFallbacksTable extends StatefulWidget {
  @override
  _UseFallbacksTableState createState() => _UseFallbacksTableState();
}

class _UseFallbacksTableState extends State<UseFallbacksTable> {
  late Future<List<UseFallback>> futureUseFallbacks;

  @override
  void initState() {
    super.initState();
    futureUseFallbacks = fetchUseFallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Fallbacks'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<UseFallback>>(
          future: futureUseFallbacks,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text('Fallback', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Confidence', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Intent Ranking', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Creation Date', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                  rows: snapshot.data!.map((useFallback) {
                    DateTime timestamp = DateTime.parse(useFallback.timestamp);
                    String formattedTimestamp = '${timestamp.day}-${timestamp.month}-${timestamp.year} ${timestamp.hour}:${timestamp.minute}';
                    return DataRow(cells: [
                      DataCell(
                        SizedBox(
                          width: 300, // Set the width as needed
                          child: Text(
                            useFallback.userMessage,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5, // Set the number of lines to show before truncating
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 100, // Adjust width based on content
                          child: Text(
                            useFallback.confidence.toStringAsFixed(2),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 150, // Adjust width based on content
                          child: Text(
                            useFallback.intentRanking,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 150, // Adjust width based on content
                          child: Text(
                            formattedTimestamp,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
