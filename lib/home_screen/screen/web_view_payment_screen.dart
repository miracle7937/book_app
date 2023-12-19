import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SubscriptionPage extends StatefulWidget {
  final String url;

  const SubscriptionPage({super.key, required this.url});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SubscriptionPage> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            if (url.contains("status")) {
              Navigator.pop(context, true);
            }
            print("NAV onPageFinished ${url}");
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            print("NAV URL ${request.url}");
            if (request.url.contains("status")) {
              return NavigationDecision.navigate;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
