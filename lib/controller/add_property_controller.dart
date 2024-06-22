
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPropertyController extends GetxController{

  //String? locationn, area, type, paymentType, amenty, noOfRooms, noOfBaths, price, downPayment, installmentValue, description, pic;
  String? noOfRooms, noOfBaths, area, lotArea, noOfFloors, waterfrontOrNot, viewRate, conditionRate, grade, roofArea, yearbuilt, zipcode, lat, lon, area15, lotArea15, paymentType, downPayment, installmentValue,description, pic, brokerPhone, brokerEmail, price, city;

  List? picList;
  
  // String userPhone = ProfileController().userModel.phone.toString();

  // String userEmail = ProfileController().userModel.email.toString();

  // String userPhone = Get.find<ProfileController>().userModel.phone.toString();
  // String userEmail = Get.find<ProfileController>().userModel.email.toString();
  String userEmail = FirebaseAuth.instance.currentUser!.email.toString();

  var image;

  List<XFile> imageList = [];

  final imagePicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> uploadImage() async{
    File file;

    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    
    imageList.addAll(selectedImages!);
    
    update();
  }

  CollectionReference properties = FirebaseFirestore.instance.collection('Assessor Properties');
  Future<void> addProperty() {
      return properties
          .add({
    'number of rooms': noOfRooms,
    'number of baths': noOfBaths,
    'area': area,
    'lotArea': lotArea,
    'number of floors': noOfFloors,
    'water front': waterfrontOrNot,
    'view rate': viewRate,
    'condition rate': conditionRate,
    'grade': grade,
    'roof area': roofArea,
    'year built': yearbuilt,
    'zipcode': zipcode,
    'lat': lat,
    'lon': lon,
    'area15': area15,
    'lot area 15': lotArea15,
    'payment type':paymentType,
    'down payment':downPayment,
    'installment value': installmentValue,
    'description': description,
    'user email': userEmail,
    'pic': pic,
    'picList': picList,
    'price': price,
    'city': city
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }


//---------------------------------------------------------------------------------------------------------------------------
  // var isLoading = false;

  // var propertyList = <PropertyModel>[];

  // Future<void> getData()async{

  //   try{
  //     QuerySnapshot properties = await FirebaseFirestore.instance.collection('Properties').get();

  //     propertyList.clear();

  //     for(var property in properties.docs){
  //       propertyList.add(PropertyModel(property.id, property['location'], property['area'], property['type'], property['number of rooms'], property['number of baths'], property['amenties'], property['payment type'], property['down payment'], property['installment value']));
  //     }
  //     isLoading = false;

  //   }catch(e){
  //       Get.snackbar('error', '${e.toString()}');
  //   }
  // }

}