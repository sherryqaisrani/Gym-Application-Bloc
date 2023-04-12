import 'package:gym_app_bloc/model_class/exerices.dart';

class Workout{
  final String? title;
  final List<Exercise> exercises;

  Workout({required this.title, required this.exercises});
  

  factory Workout.fromJson(Map<String, dynamic> json){
    // return Workout(title: , exerices: exerices)
    List<Exercise> exercise = [];
    int index =0;
    int startTime = 0;
    for(var ex in (json['exercise'] as Iterable)){
      exercise.add(Exercise.fromJson(json, index, startTime));
      index++;
      startTime += exercise.last.prelude! + exercise.last.duration!;
    }
    return Workout(title: json['title'], exercises: exercise);
  }

  Map<String,dynamic> toJson()=> {'title': title, 'exercise':exercises};

}