import 'package:razorpay_flutter/razorpay_flutter.dart';


class PaymentService {
  late Razorpay _razorpay;

  PaymentService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout(double amount, String name, String email, String contact) {
    var options = {
      'key': 'rzp_test_yourKeyHere',  // 🔹 Replace with your Razorpay Key
      'amount': (amount * 100).toInt(), // Convert amount to paise
      'name': 'NexaMart',
      'description': 'Payment for your order',
      'prefill': {
        'contact': contact,  
        'email': email,  
      },
      'theme': {
        'color': '#F37254'
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("✅ Payment Successful: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("❌ Payment Failed: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("💳 External Wallet Selected: ${response.walletName}");
  }

  void dispose() {
    _razorpay.clear();
  }
}
