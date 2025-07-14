import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@RoutePage()
class BridgingPage extends StatefulWidget {
  const BridgingPage({super.key});

  @override
  State<BridgingPage> createState() => _BridgingPageState();
}

class _BridgingPageState extends State<BridgingPage> {
   // 1. Tentukan nama channel yang unik.
  //    Best practice: gunakan format domain terbalik.
  static const platform = MethodChannel('com.example.flutter_bridge/data');

  // Fungsi untuk mengirim String
  Future<void> _sendString() async {
    try {
      final String testString = "Ini adalah String yang dikirim dari Flutter! 🚀";
      // 2. Panggil method di native dengan nama 'sendString' dan kirim argumennya.
      await platform.invokeMethod('sendString', testString);
      print("Flutter: String sent successfully.");
    } on PlatformException catch (e) {
      print("Flutter: Failed to send string: '${e.message}'.");
    }
  }

  // Fungsi untuk mengirim Object (Map)
  Future<void> _sendObject() async {
    try {
      final Map<String, dynamic> testObject = {
        "id": 123,
        "name": "Project Bridge",
        "isFinished": false,
      };
      // 3. Panggil method 'sendObject'
      await platform.invokeMethod('sendObject', testObject);
      print("Flutter: Object sent successfully.");
    } on PlatformException catch (e) {
      print("Flutter: Failed to send object: '${e.message}'.");
    }
  }

  // Fungsi untuk mengirim Array (List)
  Future<void> _sendArray() async {
    try {
      final List<dynamic> testArray = ["Flutter", "Kotlin", "Swift", 2025];
      // 4. Panggil method 'sendArray'
      await platform.invokeMethod('sendArray', testArray);
      print("Flutter: Array sent successfully.");
    } on PlatformException catch (e) {
      print("Flutter: Failed to send array: '${e.message}'.");
}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter to Native Bridge'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _sendString,
              child: const Text('Kirim String ke Native'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendObject,
              child: const Text('Kirim Object ke Native'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendArray,
              child: const Text('Kirim Array ke Native'),
            ),
          ],
        ),
      ),
    );
  }
}