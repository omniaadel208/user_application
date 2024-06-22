import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreFavorite{

  final CollectionReference _propertyCollectionRef = FirebaseFirestore.instance.collection('Favorites');

Future<List<QueryDocumentSnapshot>> getPropertiess()async{
  var value = await _propertyCollectionRef.get();
  return value.docs;
}
}