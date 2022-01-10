import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_cases/services/database.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Database _database = Database();

  Future<void> signup(
      {required String email,
      required String password,
      required String phoneNumber,
      required String name}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _database.addUserToDb(
          email: email,
          uid: userCredential.user!.uid,
          name: name,
          phoneNumber: phoneNumber);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signin({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signout() async {
    await _auth.signOut();
  }
}
