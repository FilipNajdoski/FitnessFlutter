class Profile {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String? profileImg;

  Profile(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.email,
      this.profileImg});
}
