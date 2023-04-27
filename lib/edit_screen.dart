import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app_bloc/blocs/workout_cubit.dart';
import 'package:gym_app_bloc/blocs/workout_state.dart';
import 'package:gym_app_bloc/helper.dart';
import 'package:gym_app_bloc/model_class/edit_exercise_screen.dart';
import 'package:gym_app_bloc/model_class/exerices.dart';

class EditWorkOutScreen extends StatelessWidget {
  const EditWorkOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => BlocProvider.of<WorkoutCubit>(context).goHome(),
      child: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          WorkoutEditing we = state as WorkoutEditing;
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () =>
                    BlocProvider.of<WorkoutCubit>(context).goHome(),
              ),
            ),
            body: ListView.builder(
              itemCount: we.workout!.exercises.length,
              itemBuilder: (context, index) {
                Exercise exercise = we.workout!.exercises[index];
                if(we.exIndex == index)
                {
                  return EditExerciseScreen(index: index,workout: we.workout,exIndex: we.exIndex,);
                }
                else {
                  return ListTile(
                  leading: Text(
                    formateTime(exercise.prelude!, true),
                  ),
                  title: Text(exercise.title!),
                  trailing: Text(
                    formateTime(
                      exercise.duration!,
                      true,
                    ),
                  ),

                  onTap: () => BlocProvider.of<WorkoutCubit>(context).editExercise(index),
                );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
