import 'dart:convert';
import 'package:fitness_dashboard_ui/model/userfeedback.dart';
import 'package:http/http.dart' as http;

Future<List<Feedback>> fetchFeedbacks() async {
  final response = await http.get(Uri.parse('http://localhost:5282/Feedback/GetAll'));

  if (response.statusCode == 200) {
    List<dynamic> body = json.decode(response.body);
    return body.map((dynamic item) => Feedback.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load feedback');
  }
}
