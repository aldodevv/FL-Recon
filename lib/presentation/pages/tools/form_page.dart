import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:recon/core/handler/keyboard_handler.dart';

@RoutePage()
class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late KeyboardHandler _keyboard;

  late FocusNode nameFocus;
  late FocusNode ageFocus;
  late FocusNode emailFocus;

  @override
  void initState() {
    super.initState();

    // INIT KEYBOARD HANDLER
    _keyboard = KeyboardHandler(
      onKeyboardVisibilityChanged: (visible) {
        debugPrint(">>> Keyboard muncul? $visible");
      },
    )..start();

    // REGISTER FOCUS NODES
    nameFocus = _keyboard.attachFocusNode(
      debugLabel: "name",
      onEnter: () => ageFocus.requestFocus(), // auto next
    );

    ageFocus = _keyboard.attachFocusNode(
      debugLabel: "age",
      onEnter: () => emailFocus.requestFocus(),
    );

    emailFocus = _keyboard.attachFocusNode(
      debugLabel: "email",
      onEnter: () {
        debugPrint("Submit form...");
        _submitForm();
      },
    );
  }

  @override
  void dispose() {
    _keyboard.dispose();
    super.dispose();
  }

  void _submitForm() {
    debugPrint("Form submitted!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Demo")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              focusNode: nameFocus,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            TextField(
              focusNode: ageFocus,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Age"),
            ),

            TextField(
              focusNode: emailFocus,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            const SizedBox(height: 24),

            ElevatedButton(onPressed: _submitForm, child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}
