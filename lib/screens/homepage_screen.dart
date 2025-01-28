import 'package:flutter/material.dart';
import 'package:untitled/screens/Locations/locations_screen.dart';
import 'package:untitled/screens/Profile/profile_screen.dart';
import 'package:untitled/screens/todo_screen.dart';
import 'package:untitled/shared/locationsProvider.dart';
import 'package:untitled/shared/profileProvider.dart';
import '../screens/favorites_todo_screen.dart';
import '../shared/favoriteProvider.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _selectedIndex = 0;

  void _onBottomNavBarTapped(int index) async {
    setState(() {
      _selectedIndex = index; // Update to the tapped index
    });

    if (index == 1) {
      final favorites =
          Provider.of<FavoritesProvider>(context, listen: false).favorites;
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FavoritesScreen(
            favorites: favorites,
            onRemove: (index) {},
          ),
        ),
      );
    } else if (index == 2) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationsScreen(
            locations: Provider.of<LocationsProvider>(context, listen: false)
                .locations,
          ),
        ),
      );
    } else if (index == 3) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(), // No profile passed
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 squares per row
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: 6, // Total squares
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Handle navigation based on the square index
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TodoScreen(),
                    ),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        final favorites = Provider.of<FavoritesProvider>(
                                context,
                                listen: false)
                            .favorites;
                        return FavoritesScreen(
                          favorites: favorites,
                          onRemove: (index) {},
                        );
                      },
                    ),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationsScreen(
                        locations: Provider.of<LocationsProvider>(context,
                                listen: false)
                            .locations,
                      ),
                    ),
                  );
                  break;
                default:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Feature for square ${index + 1} coming soon!'),
                    ),
                  );
                  break;
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getIconForIndex(index),
                    size: 40,
                    color: Colors.blue.shade900,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getLabelForIndex(index),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onBottomNavBarTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Helper function to get icons for each square
  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.list_alt; // Todos
      case 1:
        return Icons.star; // Favorites
      case 2:
        return Icons.location_on; // Locations
      default:
        return Icons.build; // Placeholder
    }
  }

  // Helper function to get labels for each square
  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Todos';
      case 1:
        return 'Favorites';
      case 2:
        return 'Locations';
      default:
        return 'Coming Soon';
    }
  }
}
