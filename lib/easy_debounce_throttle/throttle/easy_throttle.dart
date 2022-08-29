import 'dart:async';

import 'package:flutter/material.dart';

class EasyThrottle extends Stream<dynamic> {
  StreamController<dynamic> _dataStreamController = StreamController<dynamic>();

  Duration? duration;
  ThrottleHandler _throttleHandler;

  EasyThrottle({this.duration}) : _throttleHandler = ThrottleHandler(duration: duration);

  void _execute(dynamic data) async => _throttleHandler.throttle(_sinkData(data));

  VoidCallback _sinkData(dynamic data) => () => _dataStreamController.sink.add(data);

  void throttle(dynamic data) async => _execute(data);

  @override
  StreamSubscription listen(void Function(dynamic data)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError}) => _dataStreamController.stream.listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );

  void close() => _dataStreamController.close;
}

class ThrottleHandler {
  Duration? duration;
  bool isClickable = true;

  ThrottleHandler({this.duration});

  void throttle(VoidCallback callback) {
    if (isClickable) {
      isClickable = false;
      callback.call();
      Future.delayed(duration ?? const Duration(milliseconds: 1000), () {
        isClickable = true;
      });
    }
  }
}
