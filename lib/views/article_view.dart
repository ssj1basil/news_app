import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/custom_dialog.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:newsapp/helper/get_summary.dart';
import 'package:progress_dialog/progress_dialog.dart';

class article_view extends StatefulWidget {
  String web_url;

  article_view({this.web_url});

  @override
  _article_viewState createState() => _article_viewState();
}

class _article_viewState extends State<article_view> {
  InAppWebViewController webView;

  AndroidForceDark settings;
  bool _isLoading = true;
  static bool _darktheme = true;
  String summary = '';

  Widget get_webview(AndroidForceDark settings) {
    return (InAppWebView(
        initialUrl: widget.web_url,
        initialHeaders: {},
        initialOptions: InAppWebViewGroupOptions(
            android: AndroidInAppWebViewOptions(
              supportZoom: true,
              forceDark: settings,
            ),
            crossPlatform: InAppWebViewOptions(
              transparentBackground: true,
              debuggingEnabled: true,
            )),
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
        },
        onLoadStop: (InAppWebViewController controller, String url) async {
          setState(() {
            _isLoading = false;
          });
        }));
  }

  void refresh() async {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => article_view(
                  web_url: widget.web_url,
                )));
  }

  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context);
    pr.style(
        padding: EdgeInsets.symmetric(vertical: 12),
        borderRadius: 10,
        progressWidget: Container(padding: EdgeInsets.all(9.0), child: CircularProgressIndicator()),
        message: 'Loading');

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
              icon: (_darktheme ? Icon(FontAwesome5.moon, size: 18) : Icon(Feather.sun, size: 19)),
              onPressed: () {
                setState(() {
                  if (_darktheme == true) {
                    _darktheme = false;
                  } else {
                    _darktheme = true;
                  }
                });
                print(_darktheme);
                refresh();
              }),
          FlatButton(
              onPressed: () async {
                pr.show();
                summary = await get_summary(widget.web_url);
                pr.hide();
                showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomDialog(summary: summary, buttonText: "Okay"),
                );
              },
              child: Text('TL;DR')),
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
            child: _darktheme
                ? get_webview(AndroidForceDark.FORCE_DARK_ON)
                : get_webview(AndroidForceDark.FORCE_DARK_OFF)),
        if (_isLoading) Center(child: CircularProgressIndicator())
      ]),
    );
  }
}
