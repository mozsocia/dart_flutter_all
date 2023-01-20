``` dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// new counter bloc

class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class CounterState {
  final int? value;
  final String? error;

  CounterState({this.value, this.error});

  CounterState copyWith({int? value, String? error}) {
    return CounterState(
      value: value ?? this.value,
      error: error,
    );
  }
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(value: 0, error: null)) {
    on<IncrementEvent>((event, emit) {
      emit(state.copyWith(value: state.value! + 1, error: null));
    });

    on<DecrementEvent>((event, emit) {
      if (state.value! > 0) {
        emit(state.copyWith(value: state.value! - 1));
      } else {
        emit(state.copyWith(error: "Cannot decrement below 0"));
      }
    });
  }
}

// main file
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
        debugPrint("${state.value} ${state.error}");
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.error ?? "",
                style: TextStyle(fontSize: 24.0),
              ),
              Text(
                '${state.value}',
                style: TextStyle(fontSize: 24.0),
              ),
            ],
          ),
        );
      }),
      //
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              counterBloc.add(IncrementEvent());
            },
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () {
              counterBloc.add(DecrementEvent());
            },
          ),
        ],
      ),
    );
  }
}
```