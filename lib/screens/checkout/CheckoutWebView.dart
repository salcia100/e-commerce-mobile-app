import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/constant/constant.dart';
import 'package:inscri_ecommerce/screens/checkout/checkout_accepted.dart';
import 'package:inscri_ecommerce/utils/secure_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class CheckoutWebView extends StatefulWidget {
  final String paymentUrl;

  CheckoutWebView({required this.paymentUrl});

  @override
  _CheckoutWebViewState createState() => _CheckoutWebViewState();
}

class _CheckoutWebViewState extends State<CheckoutWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            final url = request.url;
            print("Navigating to: $url");

            if (url.contains('payment-success')) {
              final uri = Uri.parse(url);
              final orderId = uri.queryParameters['order_id'];

              if (orderId != null) {
                _confirmPayment(orderId);
              } else {
                Navigator.pop(context);
                _showDialog("Success", "Payment completed!");
              }

              return NavigationDecision.prevent;
            } else if (url.contains('checkout-failed')) {
              Navigator.pop(context);
              _showDialog("Payment Failed", "Please try again.");
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  Future<void> _confirmPayment(String orderId) async {
    try {
      String? token = await SecureStorage.getToken(); // Get saved token

      final response = await http.get(
        Uri.parse(
            apiUrl+'/payment-success?order_id=$orderId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print("Response code: ${response.statusCode}");
      print("Response body: ${response.body}");

      Navigator.pop(context);

      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutAccepted(),
            ));
        //_showDialog("Payment Confirmed", "Thank you for your order!");
      } else {
        _showDialog("Error", "Payment was made but not confirmed.");
      }
    } catch (e) {
      Navigator.pop(context);
      _showDialog("Network Error", "Could not confirm payment.");
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
