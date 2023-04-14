import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app_bloc/blocs/workout_cubit.dart';
import 'package:gym_app_bloc/blocs/workout_state.dart';
import 'package:gym_app_bloc/blocs/workouts_bloc.dart';
import 'package:gym_app_bloc/edit_screen.dart';
import 'package:gym_app_bloc/helper.dart';
import 'package:gym_app_bloc/model_class/workout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<WorkoutsBloc>(
            create: (context) {
              WorkoutsBloc workoutBloc = WorkoutsBloc();
              if (workoutBloc.state.isEmpty) {
                print("Data is loading");
                workoutBloc.getLoadData();
              } else {
                print('Data is empty');
              }
              return workoutBloc;
            },
          ),
          BlocProvider<WorkoutCubit>(
            create: (context) => WorkoutCubit(),
          ),
        ],
        child: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            if (state is WorkoutInitial) {
              return const MyHomePage();
            } else if (state is WorkoutEditing) {
              
              return const EditWorkOutScreen();
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Time'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.event_available,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<WorkoutsBloc, List<Workout>>(
          builder: (context, state) => ExpansionPanelList.radio(
            children: state
                .map(
                  (workout) => ExpansionPanelRadio(
                    value: workout,
                    headerBuilder: (context, isExpanded) => ListTile(
                      visualDensity: const VisualDensity(
                        horizontal: 0,
                        vertical: VisualDensity.maximumDensity,
                      ),
                      leading: IconButton(
                        onPressed: () {
                          BlocProvider.of<WorkoutCubit>(context).editWorkout(
                            workout,
                            state.indexOf(
                              workout,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                      title: Text(workout.title!),
                      trailing: Text(
                        formateTime(
                          workout.getTotal(),
                          true,
                        ),
                      ),
                    ),
                    body: ListView.builder(
                      itemCount: workout.exercises.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => ListTile(
                        visualDensity: const VisualDensity(
                          horizontal: 0,
                          vertical: VisualDensity.maximumDensity,
                        ),
                        leading: Text(
                          formateTime(
                            workout.exercises[index].prelude!,
                            true,
                          ),
                        ),
                        title: Text(workout.exercises[index].title!),
                        trailing: Text(
                          formateTime(
                            workout.exercises[index].duration!,
                            true,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
