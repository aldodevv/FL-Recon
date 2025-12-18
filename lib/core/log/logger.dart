import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init(
  settings: TalkerSettings(
    enabled: true,
    maxHistoryItems: 1000,
    useHistory: true,
  ),
);