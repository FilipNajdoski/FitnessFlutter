import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/profile.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;

  final List<User> _users = [
    User(
      username: 'admin',
      password: 'admin123',
      profile: Profile(
        id: 1,
        name: 'Admin',
        lastName: 'Doe',
        email: 'admin@gmail.com',
        profileImg:
            'https://media.istockphoto.com/id/841195992/photo/she-aspires-to-inspire-fitness-in-herself-everyday.jpg?s=612x612&w=0&k=20&c=FT-hoycTbTEgm9iCVTzckp_ZCoy-93I3TJeQWk3GFF0=',
      ),
    ),
  ];

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  Profile? get userProfile => _currentUser?.profile;

  void login(String username, String password, BuildContext context) {
    try {
      final user = _users.firstWhere(
        (u) => u.username == username && u.password == password,
        orElse: () => User(
          username: '',
          password: '',
          profile: Profile(id: 0, name: '', lastName: '', email: ''),
        ),
      );

      if (user.username.isNotEmpty) {
        _currentUser = user;
        notifyListeners();
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials')),
        );
      }
    } catch (e) {
      print('Login Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while logging in: $e')),
      );
    }
  }

  Future<void> register(String username, String password, String name,
      String lastName, String email, BuildContext context) async {
    try {
      if (_users.any((u) => u.username == username)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username already exists')),
        );
        return;
      }

      final newUser = User(
        username: username,
        password: password,
        profile: Profile(
          id: _users.length + 1,
          name: name,
          lastName: lastName,
          email: email,
        ),
      );

      _users.add(newUser);
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful! Please login')),
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    } catch (e) {
      print('Registration Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while registering: $e')),
      );
    }
  }

  void updateProfile(Profile newProfile) {
    if (_currentUser != null) {
      _currentUser = User(
        username: _currentUser!.username,
        password: _currentUser!.password,
        profile: newProfile,
      );
      notifyListeners();
    }
  }

  void logout(BuildContext context) {
    _currentUser = null;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }
}
