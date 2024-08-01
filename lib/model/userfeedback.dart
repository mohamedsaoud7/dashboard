class Feedback {
  final int id;
  final String text;
  final String label;
  final double score;

  Feedback({
    required this.id,
    required this.text,
    required this.label,
    required this.score,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) {
    return Feedback(
      id: json['id'],
      text: json['text'],
      label: json['label'],
      score: json['score'].toDouble(),
    );
  }
}
