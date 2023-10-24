import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather/config/app_router.dart';
import 'package:my_weather/cubit/weather_map_cubit/weather_map_cubit.dart';
import 'package:my_weather/cubit/weather_search_cubit.dart/weather_search_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherMapCubit>(
          create: (context) => WeatherMapCubit()..initialMark(),
        ),
        BlocProvider<WeatherSearchCubit>(
          create: (context) => WeatherSearchCubit(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
