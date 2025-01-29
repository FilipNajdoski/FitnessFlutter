import 'package:untitled/models/profile.dart';

class User {
  final String username;
  final String password;
  final Profile profile;

  User({
    required this.username,
    required this.password,
    required this.profile,
  });
}
