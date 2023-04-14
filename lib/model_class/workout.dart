import 'package:equatable/equatable.dart';
import 'package:gym_app_bloc/model_class/exerices.dart';

class Workout extends Equatable{

  final String? title;
  final List<Exercise> exercises;

  Workout({required this.title, required this.exercises});
  

  factory Workout.fromJson(Map<String, dynamic> json){
    // return Workout(title: , exerices: exerices)
    List<Exercise> exercises = [];
    int index =0;
    int startTime = 0;
    for(var ex in (json['exercises'] as Iterable)){
      exercises.add(Exercise.fromJson(ex, index, startTime));
      index++;
      print(index);
      startTime += exercises.last.prelude! + exercises.last.duration!;
    }
    return Workout(title: json['title'], exercises: exercises);
  }

  Map<String,dynamic> toJson()=> {'title': title, 'exercise':exercises};

  int getTotal(){
    int time = exercises.fold(0, (previousValue, element) =>previousValue+ element.duration! + element.prelude!);
    return time;
  }  
  @override
  // TODO: implement props
  List<Object?> get props => [title, exercises];

  @override
  // TODO: implement stringify
  bool? get stringify => true;

}