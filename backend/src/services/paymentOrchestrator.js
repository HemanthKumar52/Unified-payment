class PaymentOrchestrator {
  static getAvailableMethods(country, amount) {
    const methods = [];
    
    // Always available
    methods.push({ type: 'card', provider: 'stripe', name: 'Credit/Debit Card' });

    if (country === 'IN') {
      methods.push({ type: 'upi', provider: 'razorpay', name: 'UPI' });
    }

    if (country === 'AU') {
      methods.push({ type: 'bnpl', provider: 'afterpay', name: 'Afterpay' });
      methods.push({ type: 'paypal', provider: 'paypal', name: 'PayPal' });
    }

    // Global / Fallback
    if (country !== 'IN' && country !== 'AU') {
       methods.push({ type: 'wallet', provider: 'paypal', name: 'PayPal' });
    }
    
    // Internal Wallet
    methods.push({ type: 'wallet_balance', provider: 'internal', name: 'UnifiedPay Wallet' });

    return methods;
  }
}

module.exports = PaymentOrchestrator;
