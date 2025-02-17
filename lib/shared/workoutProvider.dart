import 'package:flutter/material.dart';
import 'package:untitled/models/workout.dart';

class WorkoutProvider with ChangeNotifier {
  final List<Workout> _workouts = [
    Workout(
      mainTitle: "2013 CrossFit Games Open",
      wodTitle: "OPEN 13.2",
      wodType: "AMRAP",
      wodTime: "10 minutes",
      movements: [
        Movement(reps: 5, name: "Shoulder-to-Overheads", weight: "115/75 lb"),
        Movement(reps: 10, name: "Deadlifts", weight: "115/75 lb"),
        Movement(reps: 15, name: "Box Jumps", weight: "24/20 in"),
      ],
      likes: 129,
      comments: 24,
    ),
    Workout(
      mainTitle: "2021 CrossFit Games Open",
      wodTitle: "OPEN 21.1",
      wodType: "For Time",
      wodTime: "20 minutes",
      movements: [
        Movement(reps: 1, name: "Wall Walks", weight: "Bodyweight"),
        Movement(reps: 10, name: "Double Unders", weight: "Rope"),
      ],
      likes: 89,
      comments: 12,
    ),
    Workout(
      mainTitle: "2013 CrossFit Games Open",
      wodTitle: "OPEN 13.2",
      wodType: "AMRAP",
      wodTime: "10 minutes",
      movements: [
        Movement(reps: 5, name: "Shoulder-to-Overheads", weight: "115/75 lb"),
        Movement(reps: 10, name: "Deadlifts", weight: "115/75 lb"),
        Movement(reps: 15, name: "Box Jumps", weight: "24/20 in"),
      ],
      likes: 129,
      comments: 24,
    ),
    Workout(
      mainTitle: "2021 CrossFit Games Open",
      wodTitle: "OPEN 21.1",
      wodType: "For Time",
      wodTime: "20 minutes",
      movements: [
        Movement(reps: 1, name: "Wall Walks", weight: "Bodyweight"),
        Movement(reps: 10, name: "Double Unders", weight: "Rope"),
      ],
      likes: 89,
      comments: 12,
    ),
    Workout(
      mainTitle: "2013 CrossFit Games Open",
      wodTitle: "OPEN 13.2",
      wodType: "AMRAP",
      wodTime: "10 minutes",
      movements: [
        Movement(reps: 5, name: "Shoulder-to-Overheads", weight: "115/75 lb"),
        Movement(reps: 10, name: "Deadlifts", weight: "115/75 lb"),
        Movement(reps: 15, name: "Box Jumps", weight: "24/20 in"),
      ],
      likes: 129,
      comments: 24,
    ),
    Workout(
      mainTitle: "2021 CrossFit Games Open",
      wodTitle: "OPEN 21.1",
      wodType: "For Time",
      wodTime: "20 minutes",
      movements: [
        Movement(reps: 1, name: "Wall Walks", weight: "Bodyweight"),
        Movement(reps: 10, name: "Double Unders", weight: "Rope"),
      ],
      likes: 89,
      comments: 12,
    ),
    Workout(
      mainTitle: "2013 CrossFit Games Open",
      wodTitle: "OPEN 13.2",
      wodType: "AMRAP",
      wodTime: "10 minutes",
      movements: [
        Movement(reps: 5, name: "Shoulder-to-Overheads", weight: "115/75 lb"),
        Movement(reps: 10, name: "Deadlifts", weight: "115/75 lb"),
        Movement(reps: 15, name: "Box Jumps", weight: "24/20 in"),
      ],
      likes: 129,
      comments: 24,
    ),
    Workout(
      mainTitle: "2021 CrossFit Games Open",
      wodTitle: "OPEN 21.1",
      wodType: "For Time",
      wodTime: "20 minutes",
      movements: [
        Movement(reps: 1, name: "Wall Walks", weight: "Bodyweight"),
        Movement(reps: 10, name: "Double Unders", weight: "Rope"),
      ],
      likes: 89,
      comments: 12,
    ),
  ];

  List<Workout> get workouts => _workouts;

  void toggleMarkAsDone(int index) {
    _workouts[index] = Workout(
      mainTitle: _workouts[index].mainTitle,
      wodTitle: _workouts[index].wodTitle,
      wodType: _workouts[index].wodType,
      wodTime: _workouts[index].wodTime,
      movements: _workouts[index].movements,
      likes: _workouts[index].likes,
      comments: _workouts[index].comments,
      isMarkedAsDone: !_workouts[index].isMarkedAsDone,
    );
    notifyListeners();
  }
}
