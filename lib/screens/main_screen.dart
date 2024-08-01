import 'package:fitness_dashboard_ui/util/responsive.dart';
import 'package:fitness_dashboard_ui/widgets/Bot_Maintain.dart';
import 'package:fitness_dashboard_ui/widgets/cmaps.dart';
import 'package:fitness_dashboard_ui/widgets/dashboard_widget.dart';
import 'package:fitness_dashboard_ui/widgets/fallback.dart';
import 'package:fitness_dashboard_ui/widgets/feedback.dart';
import 'package:fitness_dashboard_ui/widgets/side_menu_widget.dart';
import 'package:fitness_dashboard_ui/widgets/summary_widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  Widget _getSelectedWidget() {
    switch (_selectedIndex) {
      case 0:
        return DashboardWidget();
      case 1:
        return UseFallbacksTable();
      case 2:
        return FeedbackTable();
      case 3:
        return CountryMap();
      case 4:
        return BotMaintain();
      default:
        return DashboardWidget();
    }
  }

  void _onMenuItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      drawer: !isDesktop
          ? SizedBox(
              width: 250,
              child: SideMenuWidget(onMenuItemSelected: _onMenuItemSelected),
            )
          : null,
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const SummaryWidget(),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              Expanded(
                flex: 2,
                child: SizedBox(
                  child:
                      SideMenuWidget(onMenuItemSelected: _onMenuItemSelected),
                ),
              ),
            Expanded(
              flex: 7,
              child: _getSelectedWidget(),
            ),
            if (isDesktop)
              Expanded(
                flex: 3,
                child: SummaryWidget(),
              ),
          ],
        ),
      ),
    );
  }
}
