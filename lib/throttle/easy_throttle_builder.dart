import 'package:easy_debounce_throttle/throttle/easy_throttle.dart';
import 'package:flutter/widgets.dart';

typedef ThrottleCallback = Function(VoidCallback callback);

typedef EasyThrottleWidgetBuilder = Widget Function(
  BuildContext context,
  ThrottleCallback throttleCallback,
);

/// EasyThrottleBuilder provides the debounce function as Widget.
class EasyThrottleBuilder extends StatefulWidget {
  const EasyThrottleBuilder({Key? key, required this.builder, this.delay = const Duration(milliseconds: 1000)}) : super(key: key);

  final EasyThrottleWidgetBuilder builder;
  final Duration delay;

  @override
  State<EasyThrottleBuilder> createState() => _EasyThrottleBuilderState();
}

class _EasyThrottleBuilderState extends State<EasyThrottleBuilder> {
  EasyThrottle? _easyThrottle;
  VoidCallback? _callback;

  void _initEasyThrottle() {
    _easyThrottle = EasyThrottle(delay: widget.delay);
    _easyThrottle?.listen((data) {
      _callback?.call();
    });
  }

  void _throttle(VoidCallback callback) {
    _callback = callback;
    _easyThrottle?.throttle(callback);
  }

  @override
  void initState() {
    super.initState();
    _initEasyThrottle();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _throttle);
  }

  @override
  void didUpdateWidget(covariant EasyThrottleBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.delay.inMicroseconds != widget.delay.inMicroseconds) {
      _easyThrottle?.close();
      _initEasyThrottle();
    }
  }
}
