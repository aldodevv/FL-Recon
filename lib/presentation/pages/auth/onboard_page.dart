// pages/home_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recon/core/constants/colors_const.dart';
import 'package:recon/presentation/bloc/theme/theme_bloc.dart';
import 'package:recon/presentation/routes/app_router.gr.dart';
import 'package:recon/presentation/widgets/button/mainbutton_widget.dart';

@RoutePage()
class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Onboard")),
      body: BlocSelector<ThemeBloc, ThemeState, ThemeMode>(
        selector: (state) => state.themeMode,
        builder: (context, currentThemeMode) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 10,
                children: [
                  const Text(
                    "➡️ Navigate to Pages",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  MainbuttonWidget(
                    text: "Open Form Page",
                    size: ButtonSize.large,
                    colorType: ColorType.green,
                    onPressed: () {
                      context.router.push(const FormRoute());
                    },
                  ),
                  const SizedBox(height: 12),

                  MainbuttonWidget(
                    text: "Open WebView Page",
                    size: ButtonSize.large,
                    colorType: ColorType.blue,
                    onPressed: () {
                      context.router.push(
                        WebViewRoute(
                          initialUrl: 'https://flutter.dev',
                          key: ValueKey('webview'),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  const Text(
                    "🎨 Button Variations",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  const Text("Fullfilled"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MainbuttonWidget(
                        text: "Small",
                        size: ButtonSize.small,
                        colorType: ColorType.red,
                        onPressed: () {},
                      ),
                      MainbuttonWidget(
                        text: "Medium",
                        size: ButtonSize.medium,
                        colorType: ColorType.orange,
                        onPressed: () {},
                      ),
                      MainbuttonWidget(
                        text: "Large",
                        size: ButtonSize.large,
                        colorType: ColorType.green,
                        onPressed: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Text("Outlined"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MainbuttonWidget(
                        text: "Small",
                        size: ButtonSize.small,
                        type: ButtonType.outlined,
                        colorType: ColorType.blue,
                        onPressed: () {},
                      ),
                      MainbuttonWidget(
                        text: "Medium",
                        size: ButtonSize.medium,
                        type: ButtonType.outlined,
                        colorType: ColorType.green,
                        onPressed: () {},
                      ),
                      MainbuttonWidget(
                        text: "Large",
                        size: ButtonSize.large,
                        type: ButtonType.outlined,
                        colorType: ColorType.orange,
                        onPressed: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Text("Text Buttons"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MainbuttonWidget(
                        text: "Small",
                        size: ButtonSize.small,
                        type: ButtonType.text,
                        colorType: ColorType.red,
                        onPressed: () {},
                      ),
                      MainbuttonWidget(
                        text: "Medium",
                        size: ButtonSize.medium,
                        type: ButtonType.text,
                        colorType: ColorType.blue,
                        onPressed: () {},
                      ),
                      MainbuttonWidget(
                        text: "Large",
                        size: ButtonSize.large,
                        type: ButtonType.text,
                        colorType: ColorType.green,
                        onPressed: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
