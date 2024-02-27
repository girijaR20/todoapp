import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final _database = FirebaseFirestore.instance;
  Future<QuerySnapshot<Map<String, dynamic>>> searchUsers(String query, String currentUserId) {
    return _database.collection('users')
        .where('email', isGreaterThanOrEqualTo: query)
        .where('email', isLessThan: '$query\uf8ff')
        .get();
  }
}