import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

WebViewEnvironment? webViewEnvironment;

abstract class AppBuilder {
  AppBuilder._();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _initWebView();
  }

  Future<void> _initWebView() async {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
      final availableVersion = await WebViewEnvironment.getAvailableVersion();
      assert(
        availableVersion != null,
        'Failed to find an installed WebView2 Runtime or non-stable Microsoft Edge installation.',
      );

      webViewEnvironment = await WebViewEnvironment.create(
        settings: WebViewEnvironmentSettings(userDataFolder: 'webview_data'),
      );
    }

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
    }
  }
}
