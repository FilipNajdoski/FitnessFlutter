import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/location.dart';
import 'create_location_screen.dart';
import 'view_location_screen.dart';
import '../../shared/locationsProvider.dart';

class LocationsScreen extends StatelessWidget {
  final List<Location> locations;

  const LocationsScreen({
    super.key,
    required this.locations,
  });

  void _createNewLocation(BuildContext context) async {
    final newLocation = await Navigator.push<Location?>(
      context,
      MaterialPageRoute(builder: (context) => const CreateLocationScreen()),
    );

    if (newLocation != null) {
      // Adding the new location to the provider
      context.read<LocationsProvider>().addLocation(newLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
        centerTitle: true,
      ),
      body: Consumer<LocationsProvider>(
        builder: (context, provider, _) {
          // Use the provider's locations list
          return ListView.builder(
            itemCount: provider.locations.length,
            itemBuilder: (context, index) {
              final loc = provider.locations[index];
              return Dismissible(
                key: ValueKey(loc.id),
                direction: DismissDirection.horizontal,
                background: Container(
                  color: Colors.blue, // Background color for swipe right
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.sync, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.red, // Background color for swipe left
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.sync, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    // Swipe right to toggle active state
                    provider.toggleActive(index);
                    final snackBar = SnackBar(
                      content: Text(
                        loc.isActive
                            ? 'Location activated'
                            : 'Location deactivated',
                      ),
                      duration: const Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return false; // Prevent removal of the item
                  } else if (direction == DismissDirection.endToStart) {
                    // Swipe left to toggle active state as well (like toggleFavorite)
                    provider.toggleActive(index);
                    final snackBar = SnackBar(
                      content: Text(
                        loc.isActive
                            ? 'Location activated'
                            : 'Location deactivated',
                      ),
                      duration: const Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return false; // Prevent removal of the item
                  }
                  return false;
                },
                child: ListTile(
                  title: Text(loc.name),
                  subtitle: Text(loc.isActive ? 'Active' : 'Inactive'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewLocationScreen(loc: loc),
                      ),
                    );
                  },
                  trailing: Icon(
                    loc.isActive ? Icons.check_circle : Icons.radio_button_off,
                    color: loc.isActive ? Colors.green : Colors.grey,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewLocation(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
