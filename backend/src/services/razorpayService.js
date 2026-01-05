const Razorpay = require('razorpay');

class RazorpayService {
  constructor() {
    this.key_id = process.env.RAZORPAY_KEY_ID;
    this.key_secret = process.env.RAZORPAY_KEY_SECRET;

    if (this.key_id && this.key_secret) {
        this.instance = new Razorpay({
            key_id: this.key_id,
            key_secret: this.key_secret,
        });
    } else {
        console.warn("Razorpay keys missing (RAZORPAY_KEY_ID, RAZORPAY_KEY_SECRET). Using mock mode.");
        this.instance = null;
    }
  }

  async createOrder(amount, currency = 'INR', receiptId) {
    if (!this.instance) {
        return {
            id: 'order_mock_' + Date.now(),
            entity: 'order',
            amount: amount * 100,
            amount_paid: 0,
            amount_due: amount * 100,
            currency: currency,
            receipt: receiptId,
            status: 'created',
            attempts: 0
        };
    }

    try {
        const options = {
            amount: Math.round(amount * 100), // Razorpay accepts amount in smallest currency unit (paise)
            currency: currency,
            receipt: receiptId,
        };
        const order = await this.instance.orders.create(options);
        return order;
    } catch (error) {
        console.error("Razorpay Create Order Error:", error);
        throw error;
    }
  }
}

module.exports = new RazorpayService();
