import 'package:flutter/material.dart';
import '../models/location.dart';

class LocationsProvider extends ChangeNotifier {
  final List<Location> _locations = [
    Location('1', name: 'Location 1', isActive: true),
    Location('2', name: 'Location 2', isActive: false),
  ];

  List<Location> get locations => _locations;

  void addLocation(Location location) {
    _locations.add(location); // Modify _locations directly
    notifyListeners();
  }

  void deleteLocationAt(int index) {
    _locations.removeAt(index); // Modify _locations directly
    notifyListeners();
  }

  void editLocation(Location updatedLocation, int index) {
    _locations[index] = updatedLocation; // Modify _locations directly
    notifyListeners();
  }

  void toggleActive(int index) {
    _locations[index].isActive = !locations[index].isActive;
    notifyListeners();
  }
}
