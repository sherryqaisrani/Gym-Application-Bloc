import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app_bloc/blocs/workout_bloc.dart';
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
      home: BlocProvider<WorkoutBloc>(
        create: (context) {
          WorkoutBloc workoutBloc = WorkoutBloc();
          if (workoutBloc.state.isEmpty) {
            print("Data is loading");
            workoutBloc.getLoadData();
          } else {
            print('Data is empty');
          }
          return workoutBloc;
        },
        child: const MyHomePage(),
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
        child: BlocBuilder<WorkoutBloc, List<Workout>>(
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
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                      title: Text(workout.title!),
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
                        leading: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                        title: Text(workout.exercises[index].title!),
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
