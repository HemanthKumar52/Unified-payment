import 'package:flutter/material.dart';
import 'package:frontend/core/theme.dart';
import 'package:frontend/features/payment/ui/payment_page.dart';

void main() {
  runApp(const UnifiedPayApp());
}

class UnifiedPayApp extends StatelessWidget {
  const UnifiedPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UnifiedPay',
      theme: AppTheme.darkTheme,
      home: const PaymentPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
