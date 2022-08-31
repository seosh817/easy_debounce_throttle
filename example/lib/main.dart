import 'package:easy_debounce_throttle_example/example/debounce_example.dart';
import 'package:easy_debounce_throttle_example/util/text_style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'easy_debounce_throttle example app',
      theme: ThemeData(primaryColor: Colors.blue, brightness: Brightness.dark),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('easy_debounce_throttle example', style: kNotoSansBold16.copyWith(color: Colors.white)),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const DebounceExample()));
                    },
                    child: const ListTile(
                      title: Text('Debeounce Example', style: kNotoSansMedium14, textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
