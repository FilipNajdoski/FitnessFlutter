import 'package:flutter/material.dart';
import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  Profile? _profile = Profile(
    id: 1,
    name: 'John',
    lastName: 'Doe',
    email: 'johndoe@gmail.com',
    profileImg:
        'https://media.istockphoto.com/id/841195992/photo/she-aspires-to-inspire-fitness-in-herself-everyday.jpg?s=612x612&w=0&k=20&c=FT-hoycTbTEgm9iCVTzckp_ZCoy-93I3TJeQWk3GFF0=',
  );

  Profile? get profile => _profile;

  String get profileImg =>
      _profile?.profileImg ?? 'https://via.placeholder.com/150';
  String get name => _profile?.name ?? 'Guest';

  void setProfile(Profile profile) {
    _profile = profile;
    notifyListeners();
  }

  void clearProfile() {
    _profile = null;
    notifyListeners();
  }
}
