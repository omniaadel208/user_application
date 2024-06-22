import 'package:firstapp/constance.dart';
import 'package:firstapp/controller/get_contract_controller.dart';
import 'package:firstapp/model/contract_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContractDetailsScreen extends StatelessWidget {
  late ContractModel model;
ContractDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Contract Details', style: TextStyle(fontStyle: FontStyle.italic),),
      ),
      body: SafeArea(
        child: GetBuilder<GetContractsController>(
          init: GetContractsController(),
          builder: (controller) => ListView.builder(
            scrollDirection: Axis.vertical,
          itemCount: model.contractPic!.length,
          itemBuilder: (BuildContext context, int index) {
          return Image.network(model.contractPic![index]);
          },
            ),
        ),

        ),
    );
  }
}