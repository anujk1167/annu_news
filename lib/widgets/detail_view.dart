// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class DetailViewScreen extends StatefulWidget {
//   String newsUrl;
//   DetailViewScreen({super.key, required this.newsUrl});
//
//   @override
//   State<DetailViewScreen> createState() => _DetailViewScreenState();
// }
//
// class _DetailViewScreenState extends State<DetailViewScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     setState(() {
//       widget.newsUrl = widget.newsUrl.contains("http:")
//           ? widget.newsUrl.replaceAll("http:", "https:")
//           : widget.newsUrl;
//     });
//   }
//
//   final Completer<WebViewController> controller =
//   Completer<WebViewController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("News Snack")),
//       body: WebView(
//         initialUrl: widget.newsUrl,
//         javascriptMode: JavaScriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           setState(() {
//             controller.complete(webViewController);
//           });
//         },
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailViewScreen extends StatefulWidget {
  final String newsUrl;

  const DetailViewScreen({super.key, required this.newsUrl});

  @override
  State<DetailViewScreen> createState() => _DetailViewScreenState();
}

class _DetailViewScreenState extends State<DetailViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.newsUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Full story ",style: TextStyle(fontSize: 24,fontWeight:FontWeight.bold),)),
      body: WebViewWidget(controller: _controller),
    );
  }
}


// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class DetailViewScreen extends StatefulWidget {
//   String newsUrl;
//   DetailViewScreen({super.key, required this.newsUrl});
//
//   @override
//   State<DetailViewScreen> createState() => _DetailViewScreenState();
// }
//
// class _DetailViewScreenState extends State<DetailViewScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     setState(() {
//       widget.newsUrl = widget.newsUrl.contains("http:")
//           ? widget.newsUrl.replaceAll("http:", "https:")
//           : widget.newsUrl;
//     });
//   }
//
//   final Completer<WebViewController> controller =
//   Completer<WebViewController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("News Snack")),
//       body: WebView(
//         initialUrl: widget.newsUrl,
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           setState(() {
//             controller.complete(webViewController);
//           });
//         },
//       ),
//     );
//   }
// }

