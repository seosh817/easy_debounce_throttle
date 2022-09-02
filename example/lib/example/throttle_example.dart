import 'package:easy_debounce_throttle/throttle/easy_throttle.dart';
import 'package:easy_debounce_throttle/throttle/easy_throttle_builder.dart';
import 'package:easy_debounce_throttle_example/util/text_style.dart';
import 'package:flutter/material.dart';

class ThrottleExample extends StatefulWidget {
  const ThrottleExample({Key? key}) : super(key: key);

  @override
  State<ThrottleExample> createState() => _ThrottleExampleState();
}

class _ThrottleExampleState extends State<ThrottleExample> {
  final EasyThrottle _easyThrottle = EasyThrottle(delay: const Duration(milliseconds: 1000));
  final TextEditingController _textController = TextEditingController();

  int _throttleCount = 0;
  String _throttleText = '';

  void _increaseThrottleCount() async {
    setState(() {
      _throttleCount++;
    });
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      _easyThrottle.throttle(_textController.text);
    });
    _easyThrottle.listen((data) {
      setState(() {
        _throttleText = '$data';
      });
    });
  }

  @override
  void dispose() {
    _easyThrottle.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EasyThrottle Example', style: kNotoSansBold14.copyWith(color: Colors.white)),
        // title: Text(widget.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8.0),
              Text(
                'throttle count: $_throttleCount',
                style: kNotoSansBold14.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              EasyThrottleBuilder(
                  delay: const Duration(milliseconds: 1000),
                  builder: (context, debounce) {
                    return TextButton(
                        onPressed: () => debounce(_increaseThrottleCount),
                        child: Text(
                          'increase throttle count',
                          style: kNotoSansBold14.copyWith(color: Colors.white),
                        ));
                  }),
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _textController,
                  keyboardType: TextInputType.name,
                  style: kNotoSansBold14.copyWith(color: Colors.white),
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    hintText: 'throttle',
                    hintStyle: kNotoSansBold14.copyWith(color: Colors.white.withAlpha(120)),
                    counterText: ' ',
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1.5,
                      ),
                    ),
                    border: const UnderlineInputBorder(
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
              Text(
                'text :',
                style: kNotoSansBold14.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                _throttleText,
                style: kNotoSansBold14.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
