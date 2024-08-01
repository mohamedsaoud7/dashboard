import 'package:fitness_dashboard_ui/model/case_type_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<CaseType>> fetchCaseTypes() async {
  final response = await http.get(Uri.parse('http://localhost:5282/api/DraftForm/case-type-counts'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => CaseType.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load case types');
  }
}
Map<String, String> idToNameMap = {
  "b00c6475-8f38-45ae-a508-44d3b8f2e175": "Recovery",
  "24d8d10c-533a-44eb-9135-0b5d7f9ef113": "Investigation",
  "193d7004-4470-4fab-a430-7d60fcc22221": "Accident",
  "6731f309-aa6f-4bb2-a456-1f0c0fa632d8": "Mediation",
  "4e7ea233-1710-4321-a62c-5a9a29e62709": "Missing",
  "fe0e905f-5b44-4aa1-b11b-6eb79d9142e3": "Plan Care",
  "1c720b09-373b-4803-be9b-8804a2d097a6": "Death",
  "10589c6b-980f-410d-9df2-a4a11114219e": "Illness",
  "ca55ac0c-d7f5-4930-b0c2-f9ecf64aafe3": "Recall"

};

List<Map<String, dynamic>> mapIdToName(List<CaseType> caseTypes) {
  return caseTypes.map((caseType) {
    return {
      'name': idToNameMap[caseType.idCaseType] ?? 'Unknown',
      'count': caseType.count,
    };
  }).toList();
}
Future<List<Map<String, dynamic>>> fetchAndMapCaseTypes() async {
  List<CaseType> caseTypes = await fetchCaseTypes();
  return mapIdToName(caseTypes);
}