import 'package:fitnesstracker/data/workout_data.dart';
import 'package:fitnesstracker/pages/workout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newWorkoutNameController = TextEditingController();
  void createNewWorkout() {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: Text("create new dialogs"),
              content: TextField(
                controller: newWorkoutNameController,
              ),
              actions: [
                MaterialButton(
                  onPressed: save,
                  child: Text("save"),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: Text("cancel"),
                )
              ],
            )));
  }

  void save() {
    String newWorkoutName = newWorkoutNameController.text;
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
    Navigator.pop(context);
  }

  void cancel() {
    Navigator.pop(context);
  }

  void goToWorkoutPage(String workoutName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WorkoutPage(
                  WorkoutName: workoutName,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text("Workout Tracker"),
          elevation: 0,
        ),
        body: ListView.builder(
          itemCount: value.getWorkoutList().length,
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(value.getWorkoutList()[index].name),
              trailing: IconButton(
                  onPressed: () =>
                      goToWorkoutPage(value.getWorkoutList()[index].name),
                  icon: Icon(Icons.arrow_forward_ios)),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewWorkout,
          child: Icon(Icons.edit),
        ),
      ),
    );
  }
}
