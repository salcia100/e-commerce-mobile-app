
/*import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutPage extends StatefulWidget {
  final String paymentUrl; // L'URL de paiement Stripe

  CheckoutPage({required this.paymentUrl});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Initialisation de WebView
    WebView.platform =
        SurfaceAndroidWebView(); // Utiliser SurfaceAndroidWebView pour éviter les erreurs sur Android
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: WebView(
        initialUrl: widget.paymentUrl, // Charge l'URL de paiement Stripe
        javascriptMode:
            JavascriptMode.unrestricted, // Permet l'exécution du JavaScript
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        onPageStarted: (String url) {
          print("Page started loading: $url");
        },
        onPageFinished: (String url) {
          print("Page finished loading: $url");
        },
        onWebResourceError: (WebResourceError error) {
          print("Web resource error: ${error.description}");
        },
      ),
    );
  }
}*/
