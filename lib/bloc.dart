import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import 'model.dart';
import 'repository/networkcalls.dart';

abstract class BaseBloc {
  void dispose();
}

class Bloc implements BaseBloc {
  Bloc() {
    networkCalls.init().listen((events) => _input.add(events));
  }

  final _dataControler = StreamController<Event>();

  Stream<Event> get out => _dataControler.stream;

  Sink<Event> get _input => _dataControler.sink;

  void upload(Model model) async {
    await networkCalls.uploadData(model);
  }

  @override
  void dispose() {
    _dataControler.close();
  }
}
