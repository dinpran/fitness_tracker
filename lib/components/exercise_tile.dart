import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  void Function(bool?)? onCheckBoxChanged;
  ExerciseTile(
      {super.key,
      required this.exerciseName,
      required this.weight,
      required this.reps,
      required this.sets,
      required this.isCompleted,
      required this.onCheckBoxChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 25, 18, 0),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.yellow,
        ),
        child: ListTile(
          title: Text(exerciseName),
          subtitle: Row(
            children: [
              Chip(label: Text("${weight}kg")),
              Chip(label: Text("${reps}reps")),
              Chip(label: Text("${sets}sets")),
            ],
          ),
          trailing: Checkbox(
              value: isCompleted,
              onChanged: (value) => onCheckBoxChanged!(value)),
        ),
      ),
    );
  }
}
