import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreContract{

  final CollectionReference _propertyCollectionRef = FirebaseFirestore.instance.collection('Contracts');

Future<List<QueryDocumentSnapshot>> getPropertiess()async{
  var value = await _propertyCollectionRef.get();
  return value.docs;
}
}