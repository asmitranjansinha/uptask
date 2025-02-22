// features/auth/data/datasources/auth_remote_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uptask/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> login(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return UserModel(
      id: userCredential.user!.uid,
      email: userCredential.user!.email!,
    );
  }

  Future<UserModel> register(String email, String password, String name) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = UserModel(
      id: userCredential.user!.uid,
      email: userCredential.user!.email!,
      name: name,
    );

    // Create a user document in Firestore
    await _firestore.collection('users').doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return user;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
