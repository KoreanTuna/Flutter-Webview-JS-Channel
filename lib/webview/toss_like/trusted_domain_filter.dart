class TrustedDomainFilter {
  static final List<String> _trustedDomains = [
    "pay.example.com",
    "secure.payments.com",
  ];

  static bool isTrusted(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    return _trustedDomains.contains(uri.host);
  }
}
