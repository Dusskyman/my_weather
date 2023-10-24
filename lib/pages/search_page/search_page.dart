import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:my_weather/cubit/weather_search_cubit.dart/weather_search_cubit.dart';
import 'package:my_weather/cubit/weather_search_cubit.dart/weather_search_state.dart';
import 'package:my_weather/models/search_weather_model.dart';
import 'package:my_weather/widgets/layouts/main_layout.dart';

import 'package:latlong2/latlong.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  final String? city;
  const SearchPage({this.city, super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController controller =
      TextEditingController(text: widget.city ?? '');

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: SafeArea(
        child: Column(
          children: [
            GooglePlaceAutoCompleteTextField(
              textEditingController: controller,
              googleAPIKey: "AIzaSyCZ_cPOUrpIhwoXHXtDqU9T9D4aE40agS0",
              inputDecoration: const InputDecoration(hintText: 'Search'),
              isLatLngRequired: true,
              boxDecoration: const BoxDecoration(),
              getPlaceDetailWithLatLng: (_) {},
              itemClick: (prediction) {
                controller.text = prediction.description ?? '';
                context
                    .read<WeatherSearchCubit>()
                    .getWeaterForecast(prediction.description!);
              },
            ),
            BlocBuilder<WeatherSearchCubit, WeatherSearchState>(
              builder: (context, state) {
                if (state is WeatherSearchLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is WeatherSearchFound) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: state.searchWeatherModels.length,
                        itemBuilder: (context, i) =>
                            _forecastItem(state.searchWeatherModels[i]),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _forecastItem(SearchWeatherModel forecast) {
    return Container(
      height: 125.0,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade200,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Image.network(
            forecast.imageUrl,
            width: 50.0,
          ),
          Text(
            forecast.weekday,
            style: const TextStyle(
              fontSize: 24.0,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Actual ${forecast.temp}',
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Feels like',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      forecast.tempFeelsLike,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
