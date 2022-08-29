import 'dart:async';

import 'package:flutter/material.dart';

class EasyDebounce extends Stream<dynamic> {
  StreamController<dynamic> _dataStreamController = StreamController<dynamic>();
  Duration? duration;
  DebounceHandler _debounceHandler;

  EasyDebounce({this.duration}) : _debounceHandler = DebounceHandler(duration: duration);

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
  Duration? duration;
  Timer? timer;

  DebounceHandler({this.duration});

  void debounce(VoidCallback debounceFunction) {
    if (timer?.isActive ?? false) timer?.cancel();
    timer = Timer(duration ?? const Duration(milliseconds: 1000), () {
      debounceFunction.call();
    });
  }
}
