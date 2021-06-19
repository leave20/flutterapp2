import 'dart:async';

import 'package:flutterapp2/bloc/Repository.dart';

class DoubleBase {}

class DoubleEvent extends DoubleBase {}

class ClearEvent extends DoubleBase {}

class FetchEvent extends DoubleBase{}

class DoubleBloc {
  CounterRepository repository = CounterRepository();

  StreamController<DoubleBase> _input = StreamController();
  StreamController<int> _output = StreamController();

  Stream<int> get couterStream => _output.stream;

  StreamSink<DoubleBase> get sendEvent => _input.sink;

  DoubleBloc() {
    _input.stream.listen((event) {
      if (event is DoubleEvent) {
        repository.double();
      } else if(event is ClearEvent) {
        repository.clear();
      }
      _output.add(repository.get());
    });
  }

  void dispose() {
    _input.close();
    _output.close();
  }
}
