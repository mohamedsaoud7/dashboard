import 'package:fitness_dashboard_ui/model/health_model.dart';


class HealthDetails {
  final healthData = [
    HealthModel(
        icon: 'assets/icons/burn.png', value: "305", title: "Fallbacks"),
    HealthModel(
        icon: 'assets/icons/steps.png', value: "10,983", title: "Feedbacks"),
    HealthModel(
        icon: 'assets/icons/distance.png', value: "7km", title: "Negative Feedback"),
    HealthModel(icon: 'assets/icons/sleep.png', value: "7h48m", title: "Positive Feedback"),
  ];
}
