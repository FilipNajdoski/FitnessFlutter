import 'package:flutter/material.dart';
import '../../models/location.dart';

class ViewLocationScreen extends StatelessWidget {
  final Location loc;

  const ViewLocationScreen({super.key, required this.loc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(loc.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Location Name: ${loc.name}'),
            const SizedBox(height: 10),
            Text('Active: ${loc.isActive ? 'Yes' : 'No'}'),
          ],
        ),
      ),
    );
  }
}
