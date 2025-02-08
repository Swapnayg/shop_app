import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return cred.user;
    } catch (e) {
      debugPrint("error");
    }
    return null;
  }

  Future<String> loginUserWithEmailAndPassword(
      String email, String password) async {
    String result = '';
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (cred.user!.emailVerified) {
        SharedPreferences? prefs = await SharedPreferences.getInstance();
        prefs.setString("isLoggedIn", "login");
        prefs.setString("u_email", email.toString());
        result = "sucess";
      } else {
        cred.user!.sendEmailVerification();
        result = "mail";
      }
    } catch (e) {
      result = "not";
    }
    return result;
  }

  Future<String> fi_updatePassword(String email, String password) async {
    String result = '';
    try {
      CollectionReference db_users =
          FirebaseFirestore.instance.collection('users');
      DocumentSnapshot user_snap = await db_users.doc(email).get();
      final f_cred = await _auth.signInWithEmailAndPassword(
          email: email, password: user_snap['password'].toString().trim());
      await db_users
          .doc(email)
          .update({'password': password})
          .then((_) => f_cred.user!.updatePassword(password))
          .catchError((error) => debugPrint('Failed: $error'));
      result = "sucess";
    } catch (e) {
      result = "not";
    }
    return result;
  }

  Future<void> signout() async {
    try {
      SharedPreferences? prefs = await SharedPreferences.getInstance();
      prefs.clear();

      await _auth.signOut();
    } catch (e) {
      log("Session time expired.");
    }
  }
}
