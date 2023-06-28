import 'package:fitnesstracker/models/exercises.dart';
import 'package:fitnesstracker/models/workout.dart';
import 'package:flutter/cupertino.dart';

class WorkoutData extends ChangeNotifier {
  List<Workout> workoutlist = [
    Workout(name: "Upper Body", exercises: [
      Exercise(
          name: "Bicep Curls",
          weight: "10",
          reps: "10",
          sets: "3",
          isCompleted: false)
    ]),
    Workout(name: "Upper Body", exercises: [
      Exercise(
          name: "Bicep Curls",
          weight: "10",
          reps: "10",
          sets: "3",
          isCompleted: false)
    ]),
  ];

  //get list of workouts
  List<Workout> getWorkoutList() {
    return workoutlist;
  }

  // get length of workouts
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  //add a Workout
  void addWorkout(String name) {
    workoutlist.add(Workout(name: name, exercises: []));
    notifyListeners();
  }

  //add a exercise
  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.exercises.add(Exercise(
      name: exerciseName,
      weight: weight,
      reps: reps,
      sets: sets,
    ));
    notifyListeners();
  }

  //check whether the exercise is completed or not
  void checkOffExercise(String workoutName, String exerciseName) {
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners();
  }

  //gwtting a relevant workout
  Workout getRelevantWorkout(workoutName) {
    Workout relevantWorkout =
        workoutlist.firstWhere((workout) => workout.name == workoutName);
    return relevantWorkout;
  }

  //getting a relaevant exercise
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
    return relevantExercise;
  }
}
