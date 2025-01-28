import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/shared/workoutProvider.dart';
import 'package:untitled/widgets/workout_card.dart';

class WorkoutCompletedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);

    // Filter only workouts that are marked as done
    final completedWorkouts = workoutProvider.workouts
        .where((workout) => workout.isMarkedAsDone)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Completed Workouts"),
      ),
      body: completedWorkouts.isEmpty
          ? Center(
              child: Text(
                "No completed workouts yet!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: completedWorkouts.length,
              itemBuilder: (context, index) {
                final workout = completedWorkouts[index];
                return WorkoutCard(
                  workout: workout,
                  // Since it's a completed screen, you might not need to mark as done
                  onMarkAsDone: null,
                );
              },
            ),
    );
  }
}
