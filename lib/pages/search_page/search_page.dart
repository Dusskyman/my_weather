import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:my_weather/widgets/layouts/main_layout.dart';

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
              },
            )
          ],
        ),
      ),
    );
  }
}
