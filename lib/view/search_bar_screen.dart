import 'package:firstapp/constance.dart';
import 'package:firstapp/controller/animation_controller.dart';
import 'package:firstapp/controller/get_property_controller.dart';
import 'package:firstapp/model/property_model.dart';
import 'package:firstapp/view/details_screen.dart';
import 'package:firstapp/view/theme/house_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResaultPage extends StatelessWidget {
  //const SearchResaultPage({super.key});

  List<PropertyModel> filterList;

  SearchResaultPage(this.filterList);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('results', style: TextStyle(color: Colors.white),), backgroundColor: primaryColor,),
      body: Column(
        children:[
           GetBuilder<AnimationControl>(
              init: AnimationControl(),
              builder: (controllerr) => Expanded(
                child: Container(
                     // height: MediaQuery.of(context).size.height,
                     // width: MediaQuery.of(context).size.width,
                          color:
                              HouseAppTheme.buildLightTheme().backgroundColor,
                          child: GetBuilder<GetPropertyController>(
                            //init: GetPropertyController(),
                            builder: (controller) => Expanded(
                              child: ListView.builder(
                                itemCount: filterList.length,
                                padding: const EdgeInsets.only(top: 8),
                               physics:const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final int count =
                                      filterList.length  > 10 ? 10 : filterList.length;
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
                                          Get.to(PropertyDetailsScreen(model: filterList[index]));
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
                                  filterList[index].pic.toString(),
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
                                            'House' ,
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
                                                  filterList[index].city.toString(),
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
                                          Icon(Icons.bed, color: Colors.blue),
                                          Text(
                                            ' ${filterList[index].noOfRooms.toString()} Beds',),
                                          SizedBox(width: 10),
                                          Icon(Icons.bathtub, color: Colors.blue),
                                          Text(' ${filterList[index].noOfBaths.toString()} Baths'),
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
                                                icon: Icon(Icons.phone),
                                                onPressed: () {
                                                  // Implement call action
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.message),
                                                onPressed: () {
                                                  // Implement message action
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.whatshot),
                                                onPressed: () {
                                                  // Implement WhatsApp action
                                                },
                                              ),
                                            ],
                                          ),
                                          // Cost Display
                                          Text(
                                            '\$${filterList[index].price.toString()}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 19,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                     controller.toggleFavourites(filterList[index]);
                                    },
                                                  child: controller.isExist(filterList[index]) == false? Icon(Icons.favorite_border): Icon(Icons.favorite, color: Colors.red,)                                      ),
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
              ),
                     ),
        ]
      ),
         
    );
  }
}