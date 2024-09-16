import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await createUser(user.user!.uid, email);
      return user;
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }

  Future<UserCredential> signUp(String email, String password) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await createUser(user.user!.uid, email);
      return user;
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }

  createUser(String uid, String email) {
    return _firestore
        .collection('Users')
        .doc(uid)
        .set({'uid': uid, 'email': email});
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
