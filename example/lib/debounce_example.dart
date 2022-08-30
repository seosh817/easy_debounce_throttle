import 'package:easy_debounce_throttle/easy_debounce_throttle/debounce/debounce_builder.dart';
import 'package:easy_debounce_throttle/easy_debounce_throttle/debounce/easy_debounce.dart';
import 'package:easy_debounce_throttle/easy_debounce_throttle/throttle/easy_throttle.dart';
import 'package:easy_debounce_throttle/easy_debounce_throttle/throttle/throttle_builder.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'easy_debounce_throttle example app',
      theme: ThemeData(primaryColor: Colors.blue, brightness: Brightness.dark),
      home: const ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  final EasyDebounce _easyDebounce = EasyDebounce();
  final EasyThrottle _easyThrottle = EasyThrottle();
  final TextEditingController _textController = TextEditingController();

  int _debounceCount = 0;
  int _throttleCount = 0;

  String _debounceText = '';
  String _throttleText = '';

  void _increaseDebounceCount() async {
    setState(() {
      _debounceCount++;
    });
  }

  void _increaseThrottleCount() async {
    setState(() {
      _throttleCount++;
    });
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      _easyDebounce.debounce(_textController.text);
      _easyThrottle.throttle(_textController.text);
    });
    _easyDebounce.listen((data) {
      setState(() {
        _debounceText = '$data';
      });
    });
    _easyThrottle.listen((data) {
      setState(() {
        _throttleText = '$data';
      });
    });
  }

  @override
  void dispose() {
    _easyDebounce.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('easy_debounce_throttle example', style: TextStyle(color: Colors.white, fontSize: 14.0)),
        // title: Text(widget.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              Text(
                'debounce count: $_debounceCount',
                style: const TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              DebounceBuilder(
                  delay: const Duration(milliseconds: 1000),
                  builder: (context, debounce) {
                    return TextButton(
                        onPressed: () => debounce(_increaseDebounceCount),
                        child: const Text(
                          'increase debounce count',
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ));
                  }),
              Text(
                'throttle count: $_throttleCount',
                style: const TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              ThrottleBuilder(
                delay: const Duration(milliseconds: 1000),
                builder: (context, throttle) =>
                    TextButton(
                        onPressed: () => throttle(_increaseThrottleCount),
                        child: const Text(
                          'increase throttle count',
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        )),
              ),
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _textController,
                  keyboardType: TextInputType.name,
                  style: const TextStyle(color: Colors.white, fontSize: 14.0),
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  cursorColor: Colors.blue,
                  decoration: const InputDecoration(
                    counterText: ' ',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1.5,
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                    ),
                    alignLabelWithHint: true,
                    isDense: true,
                  ),
                ),
              ),
              const Text(
                'debounce text',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              Text(
                _debounceText,
                style: const TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              const SizedBox(height: 12.0,),
              const Text(
                'throttle text',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              Text(
                _throttleText,
                style: const TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
