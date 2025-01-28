import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/screens/Nutrition/nutrition_screen.dart';
import 'package:untitled/screens/Profile/about.dart';
import 'package:untitled/screens/Profile/contact.dart';
import 'package:untitled/screens/Workouts/workout_completed.dart';
import 'package:untitled/screens/Workouts/workout_screen.dart';
import 'package:untitled/shared/profileProvider.dart';
import 'package:untitled/widgets/calendar_widget.dart';
import 'package:untitled/widgets/home_card_widget.dart';
import 'package:untitled/screens/Profile/profile_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      drawer: Drawer(
        child: Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(profileProvider.profileImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      profileProvider.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('My Profile'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contact_mail),
                  title: Text('Contact'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactScreen()),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200.0, // Constrain the height for each card
              child: HomeCardWidget(
                title: 'Workouts',
                imageUrl:
                    'https://media.istockphoto.com/id/625739874/photo/heavy-weight-exercise.jpg?s=612x612&w=0&k=20&c=B1uzJW1DBei2Rx5hnt139tt9dt3L7TbKrpgwbMR-LrI=',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkoutListScreen(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 200.0,
              child: HomeCardWidget(
                title: 'Completed Workouts',
                imageUrl:
                    'https://media.istockphoto.com/id/1395689671/video/fit-woman-using-weights-and-training-equipment-for-muscle-training-in-a-gym.jpg?s=640x640&k=20&c=-l5_JPK3nKos3XmsQ_MQ9s5fuPWiALBJWiziiDWDYcg=',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkoutCompletedScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 200.0,
              child: HomeCardWidget(
                title: 'Nutrition',
                imageUrl:
                    'https://media.istockphoto.com/id/1468860049/photo/fitness-woman-eating-a-healthy-poke-bowl-in-the-kitchen-at-home.jpg?s=612x612&w=0&k=20&c=XDY46BP4RgFqq27GjLYbrAhIUnz3rkKXlu0axO-N39A=',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NutritionScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 200.0,
              child: HomeCardWidget(
                title: 'Workouts Schedule',
                imageUrl:
                    'https://media.istockphoto.com/id/600165836/photo/urban-female-athlete-focusing-on-her-goals-writting-on-notepad.jpg?s=612x612&w=0&k=20&c=X51Rme350KEUrcjmQPdtVem6Mpq5gQaJTnn50WqWVYc=',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CalendarScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 200.0,
              child: HomeCardWidget(
                title: 'Statistics',
                imageUrl:
                    'https://media.istockphoto.com/id/1194895581/photo/woman-tracking-her-fitness-progress-on-an-app-while-running.jpg?s=612x612&w=0&k=20&c=oFuhn3Rr6xOx_Wai7K5OMZIJeP6hDbhvaeAAzeMHfhY=',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Statistics card tapped!'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
