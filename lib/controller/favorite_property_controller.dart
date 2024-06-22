import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/model/favorites_model.dart';
import 'package:firstapp/services/firestore_property.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController{
    String? id, locationn, area, type, paymentType, amenty, noOfRooms, noOfBaths, price, downPayment, installmentValue, description, userEmail, brokerEmail, brokerPhone;
    // String curruserEmail = FirebaseAuth.instance.currentUser!.email.toString();


  ValueNotifier<bool> get loading => _loading;

  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<FavouriteModel> get favoriteModel => _favoriteModel;

  List<FavouriteModel> _favoriteModel = [];

  List<FavouriteModel> userFavoriteList = [];

  getProperties() async{
    _loading.value = true;
    FireStoreProperty().getPropertiess().then((value){
      for(int i = 0; i < value.length; i++){
        _favoriteModel.add(FavouriteModel.fromJson(value[i].data() as Map));
        _loading.value = false;
      }
      for(int i = 0; i< _favoriteModel.length; i++){
        if(favoriteModel[i].userEmail == FirebaseAuth.instance.currentUser!.email){
          userFavoriteList.add(favoriteModel[i]);
        }
      }
      update();
    });
    }

    FavoriteController(){
      getProperties();
    }

  void getSearchList(String loc, String minPrice, String maxPrice){
    List filterList = favoriteModel.where((element) => element.locationn!.contains(loc) || double.parse(element.price.toString()) > double.parse(minPrice) || double.parse(element.price.toString()) < double.parse(maxPrice)).toList();
    
  }
CollectionReference properties = FirebaseFirestore.instance.collection('Favorites');
  Future<void> addFavoriteProperty() {
      return properties
          .add({
            'Location': locationn, 
            'area': area, 
            'type': type ,
            'price': price,
            'number of rooms':noOfRooms,
            'number of baths': noOfBaths,
            'Amenties': amenty,
            'payment type': paymentType,
            'down payment': downPayment,
            'installment value': installmentValue,
            'description': description,
            'user email': userEmail,
            'broker phone': brokerPhone,
            'broker email': brokerEmail
          })
          .then((value) => print("saving Added"))
          .catchError((error) => print("Failed to add saving: $error"));
    }
bool isExist(){
  
  return true;
}
}