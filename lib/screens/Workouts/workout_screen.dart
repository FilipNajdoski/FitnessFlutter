import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/shared/workoutProvider.dart';
import 'package:untitled/widgets/workout_card.dart';

class WorkoutListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("WOD's"),
      ),
      body: ListView.builder(
        itemCount: workoutProvider.workouts.length,
        itemBuilder: (context, index) {
          final workout = workoutProvider.workouts[index];
          return WorkoutCard(
            workout: workout,
            onMarkAsDone: () {
              workoutProvider.toggleMarkAsDone(index);
            },
          );
        },
      ),
    );
  }
}
