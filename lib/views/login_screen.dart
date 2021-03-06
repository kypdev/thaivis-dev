import 'package:flutter/material.dart';
import 'package:thaivis_dev/common/cus_btn.dart';
import 'package:thaivis_dev/common/cus_tf.dart';
import 'package:thaivis_dev/services/auth.dart';

final Color scaffColor = Color(0xfff0f4f8);

final Auth _auth = new Auth();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  logo(),
                  LoginForm(),
                ],
              ),
            ),
          )),
    );
  }
}

Widget logo() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 60.0),
    child: Image.asset(
      'assets/images/logo.png',
      width: 160.0,
    ),
  );
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();

  String emailVal(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) && value.length < 5) {
      return 'อีเมลล์ไม่ถูกต้อง';
    } else {
      return null;
    }
  }

  int loginType = 1;

  login() {
    debugPrint('login');
  }

  register() {
    debugPrint('$loginType');
    _auth.userRegister(context, loginType);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          customTextField(
            controller: emailCtrl,
            prefixIcon: Icon(Icons.email),
            label: 'อีเมล',
            val: emailVal,
          ),
          SizedBox(height: 10),
          customTextField(
            controller: passwordCtrl,
            prefixIcon: Icon(Icons.lock),
            label: 'รหัสผ่าน',
            val: emailVal,
          ),
          SizedBox(height: 35),
          cusBtn(
            action: () => login(),
            text: 'เข้าใช้งาน',
            color: Color(0xff1367b8),
          ),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: loginType,
                onChanged: (value) {
                  setState(() {
                    loginType = value;
                  });
                },
                activeColor: Colors.blue,
              ),
              Text(
                'วิสาหากิจชุมชน',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(width: 16),
              Radio(
                value: 2,
                groupValue: loginType,
                onChanged: (value) {
                  setState(() {
                    loginType = value;
                  });
                },
                activeColor: Colors.blue,
              ),
              Text(
                'บุคคลทั่วไป',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: register,
            child: Text(
              'ลงทะเบียนผู้ใช้งานใหม่',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
