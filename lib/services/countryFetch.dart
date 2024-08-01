import 'dart:convert';
import 'package:fitness_dashboard_ui/model/country.dart';
import 'package:fitness_dashboard_ui/model/countrydata.dart';
import 'package:http/http.dart' as http;

class CountryService {
  static const String apiUrl =
      'http://localhost:5282/api/DraftForm/country-counts';

  Future<List<Country>> fetchCountries() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return await _convertToCountryList(data);
    } else {
      throw Exception('Failed to load country data');
    }
  }

  List<Countr> selectedCountries = [
    Countr(name: 'Afghanistan', latitude: 33.9391, longitude: 67.7100),
    Countr(name: 'Albania', latitude: 41.1533, longitude: 20.1683),
    Countr(name: 'Algeria', latitude: 28.0339, longitude: 1.6596),
    Countr(name: 'Argentina', latitude: -38.4161, longitude: -63.6167),
    Countr(name: 'Australia', latitude: -25.2744, longitude: 133.7751),
    Countr(name: 'Bangladesh', latitude: 23.6850, longitude: 90.3563),
    Countr(name: 'Brazil', latitude: -14.2350, longitude: -51.9253),
    Countr(name: 'Canada', latitude: 56.1304, longitude: -106.3468),
    Countr(name: 'China', latitude: 35.8617, longitude: 104.1954),
    Countr(name: 'Colombia', latitude: 4.5709, longitude: -74.2973),
    Countr(name: 'Egypt', latitude: 26.8206, longitude: 30.8025),
    Countr(name: 'France', latitude: 46.6034, longitude: 1.8883),
    Countr(name: 'Germany', latitude: 51.1657, longitude: 10.4515),
    Countr(name: 'India', latitude: 20.5937, longitude: 78.9629),
    Countr(name: 'Indonesia', latitude: -0.7893, longitude: 113.9213),
    Countr(name: 'Iran', latitude: 32.4279, longitude: 53.6880),
    Countr(name: 'Italy', latitude: 41.8719, longitude: 12.5674),
    Countr(name: 'Japan', latitude: 36.2048, longitude: 138.2529),
    Countr(name: 'Mexico', latitude: 23.6345, longitude: -102.5528),
    Countr(name: 'Netherlands', latitude: 52.1326, longitude: 5.2913),
    Countr(name: 'Nigeria', latitude: 9.0820, longitude: 8.6753),
    Countr(name: 'Pakistan', latitude: 30.3753, longitude: 69.3451),
    Countr(name: 'Peru', latitude: -9.1900, longitude: -75.0152),
    Countr(name: 'Philippines', latitude: 12.8797, longitude: 121.7740),
    Countr(name: 'Russia', latitude: 61.5240, longitude: 105.3188),
    Countr(name: 'Saudi Arabia', latitude: 23.8859, longitude: 45.0792),
    Countr(name: 'South Africa', latitude: -30.5595, longitude: 22.9375),
    Countr(name: 'South Korea', latitude: 35.9078, longitude: 127.7669),
    Countr(name: 'Spain', latitude: 40.4637, longitude: -3.7492),
    Countr(name: 'Sweden', latitude: 60.1282, longitude: 18.6435),
    Countr(name: 'Switzerland', latitude: 46.8182, longitude: 8.2275),
    Countr(name: 'Thailand', latitude: 15.8700, longitude: 100.9925),
    Countr(name: 'Turkey', latitude: 38.9637, longitude: 35.2433),
    Countr(name: 'Ukraine', latitude: 48.3794, longitude: 31.1656),
    Countr(name: 'United Arab Emirates', latitude: 23.4241, longitude: 53.8478),
    Countr(name: 'United Kingdom', latitude: 55.3781, longitude: -3.4360),
    Countr(name: 'United States', latitude: 37.0902, longitude: -95.7129),
    Countr(name: 'Vietnam', latitude: 14.0583, longitude: 108.2772),
    Countr(name: 'Yemen', latitude: 15.5527, longitude: 48.5164),
    Countr(name: 'Algeria', latitude: 28.0339, longitude: 1.6596),
    Countr(name: 'Argentina', latitude: -38.4161, longitude: -63.6167),
    Countr(name: 'Australia', latitude: -25.2744, longitude: 133.7751),
    Countr(name: 'Bangladesh', latitude: 23.6850, longitude: 90.3563),
    Countr(name: 'Brazil', latitude: -14.2350, longitude: -51.9253),
    Countr(name: 'Canada', latitude: 56.1304, longitude: -106.3468),
    Countr(name: 'China', latitude: 35.8617, longitude: 104.1954),
    Countr(name: 'Colombia', latitude: 4.5709, longitude: -74.2973),
    Countr(name: 'Egypt', latitude: 26.8206, longitude: 30.8025),
    Countr(name: 'France', latitude: 46.6034, longitude: 1.8883),
    Countr(name: 'Germany', latitude: 51.1657, longitude: 10.4515),
    Countr(name: 'India', latitude: 20.5937, longitude: 78.9629),
    Countr(name: 'Indonesia', latitude: -0.7893, longitude: 113.9213),
    Countr(name: 'Iran', latitude: 32.4279, longitude: 53.6880),
    Countr(name: 'Italy', latitude: 41.8719, longitude: 12.5674),
    Countr(name: 'Japan', latitude: 36.2048, longitude: 138.2529),
    Countr(name: 'Mexico', latitude: 23.6345, longitude: -102.5528),
    Countr(name: 'Netherlands', latitude: 52.1326, longitude: 5.2913),
    Countr(name: 'Nigeria', latitude: 9.0820, longitude: 8.6753),
    Countr(name: 'Pakistan', latitude: 30.3753, longitude: 69.3451),
    Countr(name: 'Peru', latitude: -9.1900, longitude: -75.0152),
    Countr(name: 'Philippines', latitude: 12.8797, longitude: 121.7740),
    Countr(name: 'Russia', latitude: 61.5240, longitude: 105.3188),
    Countr(name: 'Saudi Arabia', latitude: 23.8859, longitude: 45.0792),
    Countr(name: 'South Africa', latitude: -30.5595, longitude: 22.9375),
    Countr(name: 'South Korea', latitude: 35.9078, longitude: 127.7669),
    Countr(name: 'Spain', latitude: 40.4637, longitude: -3.7492),
    Countr(name: 'Sweden', latitude: 60.1282, longitude: 18.6435),
    Countr(name: 'Switzerland', latitude: 46.8182, longitude: 8.2275),
    Countr(name: 'Thailand', latitude: 15.8700, longitude: 100.9925),
    Countr(name: 'Turkey', latitude: 38.9637, longitude: 35.2433),
    Countr(name: 'Ukraine', latitude: 48.3794, longitude: 31.1656),
    Countr(name: 'United Arab Emirates', latitude: 23.4241, longitude: 53.8478),
    Countr(name: 'United Kingdom', latitude: 55.3781, longitude: -3.4360),
    Countr(name: 'United States', latitude: 37.0902, longitude: -95.7129),
    Countr(name: 'Vietnam', latitude: 14.0583, longitude: 108.2772),
    Countr(name: 'Yemen', latitude: 15.5527, longitude: 48.5164),
    Countr(name: 'Tunisia', latitude: 33.8869, longitude: 9.5375),
    Countr(name: 'Bahrain', latitude: 26.0667, longitude: 50.5577),
    Countr(name: 'Iraq', latitude: 33.2232, longitude: 43.6793),
    Countr(name: 'Jordan', latitude: 30.5852, longitude: 36.2384),
    Countr(name: 'Kuwait', latitude: 29.3759, longitude: 47.9774),
    Countr(name: 'Lebanon', latitude: 33.8547, longitude: 35.8623),
    Countr(name: 'Malaysia', latitude: 4.2105, longitude: 101.9758),
    Countr(name: 'Oman', latitude: 21.5126, longitude: 55.9233),
    Countr(name: 'Qatar', latitude: 25.3548, longitude: 51.1839),
    Countr(name: 'Singapore', latitude: 1.3521, longitude: 103.8198),
    Countr(name: 'Syria', latitude: 34.8021, longitude: 38.9968),
    Countr(name: 'Taiwan', latitude: 23.6978, longitude: 120.9605),
    Countr(name: 'Uzbekistan', latitude: 41.3775, longitude: 64.5853),
  ];
  Countr? getCountryCoordinates(String countryName) {
    // Search for the country in the list
    Countr? countr = selectedCountries.firstWhere(
      (countr) => countr.name.toLowerCase() == countryName.toLowerCase(),
    );
    return countr;
  }

  Future<List<Country>> _convertToCountryList(List<dynamic> data) async {
    List<Country> countries = [];

    for (var item in data) {
      String countryName = item['country'];
      int userCount = item['count'];

      try {
        Countr? countr = getCountryCoordinates(countryName);
        double latitude = countr!.latitude;
        double longitude = countr.longitude;
        print(countryName);
        print(latitude);

        countries.add(Country(
          name: countryName,
          latitude: latitude,
          longitude: longitude,
          userCount: userCount,
        ));
      } catch (e) {
        print('Error geocoding country $countryName: $e');
        // Handle error or skip adding to list
      }
    }

    return countries;
  }
}
