class StripeService {
  constructor() {
    // this.stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
  }

  /* 
   * Create a Subscription
   * Flow:
   * 1. Create Customer (if not exists)
   * 2. Create Subscription
   * 3. Return Client Secret (for frontend PaymentSheet) or Subscription status
   */
  async createSubscription(email, priceId) {
    // const customer = await this.stripe.customers.create({ email });
    // const subscription = await this.stripe.subscriptions.create({
    //   customer: customer.id,
    //   items: [{ price: priceId }],
    //   payment_behavior: 'default_incomplete',
    //   expand: ['latest_invoice.payment_intent'],
    // });
    // return subscription;
    return { id: 'sub_mock_123', status: 'active', clientSecret: 'mock_secret' };
  }

  async createPaymentIntent(amount, currency) {
      // const paymentIntent = await this.stripe.paymentIntents.create({
      //   amount: amount * 100,
      //   currency: currency,
      // });
      // return paymentIntent;
      
      return {
          id: 'pi_mock_' + Date.now(),
          client_secret: 'pi_mock_secret_' + Date.now(),
          amount: amount,
          currency: currency,
          status: 'requires_payment_method'
      };
  }
}

module.exports = new StripeService();
