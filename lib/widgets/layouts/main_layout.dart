import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/config/app_router.dart';

class MainLayout extends StatelessWidget {
  final Widget body;

  const MainLayout({
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: body),
          Row(
            children: [
              _bottomButton(
                name: 'Map',
                onTap: () => context.navigateTo(const MapRoute()),
                isSelected: context.router.currentPath == '/map-route',
                iconData: Icons.map_outlined,
              ),
              _bottomButton(
                name: 'Search',
                onTap: () => context.navigateTo(SearchRoute()),
                isSelected: context.router.currentPath == '/search-route',
                iconData: Icons.search,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget bottomBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IgnorePointer(
            ignoring: context.router.currentPath == '/map-route',
            child: InkWell(
              onTap: () {
                context.navigateTo(const MapRoute());
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.map_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      'Map',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: IgnorePointer(
            ignoring: context.router.currentPath == '/search-route',
            child: InkWell(
              onTap: () {
                context.navigateTo(SearchRoute());
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      'Search',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottomButton({
    required String name,
    required Function() onTap,
    required bool isSelected,
    required IconData iconData,
  }) {
    return Expanded(
      child: IgnorePointer(
        ignoring: isSelected,
        child: InkWell(
          onTap: onTap,
          child: Container(
            color: isSelected ? Colors.black : Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: isSelected ? Colors.white : Colors.black,
                ),
                const SizedBox(width: 4.0),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
