import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/constance.dart';
import 'package:firstapp/controller/add_property_controller.dart';
import 'package:firstapp/view/components/add_property_data.dart';
import 'package:firstapp/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:path/path.dart';
class AddPropertyScreen extends StatelessWidget {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
List<String> urlimg = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 25, right: 25),
            child:Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Add a Property',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 25,),
                  Form(
                    key: _formkey,
                    child: Column(children: [
                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('number of rooms', '2', Icons.bed,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.noOfRooms = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                        
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('number of baths', '2', Icons.bathtub,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.noOfBaths = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('area', '200sqft', Icons.square_foot,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.area = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('lot area', '200sqft', Icons.square_foot_outlined,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.lotArea = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                      SizedBox(height: 20,),

                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('number of floors', '2', Icons.home,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.noOfFloors = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                        SizedBox(height: 20,),

                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('water front or not', 'yes/no', Icons.question_answer,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.waterfrontOrNot = newvalue;
                            }, TextInputType.text
                            ),
                        ),
                      SizedBox(height: 20,),
                      GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('view rate', '1.5', Icons.rate_review,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.viewRate = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                        SizedBox(height: 20,),
                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('condition rate', '1.5', Icons.rate_review_outlined,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.conditionRate = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                        SizedBox(height: 20,),
                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('grade', '1', Icons.grade,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.grade = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                        SizedBox(height: 20,),
                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('roof area', '10sqft', Icons.area_chart_outlined,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.roofArea = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                        SizedBox(height: 20,),
                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('year built', '2002', Icons.date_range,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.yearbuilt = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                        SizedBox(height: 20,),
                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('city', 'maadi', Icons.location_city,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.city = newvalue;
                            }, TextInputType.text
                            ),
                        ),
                        SizedBox(height: 20,),
                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('zipcode', '12345', Icons.folder_zip,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.zipcode = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                        SizedBox(height: 20,),
                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('lattitude', '1.5', Icons.area_chart_sharp,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.lat = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                        SizedBox(height: 20,),
                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('longtude', '1.5', Icons.area_chart_sharp,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.lon = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                        SizedBox(height: 20,),
                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('area 15', '15sqft', Icons.square_foot,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.area15 = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                        SizedBox(height: 20,),
                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('lot area 15', '15 sqft', Icons.area_chart_rounded,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.lotArea15 = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                        SizedBox(height: 20,),
                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('payment type', 'cash/installment', Icons.payment,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.paymentType = newvalue;
                            }, TextInputType.text
                            ),
                        ),
                        SizedBox(height: 20,),
                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('down payment', '25000', Icons.money_off,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.downPayment = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                        SizedBox(height: 20,),
                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('installment value', '1500', Icons.money_off_outlined,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.installmentValue = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                        SizedBox(height: 20,),
                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('description', 'property description', Icons.description,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.description = newvalue;
                            }, TextInputType.text
                            ),
                        ),
                        SizedBox(height: 20,),
                        GetBuilder<AddPropertyController>(
                          builder: (controller) => AddPropertyData('price', '25000', Icons.money,
                          (value){
                            if(value == null || value.isEmpty){return 'Please enter some text';
                              }
                            },
                           (newvalue){
                            controller.price = newvalue;
                            }, TextInputType.number
                            ),
                        ),
                      ],),
                  ),
                  
                  
                  SizedBox(height: 20,),
            
                  GetBuilder<AddPropertyController>(
                      builder:(controller) =>ElevatedButton(onPressed:(){
              controller.uploadImage();
                      },
               child: Text('upload photo',
               style: TextStyle(color: Colors.white),),
               style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
               ),
               ),
                    ),
                  
                  SizedBox(height: 20,),
            
                   GetBuilder<AddPropertyController>(
                      builder: (controller) => Container(
              height: 200,
              child: ListView.separated(
              scrollDirection: Axis.horizontal,
               itemCount: controller.imageList.length,
               itemBuilder: (context, index){
                  return controller.imageList.isEmpty? Text('no choosen images'): Image.file(File(controller.imageList[index].path),width: 100, height: 100,);
                  //Future.delayed(Duration(seconds: 2));
              },
                separatorBuilder: (BuildContext context, int index) => SizedBox(width: 20,),
               ),
                      ),
                    ),
                    SizedBox(height: 30,),
                  
            
                  GetBuilder<AddPropertyController>(
                    builder: (controller) =>ElevatedButton(
                      onPressed: () async {
                        File file;
                        var url;
                        _formkey.currentState!.save();
                        if(_formkey.currentState!.validate()){
                          for(int i = 0; i < controller.imageList.length; i++){
                                if(controller.imageList[i] != null){
                                  file = File(controller.imageList[i].path);
                                  var imagename = basename(controller.imageList[i].path);
                                  var refStorage = FirebaseStorage.instance.ref('Property Images/${imagename}');
                                  await refStorage.putFile(file);
                                  url = await refStorage.getDownloadURL();
                                  urlimg.add(url);
                                }
                              }
                              //QuerySnapshot docref = await FirebaseFirestore.instance.collection('Properties').get();
                              Get.to(HomeScreen());
                          controller.picList = urlimg;
                          controller.pic = urlimg[0];
                          controller.addProperty();
                          controller.imageList.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        minimumSize: Size(300, 50),
                        ),
                      child: const Text('Add',
                      style: TextStyle(
                        fontSize: 20
                      ),
                      ),
                    ),
                  ),
                SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        )
        ,
    );
  }
}