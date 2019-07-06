import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  final _firestore = Firestore.instance;

  Stream<QuerySnapshot> getChannels() {
    return _firestore.collection('channels').snapshots();
  }

  Stream<QuerySnapshot> getLastArticles({int hours}) {
    return _firestore
        .collection('articles')
        .where('timestamp',
            isGreaterThanOrEqualTo:
                DateTime.now().subtract(Duration(hours: hours)))
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
