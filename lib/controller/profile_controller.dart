import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/model/user_model.dart';
import 'package:firstapp/utils/local_storage_data.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
class ProfileController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  getCurrentUser();
  }

  final LocalStorageData localStorageData = Get.find();

  File? selectedImagee;
  String? _downloadURL;

  final imagePicker = ImagePicker();



  UserModel get userModel => _userModel;
 late UserModel _userModel;

  void getCurrentUser() async{
    await localStorageData.getUser.then((value) {
      _userModel = value!;
    });
    update();
  }

  Future<void> signOut() async{
    GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
    localStorageData.deleteUser();
  }

  Future uploadProfileImg()async{

    final returnedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    selectedImagee = File(returnedImage!.path);

    uploadImage();
  update();
  }

Future<void> uploadImage() async {
    if (selectedImagee == null) return;

    final fileName = selectedImagee!.path.split('/').last;
    final destination = 'profile_images/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination);
      await ref.putFile(selectedImagee!);
      final downloadURL = await ref.getDownloadURL();

        _downloadURL = downloadURL;

      // Save the download URL in Firestore
      await FirebaseFirestore.instance.collection('Users').doc('userId').update({
        'pic': downloadURL,
      });

      // If using Realtime Database
      // await FirebaseDatabase.instance.ref('users/user_id').update({
      //   'profileImageUrl': downloadURL,
      // });

      print('File uploaded successfully. Download URL: $downloadURL');
    } catch (e) {
      print('Error uploading image: $e');
    }
    update();
  }
}