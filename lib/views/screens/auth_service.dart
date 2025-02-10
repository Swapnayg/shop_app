import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      CollectionReference dbUsers =
          FirebaseFirestore.instance.collection('users');
      DocumentSnapshot userSnap = await dbUsers.doc(email).get();
      final fCred = await _auth.signInWithEmailAndPassword(
          email: email, password: userSnap['password'].toString().trim());
      await dbUsers
          .doc(email)
          .update({'password': password})
          .then((_) => fCred.user!.updatePassword(password))
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

  Future<String?> signInWithGoogle() async {
    try {
      String result = "";
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        UserCredential userCredential1 =
            await _auth.signInWithPopup(googleProvider);
        CollectionReference dbUsers =
            FirebaseFirestore.instance.collection('users');
        DocumentSnapshot userSnap =
            await dbUsers.doc(userCredential1.user!.email.toString()).get();
        try {
          String uUid = userSnap['password'].toString().trim();
          debugPrint("user already exits");
        } catch (e) {
          dbUsers
              .doc(userCredential1.user!.email.toString())
              .set({
                'full_name': userCredential1.user!.displayName.toString(),
                'username': userCredential1.user!.displayName.toString(),
                'uid': userCredential1.user!.uid.toString(),
                'password': 'N/A',
                'type': 'google',
                'photo_url': userCredential1.user!.photoURL.toString(),
              })
              .then((value) => debugPrint("User Added"))
              .catchError((error) => debugPrint("Failed to add user: $error"));
        }
        SharedPreferences? prefs = await SharedPreferences.getInstance();
        prefs.setString("isLoggedIn", "login");
        prefs.setString("u_email", userCredential1.user!.email.toString());
        return "success";
      } else {
        try {
          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
          final GoogleSignInAuthentication? googleAuth =
              await googleUser?.authentication;
          if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
            final credential = GoogleAuthProvider.credential(
              accessToken: googleAuth?.accessToken,
              idToken: googleAuth?.idToken,
            );
            UserCredential userCredential2 =
                await _auth.signInWithCredential(credential);
            CollectionReference dbUsers1 =
                FirebaseFirestore.instance.collection('users');
            DocumentSnapshot userSnap2 = await dbUsers1
                .doc(userCredential2.user!.email.toString())
                .get();
            try {
              String uUid2 = userSnap2['password'].toString().trim();
              debugPrint("user already exits");
            } catch (e) {
              dbUsers1
                  .doc(userCredential2.user!.email.toString())
                  .set({
                    'full_name': userCredential2.user!.displayName.toString(),
                    'username': userCredential2.user!.displayName.toString(),
                    'uid': userCredential2.user!.uid.toString(),
                    'password': 'N/A',
                    'type': 'google',
                    'photo_url': userCredential2.user!.photoURL.toString(),
                  })
                  .then((value) => debugPrint("User Added"))
                  .catchError(
                      (error) => debugPrint("Failed to add user: $error"));
            }
            SharedPreferences? prefs1 = await SharedPreferences.getInstance();
            prefs1.setString("isLoggedIn", "login");
            prefs1.setString("u_email", userCredential2.user!.email.toString());
            result = "success";
          } else {
            result += "auth error ";
          }
        } catch (e) {
          result += (" $e").toString();
        }
      }
      return result;
      // }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message!); // Displaying the error message
      return e.message!;
    }
  }
}
