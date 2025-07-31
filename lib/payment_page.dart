import 'package:flutter/material.dart';
import 'package:flutter_webview_js_channel/webview/toss_like/toss_like_webview.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('결제 페이지')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('멋진 티셔츠 주문'),
            const SizedBox(height: 8),
            const Text('총 결제 금액: 3000원'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TossLikeWebview()),
                );
              },
              child: const Text('결제하기'),
            ),
          ],
        ),
      ),
    );
  }
}
