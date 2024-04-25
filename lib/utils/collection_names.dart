import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CollectionsNames {
  static final firestoreCollection = FirebaseFirestore.instance;
  static final firebaseAuth = FirebaseAuth.instance;
  static String usersCollection = 'users';
  static String driverCollection = 'drivers';
  static String patientCollection = 'patients';
  static String hospitalCollection = 'hospitals';
  static String doctorCollection = 'doctors';
  static String usedID = 'usedId';
  static String requestCollection = 'usedId';
}
