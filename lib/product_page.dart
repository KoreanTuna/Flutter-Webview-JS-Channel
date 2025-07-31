import 'package:flutter/material.dart';
import 'payment_page.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('상품')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('멋진 티셔츠', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            const Text('가격: 3000원'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaymentPage()),
                );
              },
              child: const Text('구매하기'),
            ),
          ],
        ),
      ),
    );
  }
}
