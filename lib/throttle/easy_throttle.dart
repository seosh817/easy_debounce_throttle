import 'dart:async';

import 'package:flutter/material.dart';

/// EasyThrottle provides the throttle function as Stream.
class EasyThrottle extends Stream<dynamic> {
  final ThrottleHandler _throttleHandler;
  final StreamController<dynamic> _dataStreamController = StreamController<dynamic>();

  Duration? delay;

  EasyThrottle({this.delay}) : _throttleHandler = ThrottleHandler(delay: delay);

  /// When data flows into the Stream, ThrottleHandler internally executes the throttle function.
  void _execute(dynamic data) async => _throttleHandler.throttle(_sinkData(data));

  /// Sink data.
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

/// ThrottleHandler perform throttle function.
class ThrottleHandler {
  Duration? delay;
  bool isClickable = true;

  ThrottleHandler({this.delay});

  /// Throttle during delay.
  void throttle(VoidCallback callback) {
    if (isClickable) {
      isClickable = false;
      callback.call();
      Future.delayed(delay ?? const Duration(milliseconds: 1000), () {
        isClickable = true;
      });
    }
  }
}
