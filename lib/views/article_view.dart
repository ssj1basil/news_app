import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class article_view extends StatefulWidget {
  String web_url;

  article_view({this.web_url});

  @override
  _article_viewState createState() => _article_viewState();
}

class _article_viewState extends State<article_view> {
  final Completer<WebViewController> _completer = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Flutter'),
            Text(
              'News',
              style: TextStyle(
                color: Colors.blue,
              ),
            )
          ],
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.share),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: WebView(
        initialUrl: widget.web_url,
        onWebViewCreated: ((WebViewController webviewController) {
          _completer.complete(webviewController);
        }),
      )),
    );
  }
}
