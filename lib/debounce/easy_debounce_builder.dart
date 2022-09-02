import 'package:easy_debounce_throttle/debounce/easy_debounce.dart';
import 'package:flutter/widgets.dart';

typedef DebounceCallback = Function(VoidCallback callback);

typedef EasyDebounceWidgetBuilder = Widget Function(
  BuildContext context,
  DebounceCallback debounceCallback,
);

class EasyDebounceBuilder extends StatefulWidget {
  const EasyDebounceBuilder({Key? key, required this.builder, this.delay = const Duration(milliseconds: 1000)}) : super(key: key);

  final EasyDebounceWidgetBuilder builder;
  final Duration delay;

  @override
  State<EasyDebounceBuilder> createState() => _EasyDebounceBuilderState();
}

class _EasyDebounceBuilderState extends State<EasyDebounceBuilder> {
  EasyDebounce? _easyDebounce;
  VoidCallback? _callback;

  void _initEasyDebounce() {
    _easyDebounce = EasyDebounce(delay: widget.delay);
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
  void didUpdateWidget(covariant EasyDebounceBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.delay.inMicroseconds != widget.delay.inMicroseconds) {
      _easyDebounce?.close();
      _initEasyDebounce();
    }
  }
}
