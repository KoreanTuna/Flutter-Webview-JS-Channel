import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymentSessionManager {
  final String token = "Bearer your-access-token"; // 실제로는 DI로 주입

  /// 인증 헤더 반환
  Map<String, String> getAuthHeaders() {
    return {"Authorization": token, "X-App-Version": "1.0.0"};
  }

  /// 쿠키 세션 동기화
  Future<void> syncCookiesAndHeaders(String url) async {
    await CookieManager.instance().setCookie(
      url: WebUri(url),
      name: "session_id",
      value: "abc123", // 서버에서 받은 세션 쿠키
      domain: Uri.parse(url).host,
      isSecure: true,
      isHttpOnly: true,
    );
  }
}
