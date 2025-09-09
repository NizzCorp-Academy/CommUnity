import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_helpboard/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;

class AuthRepositoryImpl extends IAuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //LOG IN
  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw 'Login failed.';
    }
  }

  //SIGN UP
  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final createdUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userId = createdUser.user?.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': email,
        'name': name,
        'joinedCommunities': [],
        'id': userId,
        'postCount': 0,
        'commentCount': 0,
      });
    } catch (e) {
      throw 'Signup failed.';
    }
  }

  //LOG OUT
  @override
  Future<void> logout() async {
    try {
      _firebaseAuth.signOut();
    } catch (e) {
      throw 'Logout failed.';
    }
  }

  //IS LOGGED IN
  @override
  bool isUserLoggedIn() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      return user != null;
    } catch (e) {
      throw "Failed to identify user login status.";
    }
  }
}
