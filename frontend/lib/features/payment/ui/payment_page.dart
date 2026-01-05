import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:frontend/features/payment/services/payment_service.dart';

import 'package:flutter_animate/flutter_animate.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final PaymentService _service = PaymentService();
  String? paymentId;
  List<dynamic> paymentMethods = [];
  bool isLoading = false;
  // Country Data Configuration
  final List<Map<String, String>> countries = [
    {'code': 'IN', 'flag': '🇮🇳', 'name': 'India', 'currency': 'INR', 'symbol': '₹'},
    {'code': 'AU', 'flag': '🇦🇺', 'name': 'Australia', 'currency': 'AUD', 'symbol': '\$'},
    {'code': 'US', 'flag': '🇺🇸', 'name': 'USA', 'currency': 'USD', 'symbol': '\$'},
    {'code': 'GB', 'flag': '🇬🇧', 'name': 'UK', 'currency': 'GBP', 'symbol': '£'},
    {'code': 'CA', 'flag': '🇨🇦', 'name': 'Canada', 'currency': 'CAD', 'symbol': '\$'},
    {'code': 'DE', 'flag': '🇩🇪', 'name': 'Germany', 'currency': 'EUR', 'symbol': '€'},
    {'code': 'JP', 'flag': '🇯🇵', 'name': 'Japan', 'currency': 'JPY', 'symbol': '¥'},
  ];

  late Map<String, String> currentCountry;

  @override
  void initState() {
    super.initState();
    currentCountry = countries[0]; // Default to India
  }

  Future<void> _initiatePayment() async {
    setState(() => isLoading = true);
    try {
      final data = await _service.createPayment(499, currentCountry['currency']!, currentCountry['code']!);
      setState(() {
        paymentId = data['payment_id'];
        paymentMethods = data['methods'];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F172A), Color(0xFF1E1B4B)], // Slate to Deep Indigo
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'UnifiedPay',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                ).animate().fadeIn().slideX(),
                const SizedBox(height: 8),
                Text(
                  'Secure Global Payments',
                  style: TextStyle(color: Colors.grey[400]),
                ).animate().fadeIn(delay: 200.ms).slideX(),
                const SizedBox(height: 40),
                
                // Country Selector
                _buildCountrySelector(),
                
                const SizedBox(height: 30),
                
                // Amount Card
                _buildAmountCard(),

                const Spacer(),

                if (paymentMethods.isNotEmpty)
                  Expanded(child: _buildMethodsList())
                else
                  _buildPayButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCountrySelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: countries.map((country) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: _countryChip(country),
          );
        }).toList(),
      ).animate().fadeIn(delay: 300.ms),
    );
  }

  Widget _countryChip(Map<String, String> country) {
    final isSelected = currentCountry['code'] == country['code'];
    return GestureDetector(
      onTap: () => setState(() {
        currentCountry = country;
        paymentMethods = []; // Reset
        paymentId = null;
      }),
      child: AnimatedContainer(
        duration: 300.ms,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6366F1) : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.white24),
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFF6366F1).withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ] : [],
        ),
        child: Text(
          '${country['flag']} ${country['name']}',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildAmountCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B).withOpacity(0.6),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Column(
            children: [
              Text('Total Amount', style: TextStyle(color: Colors.grey[400])),
              const SizedBox(height: 10),
              // Dynamic Currency Display
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                   Text(
                    currentCountry['symbol']!, // Dynamic Symbol
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '499.00',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    currentCountry['currency']!, // Dynamic Code
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().scale(delay: 400.ms, curve: Curves.easeOutBack);
  }


  Widget _buildPayButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : _initiatePayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6366F1),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          shadowColor: const Color(0xFF6366F1).withOpacity(0.5),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Pay Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      ),
    ).animate().slideY(begin: 1.0, end: 0, delay: 500.ms);
  }

  Widget _buildMethodsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Payment Method',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView(
             children: paymentMethods.map((m) => _buildMethodItem(m)).toList(),
          ),
        ),
      ],
    ).animate().fadeIn();
  }

  Widget _buildMethodItem(dynamic method) {
    IconData icon = Icons.credit_card;
    Color iconColor = Colors.blue;
    
    if (method['type'] == 'upi') { icon = Icons.qr_code; iconColor = Colors.orange; }
    if (method['type'] == 'bnpl') { icon = Icons.calendar_month; iconColor = Colors.purple; }
    if (method['type'] == 'wallet') { icon = Icons.account_balance_wallet; iconColor = Colors.green; }
    if (method['provider'] == 'paypal') { icon = Icons.payment; iconColor = Colors.blueAccent; }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(method['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        subtitle: Text(method['provider'].toUpperCase(), style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
        onTap: () async {
           ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Contacting ${method['provider']}...'))
           );
           
           try {
             final result = await _service.executePayment(paymentId!, method);
             
             // In a real app, here we would handle the "action":
             // If action == 'OPEN_SDK', we calls RazorpayFlutter.open(...)
             // If action == 'REDIRECT_URL', we launchUrl(...)
             
             showDialog(
                context: context, 
                builder: (c) => AlertDialog(
                  title: Text('Provider Response'),
                  content: Text(result.toString()), // Show raw response for verification
                  actions: [TextButton(onPressed: () => Navigator.pop(c), child: Text('OK'))],
                )
             );
           } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
           }
        },
      ),
    ).animate().slideX();
  }
}
