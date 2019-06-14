import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart' as RflutterAlert;
import 'package:flutter_login_page/webview.dart';

const String text =
    '您必须遵守服务中提供的所有政策。\n\n 请勿滥用我们的服务。举例而言，请勿干扰我们的服务或尝试使用除我们提供的界面和指示以外的方法访问这些服务。您仅能在法律（包括适用的出口和再出口管制法律和法规）允许的范围内使用我们的服务。如果您不遵守我们的条款或政策，或者我们在调查可疑的不当行为，我们可以暂停或停止向您提供服务。';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormFieldState<String>> _PasswordFieldKey =
      GlobalKey<FormFieldState<String>>();

  String _username = '';
  String _password = '';
  bool _checkBoxValue = false;

  String _errorUsernameText = '';
  String _errorPasswordText = '';

  //username Controller
  TextEditingController _usernameController = new TextEditingController();
  //password Controller
  TextEditingController _passwordController = new TextEditingController();

  String _validateName(String value) {
    if (value.isEmpty) return 'username is required';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only alphabercal charracters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            print('点击空白处');
          },
          child: ListView(
            padding: EdgeInsets.only(top: 0),
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.blueAccent,
                    Colors.lightBlue,
                  ]),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      //decoration: BoxDecoration(color: Colors.grey),
                      height: 150,
                      child: Container(
                        //decoration: BoxDecoration(color: Colors.white30),
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Text('登录',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                        alignment: AlignmentDirectional.topCenter,
                        child: FractionallySizedBox(
                          child: Text('Tou音,记录别人的美好生活!',
                              style:
                              TextStyle(color: Colors.white, fontSize: 11.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.0),

              //用户名输入框

              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: TextFormField(
                  controller: _usernameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.person),
                      hintText: 'please input username:',
                      labelText: 'username',
                      errorText:
                      _errorUsernameText.isEmpty ? null : _errorUsernameText),
                  onSaved: (String value) {
                    this._username = value;
                    print(value);
                  },
                  validator: _validateName,
                ),
              ),

              SizedBox(height: 24.0),

              //密码输入框

              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: PasswordField(
                  controller: _passwordController,
                  fieldKey: _PasswordFieldKey,
                  helperText: '不超过16个字',
                  hintText: 'please input password:',
                  labelText: 'password',
                  errorText:
                  _errorPasswordText.isEmpty ? null : _errorPasswordText,
                  onFieldSubmitted: (String value) {
                    setState(() {
                      this._password = value;
                    });
                  },
                ),
              ),

              SizedBox(height: 10.0),

              //使用条款与用户协议

              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  children: <Widget>[
                    Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                        value: _checkBoxValue,
                        onChanged: (bool value) {
                          setState(() {
                            _checkBoxValue = value;
                          });
                        },
                      ),
                    ),
                    Row(
                      children: <Widget>[

                        Text(
                          '勾选即代表同意',
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),

                        //使用条款

                        GestureDetector(
                          onTap: () {
                            RflutterAlert.Alert(
                              context: context,
                              title: "Hey App使用条款",
                              desc: text,
                              buttons: [
                                RflutterAlert.DialogButton(
                                  child: Text(
                                    "ok",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  width: 120,
                                )
                              ],
                            ).show();
                          },
                          child: Text(
                            '使用条款',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),

                        Text(
                          '及',
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),

                        //用户协议

                        GestureDetector(
                          onTap: () {
                            RflutterAlert.Alert(
                              context: context,
                              title: "Hey App用户协议",
                              desc: text,
                              buttons: [
                                RflutterAlert.DialogButton(
                                  child: Text(
                                    "ok",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  width: 120,
                                )
                              ],
                            ).show();
                          },
                          child: Text(
                            '用户协议',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),



                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              //登录按钮
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: InkWell(
                  highlightColor: Colors.blue,
                  splashColor: Colors.teal,
                  onTap: () {
                    _validateUsernameAndPassword(context, _usernameController,
                        _passwordController, _checkBoxValue);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: LinearGradient(colors: [
                        Colors.blueAccent,
                        Colors.lightBlue,
                      ]),
                    ),
                    child: Center(
                      child: Text('登录',
                          style: TextStyle(color: Colors.white, fontSize: 15.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    //用户名监听
    _usernameController.addListener(() {
      print(_usernameController.text);

      String username = _usernameController.text;
      if (username.isEmpty) {
        print('isEmpty');
        setState(() {
          _errorUsernameText = '请输入用户名';
        });
      } else {
        setState(() {
          _errorUsernameText = '';
        });
      }
    });

    //密码监听
    _passwordController.addListener(() {
      String password = _passwordController.text;

      if (password.isEmpty) {
        setState(() {
          _errorPasswordText = '请输入密码';
        });
      } else {
        setState(() {
          _errorPasswordText = '';
        });
      }
    });

    super.initState();
  }

  //处理登事件

  _validateUsernameAndPassword(
      BuildContext context,
      TextEditingController usernameController,
      TextEditingController passwordController,
      bool checkBoxValue) {
    //用户名:
    final String _username = usernameController.text;
    final String _password = passwordController.text;
    final bool _isCheck = checkBoxValue;

    if (_username.isEmpty) {
      print('isEmpty');
      setState(() {
        _errorUsernameText = '请输入用户名';
      });
    }
    if (_password.isEmpty) {
      setState(() {
        _errorPasswordText = '请输入密码';
      });
    }

    //都填写
    if (_username.isNotEmpty && _password.isNotEmpty) {
      if (!_isCheck) {
        RflutterAlert.Alert(
          context: context,
          title: "提示",
          desc: '请仔细阅读并勾选使用条款及用户协议',
          buttons: [
            RflutterAlert.DialogButton(
              child: Text(
                "ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      } else {
        //类名冲突,所以加了前缀
        RflutterAlert.Alert(
          context: context,
          title: "登录成功",
          desc:
              'usename:${usernameController.text} \n password:${passwordController.text}\n' +
                  (checkBoxValue ? '已勾选' : '未勾选') +
                  '使用条款及用户协议',
          buttons: [
            RflutterAlert.DialogButton(
              child: Text(
                "ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
    }
  }
}

/*
*
* 判断用户名及密码
*
* */

/*
*
* 密码输入框
*
* */

class PasswordField extends StatefulWidget {
  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final String errorText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController controller;

  const PasswordField(
      {Key key,
      this.errorText,
      this.controller,
      this.fieldKey,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  //显示隐藏密码状态
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      key: widget.fieldKey,
      obscureText: _obscureText,
      maxLength: 16,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        border: UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        errorText: widget.errorText,
        icon: Icon(Icons.lock),
        suffixIcon: GestureDetector(
          //显示/隐藏密码
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}
