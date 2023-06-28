import 'package:fitnesstracker/components/exercise_tile.dart';
import 'package:fitnesstracker/data/workout_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  final String WorkoutName;
  const WorkoutPage({super.key, required this.WorkoutName});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  void onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(workoutName, exerciseName);
  }

  void save() {
    String newExerciseName = exerciseNameController.text;
    String exerciseName = exerciseNameController.text;
    String weight = weightController.text;
    String reps = repsController.text;
    String sets = setsController.text;
    Provider.of<WorkoutData>(context, listen: false)
        .addExercise(widget.WorkoutName, exerciseName, weight, reps, sets);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    exerciseNameController.clear();
    weightController.clear();
    repsController.clear(); //slafklaf
    setsController.clear();
  }

  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  final setsController = TextEditingController();

  void createNewExercise() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add a new exercise"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: exerciseNameController,
            ),
            TextField(
              controller: weightController,
            ),
            TextField(
              controller: repsController,
            ),
            TextField(
              controller: setsController,
            ),
            MaterialButton(
              onPressed: save,
              child: Text("save"),
            ),
            MaterialButton(
              onPressed: cancel,
              child: Text("cancel"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.WorkoutName),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewExercise,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: value.numberOfExercisesInWorkout(widget.WorkoutName),
            itemBuilder: ((context, index) => ExerciseTile(
                  exerciseName: value
                      .getRelevantWorkout(widget.WorkoutName)
                      .exercises[index]
                      .name,
                  weight: value
                      .getRelevantWorkout(widget.WorkoutName)
                      .exercises[index]
                      .weight,
                  reps: value
                      .getRelevantWorkout(widget.WorkoutName)
                      .exercises[index]
                      .reps,
                  sets: value
                      .getRelevantWorkout(widget.WorkoutName)
                      .exercises[index]
                      .sets,
                  isCompleted: value
                      .getRelevantWorkout(widget.WorkoutName)
                      .exercises[index]
                      .isCompleted,
                  onCheckBoxChanged: (p0) => onCheckBoxChanged(
                      widget.WorkoutName,
                      value
                          .getRelevantWorkout(widget.WorkoutName)
                          .exercises[index]
                          .name),
                ))),
      ),
    );
  }
}
