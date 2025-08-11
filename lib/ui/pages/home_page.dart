import 'package:flutter/material.dart';
import 'package:weather/data/services/weather_service.dart';
import '../../data/models/weather_model.dart';
import '../widgets/weather_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final service = WeatherService();

  String? secilenSehir;
  Future<WeatherModel>? weatherFuture;

  final List<String> sehirler = const [
    'Ankara',
    'Bursa',
    'İzmir',
    'İstanbul',
    'Eskişehir',
    'Niğde',
    'Kocaeli',
    'Konya',
  ];

  void selectedCity(String city) {
    setState(() {
      secilenSehir = city;
      weatherFuture = service.fetchCityWeather(city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App Bar'), centerTitle: true),
      body: Column(
        children: [
          if (weatherFuture != null)
            FutureBuilder<WeatherModel>(
              future: weatherFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.hasData) {
                  return WeatherCard(model: snapshot.data!);
                }
                return const SizedBox.shrink();
              },
            ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: sehirler.length,
              itemBuilder: (context, index) {
                final city = sehirler[index];
                final isSelected = secilenSehir == city;
                return GestureDetector(
                  onTap: () => selectedCity(city),
                  child: Card(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primaryContainer
                        : null,
                    child: Center(child: Text(city)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
