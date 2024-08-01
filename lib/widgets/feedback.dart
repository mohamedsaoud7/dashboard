import 'package:fitness_dashboard_ui/model/userfeedback.dart' as model;
import 'package:fitness_dashboard_ui/services/feedbackfetch.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeedbackTable extends StatefulWidget {
  @override
  _FeedbackTableState createState() => _FeedbackTableState();
}

class _FeedbackTableState extends State<FeedbackTable> {
  late Future<List<model.Feedback>> futureFeedbacks;
  String _selectedLabel = 'All';

  @override
  void initState() {
    super.initState();
    futureFeedbacks = fetchFeedbacks() as Future<List<model.Feedback>>;
  }

  List<model.Feedback> _filterFeedbacks(List<model.Feedback> feedbacks) {
    if (_selectedLabel == 'All') {
      return feedbacks;
    } else {
      return feedbacks
          .where((feedback) => feedback.label == _selectedLabel)
          .toList();
    }
  }

  // Method to generate stars based on score
  Widget _buildStars(double score) {
    int fullStars = (score * 5).floor();
    double remainingFraction = (score * 5) - fullStars;

    List<Widget> stars = [];
    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: Colors.yellow));
    }

    if (remainingFraction >= 0.5) {
      stars.add(Icon(Icons.star_half, color: Colors.yellow));
    }

    // Ensure exactly 5 stars are shown
    while (stars.length < 5) {
      stars.add(Icon(Icons.star_border, color: Colors.yellow));
    }

    return Row(children: stars);
  }

  void _deleteFeedback(int id) async {
  try {
    final response = await http.delete(Uri.parse('http://localhost:5282/Feedback/$id'));

    if (response.statusCode == 200) {
      setState(() {
        // This is where you would call your API to delete the feedback
        // For now, we're just removing it from the list locally
        futureFeedbacks = futureFeedbacks.then(
            (feedbacks) => feedbacks.where((f) => f.id != id).toList());
      });
      print('Feedback deleted');
    } else {
      throw Exception('Failed to delete feedback');
    }
  } catch (e) {
    print('Error deleting feedback: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to delete feedback')),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Table'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedLabel,
              items: ['All', 'POSITIVE', 'NEGATIVE'].map((String label) {
                return DropdownMenuItem<String>(
                  value: label,
                  child: Text(label),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLabel = newValue!;
                });
              },
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: FutureBuilder<List<model.Feedback>>(
                future: futureFeedbacks,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<model.Feedback> filteredFeedbacks =
                        _filterFeedbacks(snapshot.data!);
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: DataTable(
                          columnSpacing: 20.0,
                          columns: [
                            DataColumn(
                              label: Text(
                                'Text',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Label',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Score',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Rating',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Actions',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          rows:
                              filteredFeedbacks.map((model.Feedback feedback) {
                            return DataRow(cells: [
                              DataCell(
                                SizedBox(
                                  width:
                                      300, // Set width based on your requirements
                                  child: Text(
                                    feedback.text,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines:
                                        3, // Set max lines before truncation
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: 100, // Adjust width as needed
                                  child: Text(
                                    feedback.label,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: 100, // Adjust width as needed
                                  child: Text(
                                    feedback.score.toStringAsFixed(3),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              DataCell(
                                SizedBox(
                                  width: 150, // Adjust width as needed
                                  child: feedback.label == 'POSITIVE'
                                      ? _buildStars(feedback.score)
                                      : Text('-'),
                                ),
                              ),
                              DataCell(
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteFeedback(feedback.id),
                                ),
                              ),
                            ]);
                          }).toList(),
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Text('No data available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
