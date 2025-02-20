import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constant/app_color.dart';
import 'package:shop_app/views/screens/login_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shop_app/views/screens/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/views/screens/page_switcher.dart';

String error_lbl = "";
String lbl_sucess = "";

String _errorMessage = '';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final _auth = AuthService();

  final _fullname = TextEditingController();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _conf_password = TextEditingController();
  bool _validate_uname = false;
  bool _validate_email = false;
  bool _validate_pass = false;
  bool _validate_confpass = false;
  bool _email_validate = false;
  bool _password_validate = false;
  bool _rc_passVisibility = true;
  bool _r_passVisibility = true;

  @override
  void dispose() {
    super.dispose();
    _fullname.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _conf_password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Sign up',
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
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColor.secondary.withOpacity(0.1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: TextStyle(
                  color: AppColor.secondary.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                ' Sign in',
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
              'Welcome to MyShop  👋',
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
          // Section 2  - Form
          // Full Name
          TextField(
            controller: _fullname,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Full Name',
              prefixIcon: Container(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Profile.svg',
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
          // Username
          TextField(
            controller: _name,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Username',
              labelText: 'Please enter username!',
              errorText: _validate_uname ? 'This field is required!' : null,
              prefixIcon: Container(
                padding: const EdgeInsets.all(12),
                child: const Text('@',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primary)),
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
          // Email
          TextField(
            controller: _email,
            autofocus: false,
            onChanged: (text) {
              _email_validate = EmailValidator.validate(text);
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'youremail@email.com',
              labelText: 'Please enter email address!',
              errorText: _validate_email ? 'This field is required!' : null,
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
            controller: _password,
            autofocus: false,
            obscureText: _r_passVisibility,
            onChanged: (text) {},
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Please enter password!',
              errorText: _validate_pass ? 'This field is required!' : null,
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
              suffixIcon: IconButton(
                icon: _r_passVisibility
                    ? SvgPicture.asset('assets/icons/Hide.svg',
                        color: AppColor.primary)
                    : SvgPicture.asset('assets/icons/Show.svg',
                        color: AppColor.primary),
                onPressed: () {
                  _r_passVisibility = !_r_passVisibility;
                  setState(() {});
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Repeat Password
          TextField(
            controller: _conf_password,
            autofocus: false,
            obscureText: _rc_passVisibility,
            onChanged: (text) {
              if (_conf_password.text.trim() == _password.text.trim()) {
                _password_validate = true;
              } else {
                _password_validate = false;
              }
            },
            decoration: InputDecoration(
              hintText: 'Repeat Password',
              labelText: 'Please confirm your password!',
              errorText: _validate_confpass ? 'This field is required!' : null,
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
                icon: _rc_passVisibility
                    ? SvgPicture.asset('assets/icons/Hide.svg',
                        color: AppColor.primary)
                    : SvgPicture.asset('assets/icons/Show.svg',
                        color: AppColor.primary),
                onPressed: () {
                  _rc_passVisibility = !_rc_passVisibility;
                  setState(() {});
                },
              ),
            ),
          ),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.red,
              ),
              children: <TextSpan>[TextSpan(text: error_lbl)],
            ),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.green,
              ),
              children: <TextSpan>[TextSpan(text: lbl_sucess)],
            ),
          ),
          const SizedBox(height: 24),
          // Sign Up Button
          ElevatedButton(
            onPressed: () {
              setState(() {
                _validate_uname = _name.text.isEmpty;
                _validate_email = _email.text.isEmpty;
                _validate_pass = _password.text.isEmpty;
                _validate_confpass = _conf_password.text.isEmpty;
                if (_name.text.isNotEmpty &&
                    _email.text.isNotEmpty &&
                    _password.text.isNotEmpty &&
                    _conf_password.text.isNotEmpty) {
                  if (_email_validate) {
                    if (_validatePassword(_password.text)) {
                      if (_password_validate) {
                        error_lbl = "";
                        String errorVal = '';
                        _signup().then((value) {
                          errorVal = value;
                        });
                        Timer(const Duration(seconds: 3), () {
                          setState(() {
                            if (errorVal == "fail") {
                              error_lbl = "Email already exits.";
                              lbl_sucess = "";
                            } else if (errorVal == "sucess") {
                              lbl_sucess =
                                  "Please verify your account in order to login.";
                              error_lbl = "";
                            } else {
                              error_lbl = "";
                              lbl_sucess = "";
                            }
                          });
                        });
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const LoginPage()));
                      } else {
                        error_lbl = "Password doesn't match.";
                      }
                    } else {
                      error_lbl = _errorMessage;
                    }
                  } else {
                    error_lbl = "Please enter valid email address.";
                  }
                }
              });
              //TextSpan(style: TextStyle(fontStyle: FontStyle.italic), text: "text")
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
              'Sign up',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontFamily: 'poppins'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'or continue with',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ),
          // SIgn in With Google
          ElevatedButton(
            onPressed: () async {
              await _auth.signInWithGoogle().then((cUser) {
                debugPrint(cUser);
                if (cUser == "success") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PageSwitcher()));
                } else {
                  setState(() {
                    error_lbl = cUser.toString();
                    lbl_sucess = "";
                  });
                }
              });
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColor.primary,
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
              backgroundColor: AppColor.primarySoft,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/Google.svg',
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: const Text(
                    'Sigin with Google',
                    style: TextStyle(
                      color: AppColor.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );

  bool _validatePassword(String password) {
    // Reset error message
    _errorMessage = '';
    // Password length greater than 6
    if (password.length < 6) {
      _errorMessage += '• Password must be longer than 6 characters.\n';
    }
    // Contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      _errorMessage += '• Uppercase letter is missing.\n';
    }
    // Contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      _errorMessage += '• Lowercase letter is missing.\n';
    }
    // Contains at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      _errorMessage += '• Digit is missing.\n';
    }
    // Contains at least one special character
    if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      _errorMessage += '• Special character is missing.\n';
    }
    // If there are no error messages, the password is valid
    return _errorMessage.isEmpty;
  }

  void clearText() {
    _fullname.clear();
    _name.clear();
    _email.clear();
    _password.clear();
    _conf_password.clear();
  }

  Future<String> _signup() async {
    String sendResult = "";
    final user = await _auth.createUserWithEmailAndPassword(
        _email.text.trim(), _password.text.trim());
    if (user != null) {
      CollectionReference dbUsers =
          FirebaseFirestore.instance.collection('users');
      dbUsers
          .doc(_email.text.trim())
          .set({
            'full_name': _fullname.text.trim().toString(),
            'username': _name.text.trim().toString(),
            'uid': user.uid.trim().toString(),
            'password': _password.text.trim().toString(),
            'type': 'email',
            'wallet': "0",
            'photo_url': "",
          })
          .then((value) => debugPrint("User Added"))
          .catchError((error) => debugPrint("Failed to add user: $error"));
      user.sendEmailVerification();
      clearText();
      sendResult = "sucess";
    } else {
      sendResult = "fail";
    }
    return sendResult;
  }
}
