// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/constance.dart';
import 'package:firstapp/controller/get_property_controller.dart';
import 'package:firstapp/model/property_model.dart';
import 'package:firstapp/view/details_screen.dart';
import 'package:firstapp/view/theme/house_app_theme.dart';
import 'package:firstapp/view/update_posted_property.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/animation_controller.dart';

class UserPostsScreen extends StatefulWidget {
  
   const UserPostsScreen({super.key});

  @override
  State<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  List<QueryDocumentSnapshot> datap = [];
  List ids = [];
// getids() async{
//   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Properties').get();
//   datap.addAll(querySnapshot.docs);
//   for(int i = 0; i< datap.length; i++){
//     ids.add(datap[i].id);
//   }
// }  

// List propids = Get.find<GetPropertyController>().ids;
// List originalprop = Get.find<GetPropertyController>().propertyModel;
var trueid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Properties'), backgroundColor: primaryColor,),
      body: SafeArea(
        child:SingleChildScrollView(
          child: GetBuilder<AnimationControl>(
            init: AnimationControl(),
            builder: (controllerr) => Container(
                            color:
                                HouseAppTheme.buildLightTheme().backgroundColor,
                            child: GetBuilder<GetPropertyController>(
                              init: GetPropertyController(),
                              builder: (controller) => ListView.builder(
                                itemCount: controller.userList.length,
                                padding: const EdgeInsets.only(top: 8),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  final int count =
                                      controller.userList.length > 10 ? 10 : controller.userList.length;
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
                  onTap: (){
                    Get.to(PropertyDetailsScreen(model: controller.userList[index]));
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
                                  controller.userList[index].pic.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 8,
                                        bottom: 8,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'House',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  controller.userList[index].city.toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey
                                                        .withOpacity(0.8),
                                                  ),
                                                ),
                                              ),
                                              // Text(
                                              //   '${propertyData.dist.toStringAsFixed(1)} km to city',
                                              //   overflow: TextOverflow.ellipsis,
                                              //   style: TextStyle(
                                              //     fontSize: 14,
                                              //     color: Colors.grey
                                              //         .withOpacity(0.8),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        children: [
                                          Icon(Icons.bed, color: primaryColor),
                                          Text(' ${controller.userList[index].noOfRooms.toString()} Beds'),
                                          SizedBox(width: 10),
                                          Icon(Icons.bathtub, color: primaryColor),
                                          Text(' ${controller.userList[index].noOfBaths.toString()} Baths'),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Action Icons
                                          Row(
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.phone, color: primaryColor,),
                                                onPressed: () async {
                                                  launch('tel:+2${controller.userList[index].brokerPhone}');
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.email, color: primaryColor,),
                                                onPressed: ()async {
                                                  String? encodeQueryParameters(Map<String, String> params) {
                          return params.entries
                              .map((MapEntry<String, String> e) =>
                                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                              .join('&');
                        }


                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: '${controller.userList[index].brokerEmail}',
                    query: encodeQueryParameters(<String, String>{
                      'subject': 'how can we help you',
                      'body': 'i aim to know more details about a property'
                    })
                  );
                  // if(await canLaunchUrl(emailUri)){
                  //   launchUrl(emailUri);
                  // }
                  // else{
                  //   throw Exception('could not launch $emailUri');
                  // }

                  try{
                    await launchUrl(emailUri);
                  }catch(e){
                    print(e.toString());
                  }
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(LineAwesomeIcons.what_s_app, color: primaryColor,),
                                                onPressed: ()async {
                                                  var whatsappUrl = Uri.parse(
                     "whatsapp://send?phone=+2${ controller.userList[index].brokerPhone}" +
                     "&text=${Uri.encodeComponent("i aim to ask about your posted property")}");
                        try {
                          launchUrl(whatsappUrl);
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                                                },
                                              ),
                                            ],
                                          ),
                                          // Cost Display
                                          Text(
                                            '\$${controller.userList[index].price.toString()}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 19,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(onPressed: () async{
                                            QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Properties').get();
                                          datap.addAll(querySnapshot.docs);
                                          for(int i = 0; i< datap.length; i++){
                                            ids.add(datap[i].id);
                                          }
                                            for(int i = 0; i< controller.propertyModel.length; i++){
                                              if(controller.propertyModel[i] == controller.userList[index]){
                                                trueid = ids[i];
                                              //  break;
                                              }
                                            }
                                            Get.to(UpdatePostedPropertyScreen(propid: trueid, model: controller.userList[index],));
                                            }, child: Text('update', style: TextStyle(fontSize: 16),),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor
                                            , fixedSize: Size(120, 40)
                                          )
                                          ),
                                          ElevatedButton(onPressed: () async{
                                            QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Properties').get();
                                          datap.addAll(querySnapshot.docs);
                                          for(int i = 0; i< datap.length; i++){
                                            ids.add(datap[i].id);
                                          }
                                            for(int i = 0; i< controller.propertyModel.length; i++){
                                              if(controller.propertyModel[i] == controller.userList[index]){
                                                trueid = ids[i];
                                              //  break;
                                              }
                                            }
                                            showDialog(context: context, builder: (BuildContext ctx) {
                                              return Expanded(
                      child: AlertDialog(
                        title: Text('Delete a property'),
                        content: Text('are you sure you want to delete this property?'),
                        actions: [
                          ElevatedButton(onPressed: () async{
                            print('iddd: $trueid'); 
                           await FirebaseFirestore.instance.collection('Properties').doc(trueid).delete();
                           Navigator.of(ctx).pop();
                            setState(() {
                              controller.userList.remove(controller.userList[index]);
                            });
                            
                            }, child: Text('yes'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor
                                          )
                                          ),
                          ElevatedButton(onPressed: (){Navigator.of(ctx).pop();}, child: Text('cancel'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor
                                          )
                                          ),
                     ],
                ),
          ); 
                                            }
                                            
                                            );
                                            //await FirebaseFirestore.instance.collection('Properties').doc(trueid).delete();
                                            //print('iddd: $trueid');
                                          }
                                          , child: Text('delete', style: TextStyle(fontSize: 16),),
                                          style: ElevatedButton.styleFrom(backgroundColor: primaryColor, fixedSize: Size(120, 40)),
                                          
                                          ),
                                         
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(32.0),
                                ),
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: (){
                                     controller.toggleFavourites(controller.userList[index]);
                                    },
                            child: controller.isExist(controller.userList[index]) == false? Icon(Icons.favorite_border): Icon(Icons.favorite, color: Colors.red,)                                      ),
                                ),
                              ),
                            ),
                          )
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