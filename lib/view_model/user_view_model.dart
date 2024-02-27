import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/model/user_respository.dart';



class UserViewModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final _userRepository = UserRepository();

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,

      );
      notifyListeners();
      return userCredential.user;
    } catch (e) {
      print('Failed to sign in: $e');
      notifyListeners();
      return null;
    }

  }

  Future<User?> register(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      if (userCredential.user != null) {
        Map<String, dynamic> user = {
          "uid": userCredential.user?.uid,
          "email": userCredential.user?.email,
        };
        _db.collection("users").add(user);
        return userCredential.user;
      }

    } catch (e) {
      print('Failed to register: $e');
      notifyListeners();
      return null;
    }
  }

  Future<Stream<User?>> onAuthStateChanged() async {
    return _auth.authStateChanges();
  }

  void logout() async {
    await _auth.signOut();
    notifyListeners();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> searchUser(String query, String currentUserId) {
    return _userRepository.searchUsers(query, currentUserId);
  }

  User? get currentUser {
    return _auth.currentUser;
  }

  String? get currentUserId {
    return _auth.currentUser?.uid;
  }
}