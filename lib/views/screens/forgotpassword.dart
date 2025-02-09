import 'dart:async';
import 'package:shop_app/views/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constant/app_color.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shop_app/views/screens/auth_service.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  _ForgotpasswordState createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final _f_email = TextEditingController();
  final _f_password = TextEditingController();
  final _conf_f_password = TextEditingController();
  final _auth = AuthService();

  @override
  void dispose() {
    super.dispose();
    _f_email.dispose();
    _f_password.dispose();
    _conf_f_password.dispose();
  }

  String f_error_lbl = "";
  String f_lbl_sucess = "";

  String _f_errorMessage = '';

  bool _validate_f_email = false;
  bool _validate_f_pass = false;
  bool _f_email_validate = false;
  bool _password_f_validate = false;
  final bool _validate_f_confpass = false;

  bool _fc_passVisibility = true;
  bool _f_passVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Forgot Password',
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
                'Want to Login?',
                style: TextStyle(
                  color: AppColor.secondary.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                ' Login',
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
              'Welcome Back Mate ! 😔',
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
            controller: _f_email,
            autofocus: false,
            onChanged: (text) {
              _f_email_validate = EmailValidator.validate(text);
            },
            decoration: InputDecoration(
              hintText: 'youremail@email.com',
              labelText: 'Please enter email address!',
              errorText: _validate_f_email ? 'This field is required!' : null,
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
            controller: _f_password,
            autofocus: false,
            obscureText: _f_passVisibility,
            decoration: InputDecoration(
              hintText: '**********',
              labelText: 'Please enter password!',
              errorText: _validate_f_pass ? 'This field is required!' : null,
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
                icon: _f_passVisibility
                    ? SvgPicture.asset('assets/icons/Hide.svg',
                        color: AppColor.primary)
                    : SvgPicture.asset('assets/icons/Show.svg',
                        color: AppColor.primary),
                onPressed: () {
                  _f_passVisibility = !_f_passVisibility;
                  setState(() {});
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _conf_f_password,
            autofocus: false,
            obscureText: _fc_passVisibility,
            onChanged: (text) {
              if (_conf_f_password.text.trim() == _f_password.text.trim()) {
                _password_f_validate = true;
              } else {
                _password_f_validate = false;
              }
            },
            decoration: InputDecoration(
              hintText: 'Repeat Password',
              labelText: 'Please confirm your password!',
              errorText:
                  _validate_f_confpass ? 'This field is required!' : null,
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
                icon: _fc_passVisibility
                    ? SvgPicture.asset('assets/icons/Hide.svg',
                        color: AppColor.primary)
                    : SvgPicture.asset('assets/icons/Show.svg',
                        color: AppColor.primary),
                onPressed: () {
                  _fc_passVisibility = !_fc_passVisibility;
                  setState(() {});
                },
              ),
            ),
          ),
          const SizedBox(height: 6),
          // Forgot Passowrd
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.red,
              ),
              children: <TextSpan>[TextSpan(text: f_error_lbl)],
            ),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.green,
              ),
              children: <TextSpan>[TextSpan(text: f_lbl_sucess)],
            ),
          ),
          // Sign In button
          ElevatedButton(
            onPressed: () {
              setState(() {
                _validate_f_email = _f_email.text.isEmpty;
                _validate_f_pass = _f_password.text.isEmpty;
                if (_f_email.text.isNotEmpty && _f_password.text.isNotEmpty) {
                  if (_f_email_validate) {
                    if (_validatePassword(_f_password.text)) {
                      if (_password_f_validate) {
                        f_error_lbl = "";
                        String errorFVal = '';
                        _updatepass().then((value) {
                          errorFVal = value;
                          Timer(const Duration(seconds: 1), () {
                            setState(() {
                              if (errorFVal == "sucess") {
                                f_lbl_sucess = "Password Changed.";
                                f_error_lbl = "";
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                              } else if (errorFVal == "not") {
                                f_error_lbl = "User not found.";
                                f_lbl_sucess = "";
                              } else {
                                f_error_lbl = "";
                                f_lbl_sucess = "";
                              }
                            });
                          });
                        });
                      } else {
                        f_error_lbl = "Password doesn't match.";
                      }
                    } else {
                      f_error_lbl = _f_errorMessage;
                    }
                  } else {
                    f_lbl_sucess = "";
                    f_error_lbl = "Please enter valid email address.";
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
              'Update Password',
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
    _f_email.clear();
    _f_password.clear();
    _conf_f_password.clear();
  }

  Future<String> _updatepass() async {
    final result = await _auth.fi_updatePassword(
        _f_email.text.trim(), _f_password.text.trim());
    clearText();
    return result;
  }

  bool _validatePassword(String password) {
    // Reset error message
    _f_errorMessage = '';
    // Password length greater than 6
    if (password.length < 6) {
      _f_errorMessage += '• Password must be longer than 6 characters.\n';
    }
    // Contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      _f_errorMessage += '• Uppercase letter is missing.\n';
    }
    // Contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      _f_errorMessage += '• Lowercase letter is missing.\n';
    }
    // Contains at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      _f_errorMessage += '• Digit is missing.\n';
    }
    // Contains at least one special character
    if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      _f_errorMessage += '• Special character is missing.\n';
    }
    // If there are no error messages, the password is valid
    return _f_errorMessage.isEmpty;
  }
}
