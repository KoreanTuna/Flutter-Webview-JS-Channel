import 'package:flutter/material.dart';
import 'package:flutter_webview_js_channel/webview/toss_like/toss_like_webview.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TossLikeWebview());
  }
}
