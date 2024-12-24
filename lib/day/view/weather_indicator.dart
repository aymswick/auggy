import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherIndicator extends StatelessWidget {
  const WeatherIndicator({required this.currentWeather, super.key});

  final Map<String, dynamic> currentWeather;
  @override
  Widget build(BuildContext context) {
    final temp = currentWeather['temperature_2m'];
    final feelsLike = currentWeather['apparent_temperature'];
    final code = currentWeather['weather_code'];

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: switch (code) {
            0 => Icon(Icons.wb_sunny), // Clear sky
            1 => Icon(Icons.cloud), // Mainly clear
            2 => Icon(Icons.cloud), // Partly cloudy
            3 => Icon(Icons.cloud), // Overcast
            45 => Icon(Icons.foggy), // Fog
            48 => Icon(Icons.foggy), // Depositing rime fog
            51 => Icon(Icons.grain), // Drizzle: Light intensity
            53 => Icon(Icons.grain), // Drizzle: Moderate intensity
            55 => Icon(Icons.grain), // Drizzle: Dense intensity
            56 => Icon(Icons.ac_unit), // Freezing Drizzle: Light intensity
            57 => Icon(Icons.ac_unit), // Freezing Drizzle: Dense intensity
            61 => Icon(WeatherIcons.rain), // Rain: Slight intensity
            63 => Icon(WeatherIcons.rain), // Rain: Moderate intensity
            65 => Icon(WeatherIcons.rain), // Rain: Heavy intensity
            66 => Icon(Icons.ice_skating), // Freezing Rain: Light intensity
            67 => Icon(Icons.ice_skating), // Freezing Rain: Heavy intensity
            71 => Icon(Icons.snowing), // Snow fall: Slight intensity
            73 => Icon(Icons.snowing), // Snow fall: Moderate intensity
            75 => Icon(Icons.snowing), // Snow fall: Heavy intensity
            77 => Icon(Icons.grain), // Snow grains
            80 => Icon(Icons.shower), // Rain showers: Slight intensity
            81 => Icon(Icons.shower), // Rain showers: Moderate intensity
            82 => Icon(Icons.shower), // Rain showers: Violent intensity
            85 => Icon(Icons.cloudy_snowing), // Snow showers: Slight intensity
            86 => Icon(Icons.cloudy_snowing), // Snow showers: Heavy intensity
            95 => Icon(Icons.thunderstorm), // Thunderstorm: Slight or moderate
            96 => Icon(Icons.thunderstorm), // Thunderstorm with slight hail
            99 => Icon(Icons.thunderstorm), // Thunderstorm with heavy hail
            _ => Icon(Icons.question_mark), // Default (unknown weather)
          },
        ),
        Text('$feelsLike F'),
      ],
    );
  }
}
