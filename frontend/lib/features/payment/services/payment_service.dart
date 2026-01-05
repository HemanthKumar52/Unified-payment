import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class PaymentService {
  String get baseUrl {
    if (kIsWeb) return 'http://localhost:3000/payments';
    if (defaultTargetPlatform == TargetPlatform.android) return 'http://10.0.2.2:3000/payments';
    return 'http://localhost:3000/payments';
  }

  Future<Map<String, dynamic>> createPayment(double amount, String currency, String country) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'amount': amount,
          'currency': currency,
          'country': country,
          'type': 'one_time'
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create payment: ${response.body}');
      }
    } catch (e) {
      if (kDebugMode) {
         // Mock response for demo
         return {
           'payment_id': 'mock_${DateTime.now().millisecondsSinceEpoch}',
           'methods': [
              {'type': 'card', 'provider': 'stripe', 'name': 'Visa / Mastercard'},
              {'type': 'upi', 'provider': 'razorpay', 'name': 'UPI (PhonePe)'},
              {'type': 'wallet', 'provider': 'unified', 'name': 'Unified Wallet'},
           ]
         };
      }
      throw Exception('Network error: $e');
    }

  }

  Future<String> getPaymentStatus(String paymentId) async {
    final response = await http.get(Uri.parse('$baseUrl/$paymentId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['status'];
    }
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['status'];
    }
    return 'UNKNOWN';
  }

  Future<Map<String, dynamic>> executePayment(String paymentId, dynamic method) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/execute'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'paymentId': paymentId,
          'method': method,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to execute: ${response.body}');
      }
    } catch (e) {
      if (kDebugMode) {
        return {'status': 'MOCK_EXECUTED', 'message': 'Simulated Execution (Backend Unreachable)'};
      }
      rethrow;
    }
  }
}
