import 'package:fitness_dashboard_ui/model/menu_model.dart';
import 'package:flutter/material.dart';

class SideMenuData {
  final menu = const <MenuModel>[
    MenuModel(icon: Icons.home, title: 'Dashboard'),
    MenuModel(icon: Icons.run_circle, title: 'Fallbacks'),
    MenuModel(icon: Icons.person, title: 'Feedbacks'),
    MenuModel(icon: Icons.map, title: 'User Maps'),
    MenuModel(icon: Icons.settings, title: 'Bot Maintaining'),
    MenuModel(icon: Icons.logout, title: 'SignOut'),
  ];
}
