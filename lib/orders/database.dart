import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addOrder(Map<String, dynamic> orderInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Order")
        .doc(id)
        .set(orderInfoMap);
  }

  Future<Stream<QuerySnapshot>> getOrder() async {
    return FirebaseFirestore.instance.collection("Order").snapshots();
  }
}
