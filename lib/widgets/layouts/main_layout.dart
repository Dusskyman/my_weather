import 'package:flutter/material.dart';

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
          bottomBar(),
        ],
      ),
    );
  }

  Widget bottomBar() {
    return Row(
      children: [
        Expanded(
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
        Expanded(
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
      ],
    );
  }
}
