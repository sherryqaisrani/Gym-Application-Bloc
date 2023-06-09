import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app_bloc/blocs/workout_state.dart';
import 'package:gym_app_bloc/model_class/workout.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(WorkoutInitial());

  editWorkout(Workout workout, int index) =>
      emit(WorkoutEditing(workout, index, null));


  editExercise(int? exIndex) =>
      emit(WorkoutEditing(state.workout!, (state as WorkoutEditing).index, exIndex! ));

  goHome() => emit(WorkoutInitial());
}
