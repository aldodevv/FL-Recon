import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recon/core/handler/webview_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class WebViewPage extends StatefulWidget {
  final String initialUrl;
  const WebViewPage({super.key, required this.initialUrl});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewHandler _webViewHandler = WebViewHandler();

  @override
  void initState() {
    super.initState();
    _webViewHandler.loadUrl(widget.initialUrl);
    _webViewHandler.jsMessages.listen((msg) {
      debugPrint('📩 [Page] JS message: ${msg.message}');
      // lo bisa parse JSON, trigger bloc, dsb
    });
  }

  @override
  void dispose() {
    _webViewHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<String?>(
          valueListenable: _webViewHandler.pageTitle,
          builder: (_, title, _) => Text(title ?? 'WebView'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _webViewHandler.reload,
          ),
        ],
      ),
      body: Column(
        children: [
          ValueListenableBuilder<int>(
            valueListenable: _webViewHandler.progress,
            builder: (_, value, _) {
              if (value == 100) return const SizedBox.shrink();
              return LinearProgressIndicator(value: value / 100);
            },
          ),
          Expanded(
            child: WebViewWidget(controller: _webViewHandler.controller),
          ),
        ],
      ),
    );
  }
}
