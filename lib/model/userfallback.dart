class UseFallback {
  final String userMessage;
  final double confidence;
  final String intentRanking;
  final String timestamp;

  UseFallback({
    required this.userMessage,
    required this.confidence,
    required this.intentRanking,
    required this.timestamp,
  });

  factory UseFallback.fromJson(Map<String, dynamic> json) {
    return UseFallback(
      userMessage: json['userMessage'],
      confidence: json['confidence'],
      intentRanking: json['intentRanking'],
      timestamp: json['timestamp'],
    );
  }
}
