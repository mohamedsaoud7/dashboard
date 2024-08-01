import 'package:fitness_dashboard_ui/services/countryFetch.dart';
import 'package:fitness_dashboard_ui/util/marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../model/country.dart';

class CountryMap extends StatefulWidget {
  @override
  _CountryMapState createState() => _CountryMapState();
}

class _CountryMapState extends State<CountryMap> {
  List<Country> countries = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    CountryService countryService = CountryService();
    List<Country> fetchedCountries = await countryService.fetchCountries();

    setState(() {
      countries = fetchedCountries;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Maps'),centerTitle: true,),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: LatLng(20.0, 0.0),
                zoom: 2.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: countries.map((country) {
                    return Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(country.latitude, country.longitude),
                      builder: (ctx) => GestureDetector(
                        onTap: () {
                          showDialog(
                            context: ctx,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(country.name),
                                content: Text('User Count: ${country.userCount}'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: CountryMarker(country: country),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
    );
  }
}
