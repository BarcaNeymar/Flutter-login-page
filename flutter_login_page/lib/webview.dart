import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


const CATCH_URLS = ['m.ctrip.com/','m.ctrip.com/html5/','m.ctrip.com/html5'];


class WebView extends StatefulWidget{

  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  const WebView({Key key, this.url, this.statusBarColor, this.title, this.hideAppBar, this.backForbid = false}) : super(key: key);

  
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView>{

  final webViewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlCHanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;

  int _hideAppBarHeight = 88;

  @override
  void initState() {
  super.initState();
  webViewReference.close();
   _onUrlCHanged = webViewReference.onUrlChanged.listen((String url){

  });

  //判断返回按钮跳转的url
  _isToMain(String url){
    bool contain = false;
    for (final value in CATCH_URLS){
      if(url?.endsWith(value) ?? false){
        contain = true;
      }
    }
    return contain;
  }


  _onStateChanged = webViewReference.onStateChanged.listen((WebViewStateChanged state){
     switch(state.type) {
       case WebViewState.startLoad:
            //返回按钮:如果跳转的是网页(携程首页)则不跳转,需要跳转原生首页
            if(_isToMain(state.url) && !exiting){
              if(widget.backForbid){
                webViewReference.launch(widget.url);
              }else{
                Navigator.pop(context);
                //防止重复返回
                exiting = true;
              }
            }
           break;
          case WebViewState.finishLoad:
            setState(() {
              _hideAppBarHeight = 44;
            });
            break;
          default:
           break;
     }

   });

  
  _onHttpError = webViewReference.onHttpError.listen((WebViewHttpError error){
    print(error);
  });
  }
  
  @override
  void dispose() {

    _onUrlCHanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webViewReference.dispose();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';

    Color backButtonColor;

    if(statusBarColorStr == 'ffffff'){
      backButtonColor = Colors.black;
    }else{
      backButtonColor = Colors.white;
    }

    return Scaffold(
      body: Column(
        children: <Widget>[

          /*自定义appBar*/
          _appBar(Color(int.parse('0xff'+statusBarColorStr)), backButtonColor),

          Expanded(
              child: WebviewScaffold(
                  url: widget.url,
                  withLocalStorage: true,
                  hidden: true,
                  initialChild: Container(
                    color: Colors.white,
                    child: Center(
                      child: Text('Waiting...'),
                    ),
                  ),
          )),
        ],
      ),
    );
  }

  _appBar(Color backgroundColor,Color backButtonColor) {
    //隐藏状态下的appBar
    if(widget.hideAppBar ?? false){
      return Container(
        color: backgroundColor,
        height: _hideAppBarHeight.toDouble(),
      );
    }
    return Container(
      //撑满屏幕宽度
      child: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Stack(
          children: <Widget>[

            GestureDetector(

              onTap: (){
                print('xx');
              },
              
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title ?? '',
                  style: TextStyle(color: backButtonColor,fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}