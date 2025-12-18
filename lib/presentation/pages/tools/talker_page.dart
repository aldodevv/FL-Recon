import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:recon/core/log/logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

@RoutePage()
class TalkerPage extends StatelessWidget {
  const TalkerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TalkerScreen(
      talker: talker,
      appBarTitle: '🪵 App Logs',
    );
  }
}