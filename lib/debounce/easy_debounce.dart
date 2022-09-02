import 'dart:async';

import 'package:flutter/material.dart';

class EasyDebounce extends Stream<dynamic> {
  final DebounceHandler _debounceHandler;
  final StreamController<dynamic> _dataStreamController = StreamController<dynamic>();

  Duration? delay;

  EasyDebounce({this.delay}) : _debounceHandler = DebounceHandler(delay: delay);

  void _execute(dynamic data) async => _debounceHandler.debounce(_sinkData(data));

  VoidCallback _sinkData(dynamic data) => () => _dataStreamController.sink.add(data);

  void debounce(dynamic data) async => _execute(data);

  @override
  StreamSubscription listen(void Function(dynamic data)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError}) => _dataStreamController.stream.listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );

  void close() => _dataStreamController.close;
}

class DebounceHandler {
  Duration? delay;
  Timer? timer;

  DebounceHandler({this.delay});

  void debounce(VoidCallback debounceFunction) {
    if (timer?.isActive ?? false) timer?.cancel();
    timer = Timer(delay ?? const Duration(milliseconds: 1000), () {
      debounceFunction.call();
    });
  }
}
