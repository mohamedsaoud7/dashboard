class CaseType {
  String idCaseType;
  int count;

  CaseType({required this.idCaseType, required this.count});

  factory CaseType.fromJson(Map<String, dynamic> json) {
    return CaseType(
      idCaseType: json['idCaseType'],
      count: json['count'],
    );
  }
}