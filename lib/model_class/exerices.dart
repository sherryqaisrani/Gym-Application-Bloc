import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  String? title;
  int? prelude;
  int? duration;
  int? index;
  int? startTime;

  Exercise({required this.title, required this.prelude, required this.duration, this.index, this.startTime});

  factory Exercise.fromJson(Map<String, dynamic> json, int index, int startTime) => Exercise(
      title: json['title'],
      prelude: json['prelude'],
      duration: json['duration'],
      index:  index,
      startTime: startTime
      );

  Map<String,dynamic> toJson() =>{
    "title": title,
    "prelude":prelude,
    "duration": duration
  } ;
  
  @override
  // TODO: implement props
  List<Object?> get props => [title, prelude, duration, index, startTime];
  @override
  // TODO: implement stringify
  bool? get stringify => true;
}
