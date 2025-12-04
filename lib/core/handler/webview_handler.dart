import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewHandler {
  late final WebViewController controller;

  /// Progress 0–100
  final ValueNotifier<int> progress = ValueNotifier<int>(0);

  /// True kalau lagi loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  /// URL yang sedang dibuka
  final ValueNotifier<String?> currentUrl = ValueNotifier<String?>(null);

  /// Title halaman (kalau ada)
  final ValueNotifier<String?> pageTitle = ValueNotifier<String?>(null);

  /// Error terakhir (kalau ada)
  final ValueNotifier<WebResourceError?> lastError =
      ValueNotifier<WebResourceError?>(null);

  /// Stream JS message dari Web → App
  final StreamController<JavaScriptMessage> _jsMessagesController =
      StreamController<JavaScriptMessage>.broadcast();

  Stream<JavaScriptMessage> get jsMessages => _jsMessagesController.stream;

  final WebViewCookieManager _cookieManager = WebViewCookieManager();

  WebViewHandler({
    String? initialUrl,
    JavaScriptMode javaScriptMode = JavaScriptMode.unrestricted,
    NavigationDecision Function(NavigationRequest request)? onNavigationRequest,
    void Function(JavaScriptMessage message)? onJsMessage,
  }) {
    controller =
        WebViewController()
          ..setJavaScriptMode(javaScriptMode)
          ..setBackgroundColor(Colors.transparent)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (value) {
                progress.value = value;
              },
              onPageStarted: (url) {
                isLoading.value = true;
                currentUrl.value = url;
                debugPrint('🌐 [WebView] onPageStarted: $url');
              },
              onPageFinished: (url) async {
                isLoading.value = false;
                currentUrl.value = url;
                pageTitle.value = await controller.getTitle();
                debugPrint('✅ [WebView] onPageFinished: $url');
              },
              onWebResourceError: (error) {
                lastError.value = error;
                debugPrint(
                  '❌ [WebView] Error: ${error.errorType} - ${error.description}',
                );
              },
              onNavigationRequest: (request) {
                debugPrint('➡️ [WebView] NavigationRequest: ${request.url}');

                if (onNavigationRequest != null) {
                  return onNavigationRequest(request);
                }

                // default: izinkan semua
                return NavigationDecision.navigate;
              },
            ),
          )
          ..addJavaScriptChannel(
            'AppBridge',
            onMessageReceived: (message) {
              debugPrint('📩 [WebView] JS Message: ${message.message}');
              _jsMessagesController.add(message);
              if (onJsMessage != null) {
                onJsMessage(message);
              }
            },
          );

    // Kalau langsung mau load URL awal
    if (initialUrl != null) {
      loadUrl(initialUrl);
    }
  }

  /// Load URL biasa
  Future<void> loadUrl(String url, {Map<String, String>? headers}) async {
    debugPrint('🌐 [WebView] loadUrl: $url');
    await controller.loadRequest(Uri.parse(url));
  }

  /// Reload halaman saat ini
  Future<void> reload() async {
    debugPrint('🔄 [WebView] reload');
    await controller.reload();
  }

  /// Back kalau bisa
  Future<void> goBack() async {
    if (await controller.canGoBack()) {
      await controller.goBack();
    }
  }

  /// Forward kalau bisa
  Future<void> goForward() async {
    if (await controller.canGoForward()) {
      await controller.goForward();
    }
  }

  /// Execute JavaScript di dalam WebView
  Future<String?> evalJs(String script) async {
    debugPrint('🧪 [WebView] evalJs: $script');
    final result = await controller.runJavaScriptReturningResult(script);
    return result.toString();
  }

  /// Fire event ke JS (misal kirim token / theme / action)
  Future<void> postMessageToJs(String channelFunc, dynamic data) async {
    // Contoh: window.AppChannel.receive(JSON.stringify(data))
    final safeData = data is String ? data : data.toString();
    final script = "$channelFunc('$safeData')";
    await controller.runJavaScript(script);
  }

  /// Set cookie
  Future<void> setCookie({
    required String url,
    required String name,
    required String value,
    String path = '/',
    required DateTime expires,
    bool isSecure = true,
    bool isHttpOnly = true,
  }) async {
    await _cookieManager.setCookie(
      WebViewCookie(
        name: name,
        value: value,
        domain: Uri.parse(url).host,
        path: path,
      ),
    );
    debugPrint('🍪 [WebView] Set cookie $name for $url');
  }

  /// Clear semua cookie WebView
  Future<void> clearCookies() async {
    await _cookieManager.clearCookies();
    debugPrint('🧹 [WebView] Clear cookies');
  }

  void dispose() {
    _jsMessagesController.close();
    progress.dispose();
    isLoading.dispose();
    currentUrl.dispose();
    pageTitle.dispose();
    lastError.dispose();
  }
}
