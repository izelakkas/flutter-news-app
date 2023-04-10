import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('Failed to sign in: $e');
      }
      return false;
    } catch (e) {
      print('Failed to sign in: $e');
      return false;
    }
  }

  Future<bool> signUp({required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Failed to create user: $e');
      }
      return false;
    } catch (e) {
      print('Failed to create user: $e');
      return false;
    }
  }

  // Bu metod eklendi
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Bu getter eklendi
  User? get currentUser => _firebaseAuth.currentUser;
}
