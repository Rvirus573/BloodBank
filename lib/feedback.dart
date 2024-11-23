import 'package:bloodbank/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Feedback extends StatefulWidget {
  const Feedback({super.key});

  @override
  State<Feedback> createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  late final WebViewController webViewController;

  var loadingPercentage = 0;

  String url1 =
      "https://docs.google.com/forms/d/e/1FAIpQLSdO26nsp7eHDFQqyWemd4r1pB65odbITGYwKtLxA34BVii98Q/viewform";
  double progress = 0;

  @override
  void initState() {
   
    super.initState();
    // webViewController.init(context: context,setState: setState ,uri: Uri.https("facebook.com"));
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          url1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: customAppBar(
                context,
                200,
                const Color.fromARGB(144, 4, 112, 45),
         
                'assets/icon/baiust.png',
                "   Feedback",
                ""),
          ),
          Expanded(
            child: WebViewWidget(
              controller: webViewController,
            ),
          )
        ],
      ),
    );
  }
}
