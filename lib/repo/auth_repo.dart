import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simplechatapp/data/modal/user_data.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register
  Future<UserData?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final UserData userData = UserData(
        name: name,
        uid: userCredential.user!.uid,
        email: email,
        createdOn: DateTime.now().toString(),
        bio: "New to chat app",
        profilePicUrl: "",
      );
      await addUserDataToDataBase(userData);
      log('Sign-up successful and user added to database');
      return userData;
    } catch (e) {
      log('Sign-up failed: ${e.toString()}');
      return null;
    }
  }

  Future<void> addUserDataToDataBase(UserData userData) async {
    try {
      log('Adding user data to database: ${userData.toJson()}');
      await _firestore
          .collection("users")
          .doc(userData.uid)
          .set(userData.toJson());
      log("User added to database successfully");
    } catch (e) {
      log('Error adding user to database: ${e.toString()}');
      rethrow;
    }
  }

  Future<UserData> getCurrentUser(String uid) async {
    try {

      final snapshot =
          await _firestore.collection("users").doc(uid).get();
      if (snapshot.exists) {
        return UserData.fromJson(snapshot.data()!);
      } else {
        throw Exception("User data does not exist");
      }
    } catch (e) {
      log("Error fetching current user: $e");
      return Future.error(e);
    }
  }

  // Login
  Future<UserData> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userDataResponse = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final data = userDataResponse.user;
      final UserData = await getCurrentUser(data!.uid);
      return UserData;
    } catch (e) {
      log('Sign-in failed: ${e.toString()}');
      rethrow;
    }
  }

  // user active or not
  bool isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  // Logout
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log('Sign-out failed: ${e.toString()}');
      rethrow;
    }
  }
}

// Riverpod provider for AuthRepo
final authRepoProvider = Provider<AuthRepo>((ref) => AuthRepo());
