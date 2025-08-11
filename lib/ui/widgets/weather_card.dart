import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key, required this.model});
  final WeatherModel model;

  @override
  Widget build(BuildContext context) {
    final cityName = model.name ?? 'Bilinmiyor';
    final temp = model.main?.temp;
    final desc = (model.weather != null && model.weather!.isNotEmpty)
        ? model.weather!.first.description
        : null;
    final humidity = model.main?.humidity;
    final windSpeed = model.wind?.speed;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(cityName, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              temp != null ? '${temp.round()}°' : '-°',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(desc ?? 'Değer bulunamadı'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Icon(Icons.water_drop),
                    const SizedBox(height: 4),
                    Text(humidity?.toString() ?? '-'),
                  ],
                ),
                const SizedBox(width: 32),
                Column(
                  children: [
                    const Icon(Icons.air),
                    const SizedBox(height: 4),
                    Text(
                      windSpeed != null ? windSpeed.round().toString() : '-',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
