import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardHandler with WidgetsBindingObserver {
  final void Function(bool visible)? onKeyboardVisibilityChanged;
  final List<FocusNode> _registeredNodes = [];

  KeyboardHandler({this.onKeyboardVisibilityChanged});

  void start() {
    WidgetsBinding.instance.addObserver(this);
    debugPrint("⌨️ KeyboardHandler START");
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    for (final node in _registeredNodes) {
      node.dispose();
    }
    _registeredNodes.clear();
  }

  FocusNode attachFocusNode({
    String? debugLabel,
    void Function()? onEnter,
    void Function()? onEscape,
  }) {
    final node = FocusNode(debugLabel: debugLabel);

    node.onKeyEvent = (FocusNode n, KeyEvent event) {
      if (event is KeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          onEnter?.call();
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.escape) {
          onEscape?.call();
          return KeyEventResult.handled;
        }
      }
      return KeyEventResult.ignored;
    };

    _registeredNodes.add(node);
    return node;
  }

  @override
  void didChangeMetrics() {
    final view = PlatformDispatcher.instance.views.first;
    final bottom = view.viewInsets.bottom;

    final visible = bottom > 0;
    debugPrint("⌨️ Keyboard Visible: $visible (bottom: $bottom)");

    onKeyboardVisibilityChanged?.call(visible);
  }
}
