import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/controller/animation_controller.dart';
import 'package:firstapp/controller/get_contract_controller.dart';
import 'package:firstapp/view/contract_details_screen.dart';
import 'package:firstapp/view/theme/house_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContractScreen extends StatefulWidget {
  const ContractScreen({super.key});

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  List<QueryDocumentSnapshot> datap = [];
  List ids = [];
  Color primaryColor = const Color(0xff446FAF);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Your Contracts', style: TextStyle(fontStyle: FontStyle.italic),),
      ),
      body:SafeArea(
        child:SingleChildScrollView(
          child: GetBuilder<AnimationControl>(
            init: AnimationControl(),
            builder: (controllerr) => Container(
                            color:
                                HouseAppTheme.buildLightTheme().backgroundColor,
                            child: GetBuilder<GetContractsController>(
                              init: GetContractsController(),
                              builder: (controller) => ListView.builder(
                                itemCount: controller.contractList.length,
                                padding: const EdgeInsets.only(top: 8),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  final int count =
                                      controller.contractList.length > 10 ? 10 : controller.contractList.length;
                                  final Animation<double> animation =
                                      Tween<double>(begin: 0.0, end: 1.0).animate(
                                          CurvedAnimation(
                                              parent: controllerr.animationController!,
                                              curve: Interval(
                                                  (1 / count) * index, 1.0,
                                                  curve: Curves.fastOutSlowIn)));
                                  controllerr.animationController?.forward();
                                  return AnimatedBuilder(
                animation: controllerr.animationController!,
                builder: (BuildContext context, Widget? child) {
                  return FadeTransition(
            opacity: animation,
            child: Transform(
              transform: Matrix4.translationValues(
                0.0,
                50 * (1.0 - animation.value),
                0.0,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 8,
                  bottom: 16,
                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () async{
                   Get.to(ContractDetailsScreen(model: controller.contractList[index]));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          offset: const Offset(4, 4),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 2,
                                child: Image.network(
                                  controller.contractList[index].contractPic![0].toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 8,
                                    bottom: 8,
                                  ),
                                  
                                  child: Text(
                                    'Sold Property Contract',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      color: primaryColor
                                    ),
                                  ),
                                ),
                              ),
                            ],

                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
                  );
                },
              );
                                },
                              ),
                            ),
                          ),
          ),
                    
            )
         ),
    );
  }
}