import 'dart:async';
import 'package:share/share.dart';
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

  bool _isLoading = true;

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
          IconButton(
            onPressed: () {
              final RenderBox box = context.findRenderObject();
              Share.share(widget.web_url, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
            },
            icon: Icon(Icons.share),
          )
        ],
      ),
      body: Stack(children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WebView(
              initialUrl: widget.web_url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: ((WebViewController webviewController) {
                _completer.complete(webviewController);
              }),
              onPageFinished: (finish) {
                setState(() {
                  _isLoading = false;
                });
              },
            )),
        if (_isLoading) Center(child: CircularProgressIndicator())
      ]),
    );
  }
}
