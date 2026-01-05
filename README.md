# UnifiedPay System

A comprehensive multi-country payment system handling Stripe, Razorpay, PayPal, Afterpay, and Internal Wallet transactions. The project consists of a Node.js backend (Express) and a Flutter frontend.

## 🚀 Getting Started

### 1. Backend Setup

Navigate to the backend directory and install dependencies:

```bash
cd backend
npm install
```

#### 🔑 Environment Variables (.env)
Create a `.env` file in the `backend/` directory. You must add the following credentials for the payment providers to work correctly:

```env
# Server Configuration
PORT=3000

# Firebase / Firestore
# Place your serviceAccountKey.json in 'backend/src/config/'
# If missing, the backend uses an in-memory mock database.
GOOGLE_APPLICATION_CREDENTIALS=./src/config/serviceAccountKey.json

# Stripe (Global/US - Credit Cards)
STRIPE_SECRET_KEY=sk_test_...
STRIPE_PUBLISHABLE_KEY=pk_test_...

# Razorpay (India - UPI/Cards)
RAZORPAY_KEY_ID=rzp_test_...
RAZORPAY_KEY_SECRET=...

# PayPal (Global/AU - Wallets)
PAYPAL_CLIENT_ID=...
PAYPAL_CLIENT_SECRET=...
PAYPAL_MODE=sandbox

# Afterpay (Australia - BNPL)
AFTERPAY_MERCHANT_ID=...
```

Start the server:
```bash
npm start
```

### 2. Frontend Setup

Navigate to the frontend directory:

```bash
cd frontend
flutter pub get
flutter run
```

## 🌍 Supported Regions & Methods

| Country | Code | Currency | Methods |
|---------|------|----------|---------|
| India | IN | INR | Razorpay (UPI, Cards), Wallet |
| Australia | AU | AUD | Afterpay, PayPal, Stripe, Wallet |
| USA / Global | US | USD | Stripe, PayPal, Wallet |
| UK | GB | GBP | Stripe, PayPal |
| Europe | DE | EUR | Stripe, PayPal |

## 🛠 Tech Stack
*   **Backend**: Node.js, Express, Firebase Admin (Firestore)
*   **Frontend**: Flutter (Mobile/Web)
*   **Services**: Stripe, Razorpay, PayPal, Afterpay APIs
