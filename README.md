
<h1 align="center">Easy Debounce Throttle</h1>

<p align="center">
  <a href="https://flutter.dev">
    <img src="https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter"
      alt="Platform" />
  </a>
  <a href="https://pub.dartlang.org/packages/easy_debounce_throttle">
    <img src="https://img.shields.io/pub/v/easy_debounce_throttle.svg"
      alt="Pub Package" />
  </a>
  <a href="https://github.com/seosh817/easy_debounce_throttle/actions/workflows/main.yml">
    <img src="https://img.shields.io/github/workflow/status/seosh817/easy_debounce_throttle/main_workflow/release/1.0.0?logo=github"
      alt="Build Status" />
  </a>

  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/github/license/seosh817/easy_debounce_throttle"
      alt="License: MIT" />
  </a>
</p><br>

<p align="center">An easy-to-use flutter package that provides debounce and throttle with Stream and WidgetBuilder.</p>


## Usage

If you want to subscribe to debounce, throttle events with Stream, use `EasyDebounce`, `EasyThrottle`

you should call the `close()` method to avoid memory leak


### EasyDebounce

```dart
 final EasyDebounce _easyDebounce = EasyDebounce(delay: const Duration(milliseconds: 1000));
 final TextEditingController _textController = TextEditingController();
 
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
```

### EasyThrottle

```dart
 final EasyThrottle _easyThrottle = EasyThrottle(delay: const Duration(milliseconds: 1000));
 final TextEditingController _textController = TextEditingController();
 
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
```


If you want to receive debounce and throttle events from methods such as `onPressed` callbacks with `WidgetBuilder`, use `EasyDebounceBuilder` and `EasyThrottleBuilder`.

`EasyDebounceBuilder` and `EasyThrottleBuilder` internally disposes the stream, so there is no need to call the `close()` method.

### EasyDebounceBuilder

```dart
EasyDebounceBuilder(
    delay: const Duration(milliseconds: 1000),
    builder: (context, debounce) {
      return TextButton(
          onPressed: () => debounce(() => _increaseDebounceCount()),
       // onPressed: () {
       //   debounce(() {
       //     _increaseDebounceCount();
       //   });
       // },
          child: Text(
            'increase debounce count',
            style: kNotoSansBold14.copyWith(color: Colors.white),
          ));
    }),
```

### EasyThrottleBuilder

```dart
EasyThrottleBuilder(
    delay: const Duration(milliseconds: 1000),
    builder: (context, throttle) {
      return TextButton(
          onPressed: () => throttle(() => _increaseThrottleCount()),
       // onPressed: () {
       //   throttle(() {
       //     _increaseThrottleCount();
       //   });
       // },
          child: Text(
            'increase throttle count',
            style: kNotoSansBold14.copyWith(color: Colors.white),
          ));
    }),
```

## Examples

An example can be found in the example directory of this repository.

A list of detailed examples can be found in this [Examples Repository](https://github.com/seosh817/easy_debounce_throttle/tree/master/example)


|  EasyDebounce |  EasyThrottle |
|---|---|
|<img src="https://github.com/seosh817/easy_debounce_throttle/blob/release/1.0.0/screenshots/easy_debounce.gif?raw=true" width="300">| <img src="https://github.com/seosh817/easy_debounce_throttle/blob/release/1.0.0/screenshots/easy_throttle.gif?raw=true" width="300">|

|  EasyDebounceBuilder |  EasyThrottleBuilder |
|---|---|
|<img src="https://github.com/seosh817/easy_debounce_throttle/blob/release/1.0.0/screenshots/easy_debounce_builder.gif?raw=true" width="300">| <img src="https://github.com/seosh817/easy_debounce_throttle/blob/release/1.0.0/screenshots/easy_throttle_builder.gif?raw=true" width="300">|
## Installing

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  easy_debounce_throttle: ^1.0.0
```

or

```
$ flutter pub add easy_debounce_throttle
```

### 2. Install it

You can install packages from the command line:

```
$ flutter pub get
```

### 3. Import it

Now in your `Dart` code, you can use:

```dart
import 'package:easy_debounce_throttle/easy_debounce_throttle.dart';
```


## License
```
MIT License

Copyright (c) 2022 seosh817

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
