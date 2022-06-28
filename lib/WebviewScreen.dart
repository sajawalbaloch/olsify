import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebviewScreen extends StatefulWidget {


  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  WebViewController? _controller;
  bool _isLoading = true;

  final Completer<WebViewController> _controllerCompleter =
  Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: Center(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              WebView(
                initialUrl: 'http://olsify.com/',
                javascriptMode: JavascriptMode.unrestricted,
                gestureNavigationEnabled: true,
                userAgent:
                'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
                onWebViewCreated: (WebViewController webViewController) {
                  _controllerCompleter.future.then((value) => _controller = value);
                  _controllerCompleter.complete(webViewController);
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                  setState(() {
                    _isLoading = true;
                  });
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
              _isLoading
                  ? Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor)),
              )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _controller!.canGoBack()) {
      _controller!.goBack();
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Do you want to exit'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text('Yes'),
              ),
            ],
          ));
      return Future.value(true);
    }
  }
}
