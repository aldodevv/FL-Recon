import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:base32/base32.dart';
import 'package:convert/convert.dart';
import 'package:flutter/services.dart';

@RoutePage()
class Base32Page extends StatelessWidget {
  const Base32Page({super.key});

  @override
  Widget build(BuildContext context) {
    final byteList = [72, 101, 108, 108, 111, 33, 222, 173, 190, 239];
    final hexString = '48656c6c6f21deadbeef';
    final plainString = 'foobar';

    final encodedFromBytes = base32.encode(Uint8List.fromList(byteList));
    final encodedFromHex = base32.encodeHexString(hexString);
    final encodedFromString = base32.encodeString(plainString);

    final decodedBytes = base32.decode("JBSWY3DPEHPK3PXP");
    final decodedHex = hex.encode(decodedBytes);
    final decodedHexString = base32.decodeAsHexString("JBSWY3DPEHPK3PXP");
    final decodedString = base32.decodeAsString("MZXW6YTBOI======");

    return Scaffold(
      appBar: AppBar(title: const Text('Base32 Examples')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Encode Examples', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('base32.encode(byteList):\n$encodedFromBytes'),
          Text('base32.encodeHexString(hex):\n$encodedFromHex'),
          Text('base32.encodeString(plain):\n$encodedFromString'),
          const Divider(),
          const Text('Decode Examples', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('base32.decode("JBSWY3DPEHPK3PXP") -> hex:\n$decodedHex'),
          Text('base32.decodeAsHexString("JBSWY3DPEHPK3PXP"):\n$decodedHexString'),
          Text('base32.decodeAsString("MZXW6YTBOI======"):\n$decodedString'),
        ],
      ),
    );
  }
}
