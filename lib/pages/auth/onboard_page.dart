// pages/home_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recon/router/app_router.gr.dart';

@RoutePage()
class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Onboard")),
      body:  Center(child: Column(
        children: [
          Text("Welcome to Onboard Screen"),
          FilledButton(onPressed: () {context.router.replace(LoginRoute());}, child: Text("Next"))
        ],
      )),
    );
  }
}