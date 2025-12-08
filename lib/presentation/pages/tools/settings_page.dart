// pages/setting_page.dart
import 'package:app_settings/app_settings.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> settings = [
      {'label': 'Accessibility', 'type': AppSettingsType.accessibility},
      {'label': 'Alarm', 'type': AppSettingsType.alarm},
      {'label': 'APN', 'type': AppSettingsType.apn},
      {'label': 'App Locale', 'type': AppSettingsType.appLocale},
      {
        'label': 'Battery Optimization',
        'type': AppSettingsType.batteryOptimization,
      },
      {'label': 'Bluetooth', 'type': AppSettingsType.bluetooth},
      {'label': 'Data Roaming', 'type': AppSettingsType.dataRoaming},
      {'label': 'Date', 'type': AppSettingsType.date},
      {'label': 'Developer', 'type': AppSettingsType.developer},
      {'label': 'Device', 'type': AppSettingsType.device},
      {'label': 'General Settings', 'type': AppSettingsType.generalSettings},
      {'label': 'Display', 'type': AppSettingsType.display},
      {'label': 'Hotspot', 'type': AppSettingsType.hotspot},
      {'label': 'Internal Storage', 'type': AppSettingsType.internalStorage},
      {'label': 'Location', 'type': AppSettingsType.location},
      {'label': 'Lock & Password', 'type': AppSettingsType.lockAndPassword},
      {
        'label': 'Install Unknown Apps',
        'type': AppSettingsType.manageUnknownAppSources,
      },
      {'label': 'NFC', 'type': AppSettingsType.nfc},
      {'label': 'Notification', 'type': AppSettingsType.notification},
      {'label': 'Security', 'type': AppSettingsType.security},
      {'label': 'App Settings', 'type': AppSettingsType.settings},
      {'label': 'Sound', 'type': AppSettingsType.sound},
      {'label': 'Subscriptions (iOS)', 'type': AppSettingsType.subscriptions},
      {'label': 'VPN', 'type': AppSettingsType.vpn},
      {'label': 'WiFi', 'type': AppSettingsType.wifi},
      {'label': 'Wireless', 'type': AppSettingsType.wireless},
      {'label': 'Camera (macOS)', 'type': AppSettingsType.camera},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('App Settings Explorer')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: settings.length,
        separatorBuilder: (_, _) => const Divider(),
        itemBuilder: (context, index) {
          final setting = settings[index];
          return ElevatedButton(
            onPressed: () => AppSettings.openAppSettings(type: setting['type']),
            child: Text('Open ${setting['label']} Settings'),
          );
        },
      ),
    );
  }
}
