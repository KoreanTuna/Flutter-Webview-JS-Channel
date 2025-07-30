import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'payment_session_manager.dart';
import 'trusted_domain_filter.dart';

class SecureWebViewWrapper extends StatefulWidget {
  final String? paymentUrl;
  final String? initialHtml;
  final void Function(String status, Map<String, dynamic> data) onResult;

  const SecureWebViewWrapper({
    super.key,
    this.paymentUrl,
    this.initialHtml,
    required this.onResult,
  }) : assert(
         paymentUrl != null || initialHtml != null,
         'Either paymentUrl or initialHtml must be provided',
       );

  @override
  State<SecureWebViewWrapper> createState() => _SecureWebViewWrapperState();
}

class _SecureWebViewWrapperState extends State<SecureWebViewWrapper> {
  late InAppWebViewController _controller;
  final _sessionManager = PaymentSessionManager();

  @override
  void initState() {
    super.initState();
    if (widget.paymentUrl != null) {
      _sessionManager.syncCookiesAndHeaders(widget.paymentUrl!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: widget.paymentUrl != null
          ? URLRequest(
              url: WebUri(widget.paymentUrl!),
              headers: _sessionManager.getAuthHeaders(),
            )
          : null,
      initialData: widget.initialHtml != null
          ? InAppWebViewInitialData(data: widget.initialHtml!)
          : null,
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        useShouldOverrideUrlLoading: true,
      ),
      onWebViewCreated: (controller) {
        _controller = controller;

        controller.addJavaScriptHandler(
          handlerName: 'paymentCallback',
          callback: (args) {
            final Map<String, dynamic> payload = jsonDecode(args[0]);
            final status = payload['status'] ?? 'unknown';
            widget.onResult(status, payload);
            return {'ack': true};
          },
        );
      },
      onReceivedHttpError:
          (
            InAppWebViewController controller,
            WebResourceRequest request,
            WebResourceResponse errorResponse,
          ) {
            debugPrint(
              "HTTP Error: ${errorResponse.statusCode} for ${request.url}",
            );
          },
      shouldOverrideUrlLoading: (controller, action) async {
        if (widget.initialHtml != null) {
          return NavigationActionPolicy.ALLOW;
        }

        final url = action.request.url.toString();
        if (!TrustedDomainFilter.isTrusted(url)) {
          debugPrint("⚠️ 차단된 URL: $url");
          return NavigationActionPolicy.CANCEL;
        }
        return NavigationActionPolicy.ALLOW;
      },
    );
  }
}
