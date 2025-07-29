import 'package:flutter/material.dart';
import 'package:flutter_webview_js_channel/webview/toss_like/secure_webview_wrapper.dart';

class TossLikeWebview extends StatelessWidget {
  const TossLikeWebview({super.key});

  final String _initialHtml = '''
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="UTF-8">
      <title>결제 테스트</title>
      <script>
        function notifySuccess() {
          window.flutter_inappwebview.callHandler('paymentCallback', JSON.stringify({
            status: 'success',
            message: '결제 성공',
            transactionId: 'abc123'
          }));
        }

        function notifyFail() {
          window.flutter_inappwebview.callHandler('paymentCallback', JSON.stringify({
            status: 'fail',
            message: '결제 실패'
          }));
        }
      </script>
    </head>
    <body>
      <h1>가상 결제창</h1>
      <button onclick="notifySuccess()"><h1>결제 성공</h1></button>
      <button onclick="notifyFail()"><h1>결제 실패</h1></button>
    </body>
  </html>
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("결제 테스트")),
      body: SecureWebViewWrapper(
        initialHtml: _initialHtml,
        onResult: (status, payload) {
          final msg = (status == 'success')
              ? '성공: ${payload['transactionId']}'
              : '실패: ${payload['message']}';

          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('결제 결과'),
              content: Text(msg),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('확인'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
