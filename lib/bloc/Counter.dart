import 'dart:async';

import 'package:flutterapp2/bloc/Repository.dart';

class CounterBase {}

class IncrementCounter extends CounterBase {}

class ClearCounter extends CounterBase {}

class FetchCounter extends CounterBase{}

class CounterBlock {
  CounterRepository repository = CounterRepository();


  StreamController<CounterBase> _input = StreamController();
  StreamController<int> _output = StreamController();

  Stream<int> get counterStream => _output.stream;

  StreamSink<CounterBase> get sendEvent => _input.sink;

  CounterBlock() {
    _input.stream.listen((event) {
      if (event is IncrementCounter) {
        repository.increment();
      } else if(event is ClearCounter){
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
