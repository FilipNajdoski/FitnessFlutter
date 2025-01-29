import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/screens/Authorization/login_screen.dart';
import 'package:untitled/screens/Authorization/register_screen.dart';
import 'package:untitled/screens/Workouts/workout_screen.dart';
import 'package:untitled/screens/home.dart';
import 'package:untitled/screens/homepage_screen.dart';
import 'package:untitled/shared/nutritionProvider.dart';
import 'package:untitled/shared/themeProvider.dart';
import '../shared/favoriteProvider.dart';
import '../shared/todosProvider.dart';
import '../shared/locationsProvider.dart';
import '../shared/profileProvider.dart';
import '../shared/workoutProvider.dart';
import '../shared/authProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
        ChangeNotifierProvider(create: (context) => TodosProvider()),
        ChangeNotifierProvider(create: (context) => LocationsProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => WorkoutProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => NutritionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Workout App',
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => Consumer<AuthProvider>(
              builder: (context, auth, child) =>
                  auth.isAuthenticated ? HomePage() : const LoginScreen(),
            ),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => HomePage(),
      },
      //home: WorkoutListScreen(),
      //home: HomePage(),
      //home: const HomePageScreen(),
    );
  }
}
