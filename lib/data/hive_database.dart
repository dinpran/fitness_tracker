import 'package:fitnesstracker/datetime/date_time.dart';
import 'package:fitnesstracker/models/exercises.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/workout.dart';

class HiveDatabase {
  final _mybox = Hive.box("workout_database");

  bool previousDataExists() {
    if (_mybox.isEmpty) {
      print("previous data does NOT exist");
      _mybox.put("START_DATE", todaysDateYYYYMMDD());
      return false;
    } else {
      print("previous data does exist");
      return true;
    }
  }

  String getStartDate() {
    return _mybox.get("START_DATE");
  }
}

List<String> convertObjectToWorkoutList(List<Workout> workouts) {
  List<String> workoutList = [];

  for (int i = 0; i < workouts.length; i++) {
    workoutList.add(
      workouts[i].name,
    );
  }

  return workoutList;
}

List<List<List<String>>> convertObjectToExerciseList(List<Workout> workouts) {
  List<List<List<String>>> exerciseList = [];

  for (int i = 0; i < workouts.length; i++) {
    List<Exercise> exerciseInWorkout = workouts[i].exercises;
    List<List<String>> individualWorkout = [];
    for (int j = 0; j < exerciseInWorkout.length; j++) {
      List<String> individualExercise = [];
      individualExercise.addAll([
        exerciseInWorkout[j].name,
        exerciseInWorkout[j].weight,
        exerciseInWorkout[j].reps,
        exerciseInWorkout[j].sets,
        exerciseInWorkout[j].isCompleted.toString(),
      ]);
      individualWorkout.add(individualExercise);
    }
    exerciseList.add(individualWorkout);
  }

  return exerciseList;
}
