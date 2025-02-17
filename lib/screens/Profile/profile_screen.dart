import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/utils/constants.dart';
import '../../shared/authProvider.dart';
import '../../shared/themeProvider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final profile = authProvider.userProfile;
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false)
                  .toggleDarkMode();
            },
            icon: Icon(isDark ? Icons.wb_sunny : Icons.nights_stay),
          ),
        ],
      ),
      body: profile == null
          ? const Center(child: Text('No profile data available.'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            profile.profileImg ?? defaultProfileImg,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: const Icon(Icons.edit,
                              color: Colors.black, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('${profile.name} ${profile.lastName}',
                      style: Theme.of(context).textTheme.headlineSmall),
                  Text('ID: ${profile.id}',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 20),

                  /// Edit Profile Button
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('Edit Profile',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  const SizedBox(height: 10),

                  /// Menu Options
                  ProfileMenuWidget(
                      title: "Settings", icon: Icons.settings, onPress: () {}),
                  ProfileMenuWidget(
                      title: "Billing Details",
                      icon: Icons.account_balance_wallet,
                      onPress: () {}),
                  ProfileMenuWidget(
                      title: "User Management",
                      icon: Icons.group,
                      onPress: () {}),
                  const Divider(),
                  const SizedBox(height: 10),
                  ProfileMenuWidget(
                      title: "Information", icon: Icons.info, onPress: () {}),
                  ProfileMenuWidget(
                    title: "Logout",
                    icon: Icons.logout,
                    textColor: Colors.red,
                    endIcon: false,
                    onPress: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("LOGOUT"),
                          content:
                              const Text("Are you sure you want to logout?"),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("No")),
                            ElevatedButton(
                              onPressed: () {
                                authProvider.logout(context);
                                Navigator.of(context)
                                    .pushReplacementNamed('/login');
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent),
                              child: const Text("Yes"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? textColor;
  final bool endIcon;
  final VoidCallback onPress;

  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.textColor,
    this.endIcon = true,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
      trailing: endIcon ? const Icon(Icons.arrow_forward_ios) : null,
    );
  }
}
