import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:my_weather/config/app_router.dart';
import 'package:my_weather/consts/app_consts.dart';
import 'package:my_weather/cubit/weather_map_cubit/weather_map_cubit.dart';
import 'package:my_weather/cubit/weather_map_cubit/weather_map_state.dart';
import 'package:my_weather/cubit/weather_search_cubit.dart/weather_search_cubit.dart';

import 'package:my_weather/models/map_weather_model.dart';
import 'package:my_weather/widgets/layouts/main_layout.dart';
import 'package:latlong2/latlong.dart';

@RoutePage()
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool showHint = false;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: BlocBuilder<WeatherMapCubit, WeatherMapState>(
        builder: (context, state) {
          if (state is WeatherMapLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    FlutterMap(
                      options: MapOptions(
                        onTap: (tapPosition, point) => _removeMarker(),
                        onLongPress: (tapPosition, point) {
                          showHint = false;
                          context
                              .read<WeatherMapCubit>()
                              .getWeaterWithPoint(point);
                        },
                        center: state is WeatherMapIdle ? state.latLng : null,
                        zoom: 15.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: AppConsts.mapUrl,
                        ),
                        if (state is WeatherMapMarked)
                          MarkerLayer(
                            markers: [
                              _buildMarkes(
                                state.mapWeatherModel,
                                () {
                                  context
                                      .read<WeatherSearchCubit>()
                                      .getWeaterForecast(
                                        '${state.mapWeatherModel.contry}, ${state.mapWeatherModel.localy}',
                                      );
                                  context.navigateTo(
                                    SearchRoute(
                                      city:
                                          '${state.mapWeatherModel.contry}, ${state.mapWeatherModel.localy}',
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SafeArea(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Text(
                            'Location',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Marker _buildMarkes(MapWeatherModel model, Function() onTap) {
    return Marker(
      point: model.point,
      height: 125.0,
      width: 250.0,
      anchorPos: AnchorPos.align(AnchorAlign.top),
      rotate: true,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: showHint,
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: Image.network(
                        model.imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.temp,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            model.localy.isNotEmpty
                                ? '${model.contry}, ${model.localy}'
                                : model.contry,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showHint = true;
              setState(() {});
            },
            child: Transform.rotate(
              angle: pi,
              child: const Icon(
                Icons.navigation,
                color: Colors.black,
                size: 50.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _removeMarker() {
    showHint = false;
    context.read<WeatherMapCubit>().removeMark();
  }
}
