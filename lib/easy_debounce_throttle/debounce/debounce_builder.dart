import 'package:easy_debounce_throttle/easy_debounce_throttle/debounce/easy_debounce.dart';
import 'package:flutter/widgets.dart';

/// Callback call after delay
typedef DebounceCallback = void Function(VoidCallback callback);

/// Debounce builder, provide debounce function
typedef EasyDebounceBuilder = Widget Function(
  BuildContext context,
  DebounceCallback debounceCallback,
);

/// Widget provide debounce function
class DebounceBuilder extends StatefulWidget {
  const DebounceBuilder({Key? key, required this.builder, this.delay = const Duration(milliseconds: 1000)}) : super(key: key);

  final EasyDebounceBuilder builder;
  final Duration delay;

  @override
  State<DebounceBuilder> createState() => _DebounceBuilderState();
}

class _DebounceBuilderState extends State<DebounceBuilder> {
  EasyDebounce? _easyDebounce;
  VoidCallback? _callback;

  void _initEasyDebounce() {
    _easyDebounce = EasyDebounce(duration: widget.delay);
    _easyDebounce?.listen((data) {
      _callback?.call();
    });
  }

  void _debounce(VoidCallback callback) {
    _callback = callback;
    _easyDebounce?.debounce(callback);
  }

  @override
  void initState() {
    super.initState();
    _initEasyDebounce();
  }

  @override
  void dispose() {
    _easyDebounce?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _debounce);
  }

  @override
  void didUpdateWidget(covariant DebounceBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.delay.inMicroseconds != widget.delay.inMicroseconds) {
      _easyDebounce?.close();
      _initEasyDebounce();
    }
  }
}
