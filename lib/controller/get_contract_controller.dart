import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/model/contract_model.dart';
import 'package:firstapp/services/firestore_contract.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetContractsController extends GetxController{
  List<ContractModel> contractList = [];
   ValueNotifier<bool> get loading => _loading;

  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<ContractModel> get contractModel => _contractModel;

  List<ContractModel> _contractModel = [];


  bool favornot = false;


  getContracts() async{
    _loading.value = true;
    FireStoreContract().getPropertiess().then((value){
      for(int i = 0; i < value.length; i++){
        _contractModel.add(ContractModel.fromJson(value[i].data() as Map));
        _loading.value = false;
      }
      for(int i = 0; i< _contractModel.length; i++){
        if(contractModel[i].sellerEmail == FirebaseAuth.instance.currentUser!.email || contractModel[i].buyerEmail == FirebaseAuth.instance.currentUser!.email){
          contractList.add(contractModel[i]);
        }
      }
      update();
    });
    }
    GetContractsController(){
      getContracts();
    }
}