import 'package:easy_debounce_throttle/easy_debounce_throttle/throttle/easy_throttle.dart';
import 'package:flutter/widgets.dart';

typedef EasyThrottleWidgetBuilder = Widget Function(
  BuildContext context,
  Function(VoidCallback callback) throttleFirstCallback,
);

class ThrottleBuilder extends StatefulWidget {
  const ThrottleBuilder({Key? key, required this.builder, this.delay = const Duration(milliseconds: 1000)}) : super(key: key);

  final EasyThrottleWidgetBuilder builder;
  final Duration delay;

  @override
  State<ThrottleBuilder> createState() => _ThrottleBuilderState();
}

class _ThrottleBuilderState extends State<ThrottleBuilder> {
  EasyThrottle? _easyThrottle;
  VoidCallback? _callback;

  void _initEasyThrottle() {
    _easyThrottle = EasyThrottle(duration: widget.delay);
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
  void didUpdateWidget(covariant ThrottleBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.delay.inMicroseconds != widget.delay.inMicroseconds) {
      _easyThrottle?.close();
      _initEasyThrottle();
    }
  }
}
