import 'package:fitness_dashboard_ui/model/country.dart';
import 'package:flutter/material.dart';



class CountryMarker extends StatelessWidget {
  final Country country;

  CountryMarker({required this.country});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.location_on,
          color: Colors.red,
          size: 40.0,
        ),
        Text(
          country.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Users: ${country.userCount}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 10.0,
          ),
        ),
      ],
    );
  }
}
