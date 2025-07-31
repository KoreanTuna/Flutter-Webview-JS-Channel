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
      <style>
        body {
          font-family: 'Segoe UI', Arial, sans-serif;
          background: #f7f7f9;
          margin: 0;
          padding: 0;
        }
        .container {
          max-width: 400px;
          margin: 40px auto;
          background: #fff;
          border-radius: 16px;
          box-shadow: 0 4px 16px rgba(0,0,0,0.08);
          padding: 32px 24px;
        }
        h1 {
          color: #0064ff;
          margin-bottom: 8px;
        }
        .product {
          display: flex;
          align-items: center;
          margin-bottom: 16px;
        }
        .product-img {
          width: 64px;
          height: 64px;
          border-radius: 8px;
          background: #eee;
          margin-right: 16px;
          display: flex;
          align-items: center;
          justify-content: center;
          font-size: 32px;
        }
        .product-info {
          flex: 1;
        }
        .price {
          font-size: 20px;
          color: #222;
          font-weight: bold;
        }
        label {
          font-weight: 500;
          margin-top: 16px;
          display: block;
        }
        select {
          width: 100%;
          padding: 8px;
          margin-top: 8px;
          border-radius: 6px;
          border: 1px solid #ccc;
        }
        .btn-group {
          display: flex;
          gap: 12px;
          margin-top: 32px;
        }
        button {
          flex: 1;
          padding: 12px 0;
          border: none;
          border-radius: 8px;
          font-size: 18px;
          cursor: pointer;
          transition: background 0.2s;
        }
        .success-btn {
          background: #0064ff;
          color: #fff;
        }
        .success-btn:hover {
          background: #0052cc;
        }
        .fail-btn {
          background: #eee;
          color: #222;
        }
        .fail-btn:hover {
          background: #ddd;
        }
        .desc {
          color: #666;
          font-size: 14px;
          margin-bottom: 24px;
        }
      </style>
      <script>
        function notifySuccess() {
          const method = document.getElementById('payMethod').value;
          window.flutter_inappwebview.callHandler('paymentCallback', JSON.stringify({
            status: 'success',
            message: '결제 성공',
            transactionId: 'abc123',
            method: method
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
      <div class="container">
        <h1>가상 결제창</h1>
        <div class="desc">아래에서 결제 수단을 선택하고 결제 버튼을 눌러주세요.</div>
        <div class="product">
          <div class="product-img">👕</div>
          <div class="product-info">
            <div>상품명: <b>멋진 티셔츠</b></div>
            <div class="price">가격: 3,000원</div>
          </div>
        </div>
        <label for="payMethod">결제 수단 선택:</label>
        <select id="payMethod">
          <option value="card">카드결제</option>
          <option value="transfer">계좌이체</option>
          <option value="mobile">휴대폰결제</option>
        </select>
        <div class="btn-group">
          <button class="success-btn" onclick="notifySuccess()">결제 완료</button>
          <button class="fail-btn" onclick="notifyFail()">결제 실패</button>
        </div>
      </div>
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
              ? '성공(${payload['method']}): ${payload['transactionId']}'
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
