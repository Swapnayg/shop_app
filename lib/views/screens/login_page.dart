import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constant/app_color.dart';
import 'package:shop_app/views/screens/forgotpassword.dart';
import 'package:shop_app/views/screens/page_switcher.dart';
import 'package:shop_app/views/screens/register_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shop_app/views/screens/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _l_email = TextEditingController();
  final _l_password = TextEditingController();

  final _auth = AuthService();

  @override
  void dispose() {
    super.dispose();
    _l_email.dispose();
    _l_password.dispose();
  }

  String l_error_lbl = "";
  String l_lbl_sucess = "";

  bool _validate_l_email = false;
  bool _validate_l_pass = false;
  bool _l_email_validate = false;
  bool _passVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Sign in',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600)),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset('assets/icons/Arrow-left.svg'),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const RegisterPage()));
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColor.secondary.withOpacity(0.1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dont have an account?',
                style: TextStyle(
                  color: AppColor.secondary.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                ' Sign up',
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        physics: const BouncingScrollPhysics(),
        children: [
          // Section 1 - Header
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 12),
            child: const Text(
              'Welcome Back Mate ! 😁',
              style: TextStyle(
                color: AppColor.secondary,
                fontWeight: FontWeight.w700,
                fontFamily: 'poppins',
                fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing \nelit, sed do eiusmod ',
              style: TextStyle(
                  color: AppColor.secondary.withOpacity(0.7),
                  fontSize: 12,
                  height: 150 / 100),
            ),
          ),
          // Section 2 - Form
          // Email
          TextField(
            controller: _l_email,
            autofocus: false,
            onChanged: (text) {
              _l_email_validate = EmailValidator.validate(text);
            },
            decoration: InputDecoration(
              hintText: 'youremail@email.com',
              labelText: 'Please enter email address!',
              errorText: _validate_l_email ? 'This field is required!' : null,
              prefixIcon: Container(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Message.svg',
                    color: AppColor.primary),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.border, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.primary, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: AppColor.primarySoft,
              filled: true,
            ),
          ),
          const SizedBox(height: 16),
          // Password
          TextField(
            controller: _l_password,
            autofocus: false,
            obscureText: _passVisibility,
            decoration: InputDecoration(
              hintText: '**********',
              labelText: 'Please enter password!',
              errorText: _validate_l_pass ? 'This field is required!' : null,
              prefixIcon: Container(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Lock.svg',
                    color: AppColor.primary),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.border, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.primary, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: AppColor.primarySoft,
              filled: true,
              //
              suffixIcon: IconButton(
                icon: _passVisibility
                    ? SvgPicture.asset('assets/icons/Hide.svg',
                        color: AppColor.primary)
                    : SvgPicture.asset('assets/icons/Show.svg',
                        color: AppColor.primary),
                onPressed: () {
                  _passVisibility = !_passVisibility;
                  setState(() {});
                },
              ),
            ),
          ),
          // Forgot Passowrd
          Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Forgotpassword()));
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primary.withOpacity(0.1),
              ),
              child: Text(
                'Forgot Password ?',
                style: TextStyle(
                    fontSize: 12,
                    color: AppColor.secondary.withOpacity(0.5),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.red,
              ),
              children: <TextSpan>[TextSpan(text: '$l_error_lbl')],
            ),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.green,
              ),
              children: <TextSpan>[TextSpan(text: '$l_lbl_sucess')],
            ),
          ),
          // Sign In button
          ElevatedButton(
            onPressed: () {
              setState(() {
                _validate_l_email = _l_email.text.isEmpty;
                _validate_l_pass = _l_password.text.isEmpty;
                if (_l_email.text.isNotEmpty && _l_password.text.isNotEmpty) {
                  if (_l_email_validate) {
                    l_error_lbl = "";
                    String error_l_val = '';
                    _login().then((value) {
                      error_l_val = value;
                      Timer(const Duration(seconds: 1), () {
                        setState(() {
                          if (error_l_val == "mail") {
                            l_error_lbl = "Please verify your account.";
                            l_lbl_sucess = "";
                          } else if (error_l_val == "sucess") {
                            l_lbl_sucess = "Account verified.";
                            l_error_lbl = "";
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const PageSwitcher()));
                          } else if (error_l_val == "not") {
                            l_error_lbl = "User not found.";
                            l_lbl_sucess = "";
                          } else {
                            l_error_lbl = "";
                            l_lbl_sucess = "";
                          }
                        });
                      });
                    });
                  } else {
                    l_lbl_sucess = "";
                    l_error_lbl = "Please enter valid email address.";
                  }
                }
              });
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
              backgroundColor: AppColor.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: const Text(
              'Sign in',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontFamily: 'poppins'),
            ),
          ),
        ],
      ),
    );
  }

  void clearText() {
    _l_email.clear();
    _l_password.clear();
  }

  Future<String> _login() async {
    final result = await _auth.loginUserWithEmailAndPassword(
        _l_email.text.trim(), _l_password.text.trim());
    clearText();
    return result;
  }
}
