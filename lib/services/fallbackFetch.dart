import 'dart:convert';
import 'package:fitness_dashboard_ui/model/userfallback.dart';
import 'package:http/http.dart' as http;


Future<List<UseFallback>> fetchUseFallbacks() async {
  final response = await http.get(Uri.parse('http://localhost:5282/api/Fallback/GetAll'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => UseFallback.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> fetchTotalFeedbacks() async {
    final response = await http.get(Uri.parse('http://localhost:5282/api/Fallback/total'));

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to load total feedbacks');
    }
  }
  
