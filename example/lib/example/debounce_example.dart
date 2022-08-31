import 'package:easy_debounce_throttle/easy_debounce_throttle/debounce/easy_debounce_builder.dart';
import 'package:easy_debounce_throttle/easy_debounce_throttle/debounce/easy_debounce.dart';
import 'package:easy_debounce_throttle_example/util/text_style.dart';
import 'package:flutter/material.dart';

class DebounceExample extends StatefulWidget {
  const DebounceExample({super.key});

  @override
  State<DebounceExample> createState() => _DebounceExampleState();
}

class _DebounceExampleState extends State<DebounceExample> {
  final EasyDebounce _easyDebounce = EasyDebounce(delay: const Duration(milliseconds: 1000));
  final TextEditingController _textController = TextEditingController();

  int _debounceCount = 0;
  String _debounceText = '';

  void _increaseDebounceCount() async {
    setState(() {
      _debounceCount++;
    });
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      _easyDebounce.debounce(_textController.text);
    });
    _easyDebounce.listen((data) {
      setState(() {
        _debounceText = '$data';
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
        title: Text('EasyDebounce Example', style: kNotoSansBold14.copyWith(color: Colors.white)),
        // title: Text(widget.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8.0),
              Text(
                'debounce count: $_debounceCount',
                style: kNotoSansBold14.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              EasyDebounceBuilder(
                  delay: const Duration(milliseconds: 1000),
                  builder: (context, debounce) {
                    return TextButton(
                        onPressed: () => debounce(_increaseDebounceCount),
                        child: Text(
                          'increase debounce count',
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
                    hintText: 'debounce',
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
                _debounceText,
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
