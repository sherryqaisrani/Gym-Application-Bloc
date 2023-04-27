import 'package:flutter/material.dart';
import 'package:gym_app_bloc/model_class/workout.dart';

class EditExerciseScreen extends StatefulWidget {
  final Workout? workout;
  final int index;
  final int? exIndex;
  EditExerciseScreen({
    super.key,
    this.exIndex,
    required this.index,
    this.workout,
  });

  @override
  State<EditExerciseScreen> createState() => _EditExerciseScreenState();
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  TextEditingController? _title;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _title = TextEditingController(
        text: widget.workout!.exercises[widget.exIndex!].title);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: TextField(
              textAlign: TextAlign.center,
              controller: _title,
              onChanged: (value) => setState(() {
                widget.workout!.exercises[widget.exIndex!] = widget
                    .workout!.exercises[widget.exIndex!]
                    .copyWith(title: value);
              }),
            ))
          ],
        )
      ],
    );
  }
}
