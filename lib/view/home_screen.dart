import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/constance.dart';
import 'package:firstapp/controller/add_property_controller.dart';
import 'package:firstapp/controller/get_property_controller.dart';
import 'package:firstapp/controller/get_saved_property_controller.dart';
import 'package:firstapp/controller/savings_controller.dart';
import 'package:firstapp/model/savings_model.dart';
import 'package:firstapp/view/details_screen.dart';
import 'package:firstapp/view/filters_screen.dart';
import 'package:firstapp/view/profile_screen.dart';
import 'package:firstapp/view/saved_screen.dart';
import 'package:firstapp/view/saving_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'theme/house_app_theme.dart';

class HomeScreen extends StatefulWidget {

 // HomeScreen({required Key key, required this.model}): super(key: key);
  @override

  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {

      List<XFile> imageListcont = Get.find<AddPropertyController>().imageList;

      Future<List<String>> uploadFiles(List<File> _images) async {
        var imageUrls = await Future.wait(_images.map((_image) => uploadFile(_image)));
        print(imageUrls);
        return imageUrls;
      }

      Future<String> uploadFile(File _image) async {
        final storageReference = FirebaseStorage.instance
            .ref()
            .child('posts/${_image.path}');
        final uploadTask = storageReference.putFile(_image);
        await uploadTask.whenComplete(() {});

        return await storageReference.getDownloadURL();
      }


List<String> propIDlst = [];
bool? saved;


      //bool isFavourite = false;
      //List favouriteList = [];
      
      //_HomeScreenState({required this.model});
  AnimationController? animationController;
  //List<PropertyListData> propertyList = PropertyListData.propertyList;
  final ScrollController _scrollController = ScrollController();

 // DateTime startDate = DateTime.now();
 // DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  // Future<bool> getData() async {
  //   await Future<dynamic>.delayed(const Duration(milliseconds: 200));
  //   return true;
  // }

 // @override
  // void dispose() {
  //   animationController?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HouseAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InkWell(
              
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    getAppBarUI(),
                    Expanded(
                      
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Column(
                                  children: <Widget>[
                                    // getSearchBarUI(),
                                    //getTimeDateUI(),
                                  ],
                                );
                              }, childCount: 1),
                            ),
                            SliverPersistentHeader(
                              pinned: true,
                              floating: true,
                              delegate: ContestTabHeader(
                                getFilterBarUI(),
                              ),
                            ),
                          ];
                        },
                        body: Container(
                          color:
                              HouseAppTheme.buildLightTheme().backgroundColor,
                          child: GetBuilder<GetPropertyController>(
                            init: GetPropertyController(),
                            builder: (controller) => ListView.builder(
                              itemCount: controller.propertyModel.length,
                              padding: const EdgeInsets.only(top: 8),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                final int count =
                                    controller.propertyModel.length > 10 ? 10 : controller.propertyModel.length;
                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                        CurvedAnimation(
                                            parent: animationController!,
                                            curve: Interval(
                                                (1 / count) * index, 1.0,
                                                curve: Curves.fastOutSlowIn)));
                                animationController?.forward();
                                return AnimatedBuilder(
      animation: animationController!,
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
                  Get.to(PropertyDetailsScreen(model: controller.propertyModel[index]));
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
                                controller.propertyModel[index].pic.toString(),
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
                                            fontStyle: FontStyle.italic
                                            
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
                                                controller.propertyModel[index].city.toString(),
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
                                        Text(' ${controller.propertyModel[index].noOfRooms.toString()} Beds'),
                                        SizedBox(width: 10),
                                        Icon(Icons.bathtub, color: primaryColor),
                                        Text(' ${controller.propertyModel[index].noOfBaths.toString()} Baths'),
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
                                              onPressed: () {
                                                launch('tel:+2${controller.propertyModel[index].brokerPhone}');
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.email, color: primaryColor,),
                                              onPressed: () async {
                                                String? encodeQueryParameters(Map<String, String> params) {
                          return params.entries
                              .map((MapEntry<String, String> e) =>
                                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                              .join('&');
                        }


                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: '${controller.propertyModel[index].brokerEmail}',
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
                                              onPressed: () async{
                                                var whatsappUrl = Uri.parse(
                     "whatsapp://send?phone=+2${ controller.propertyModel[index].brokerPhone}" +
                     "&text=${Uri.encodeComponent("i aim to ask about your posted property")}");
                        try {
                          launchUrl(whatsappUrl);
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                                                //await launch("https://wa.me/+2+2${controller.propertyModel[index].brokerPhone}?text=hello");
                                              },
                                            ),
                                          ],
                                        ),
                                        // Cost Display
                                        Text(
                                          '\$${controller.propertyModel[index].price.toString()}',
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
                                child:  GestureDetector(
                                    onTap: (){
                                      controller.toggleFavourites(controller.propertyModel[index]);
                                    },
                                    child: controller.isExist(controller.propertyModel[index]) == false? Icon(Icons.favorite_border): Icon(Icons.favorite, color: Colors.red,) 
                                    
                                  ),
                                
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController locController = TextEditingController();
  List? loclist;

  // Widget getSearchBarUI() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
  //     child: Row(
  //       children: <Widget>[
  //         Expanded(
  //           child: Padding(
  //             padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 color: HouseAppTheme.buildLightTheme().backgroundColor,
  //                 borderRadius: const BorderRadius.all(
  //                   Radius.circular(38.0),
  //                 ),
  //                 boxShadow: <BoxShadow>[
  //                   BoxShadow(
  //                       color: Colors.grey.withOpacity(0.2),
  //                       offset: const Offset(0, 2),
  //                       blurRadius: 8.0),
  //                 ],
  //               ),
  //               child: Padding(
  //                 padding: const EdgeInsets.only(
  //                     left: 16, right: 16, top: 4, bottom: 4),
  //                 child: TextField(
  //                   controller: locController,
  //                   onChanged: (String txt) {},
  //                   style: const TextStyle(
  //                     fontSize: 18,
  //                   ),
  //                   cursorColor: HouseAppTheme.buildLightTheme().primaryColor,
  //                   decoration: InputDecoration(
  //                     border: InputBorder.none,
  //                     hintText: 'London...',
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Container(
  //           decoration: BoxDecoration(
  //             color: HouseAppTheme.buildLightTheme().primaryColor,
  //             borderRadius: const BorderRadius.all(
  //               Radius.circular(38.0),
  //             ),
  //             boxShadow: <BoxShadow>[
  //               BoxShadow(
  //                   color: Colors.grey.withOpacity(0.4),
  //                   offset: const Offset(0, 2),
  //                   blurRadius: 8.0),
  //             ],
  //           ),
  //           child: Material(
  //             color: Colors.transparent,
  //             child: InkWell(
  //               borderRadius: const BorderRadius.all(
  //                 Radius.circular(32.0),
  //               ),
  //               onTap: () {
  //                 FocusScope.of(context).requestFocus(FocusNode());
  //               },
  //               child: Padding(
  //                 padding: const EdgeInsets.all(16.0),
  //                 child:  Builder(
  //                   builder: (context) {
  //                     return GetBuilder<GetPropertyController>(
  //                       init: GetPropertyController(),
  //                       builder: (controller) => GestureDetector(
  //                           onTap: (){
  //                             //showSearch(context: context, delegate: PropertySearch(properties: controller.propertyModel));
  //                           //  Get.to(SearchScreen());

  //                             //PropertySearch x  = PropertySearch(properties: controller.propertyModel);
                              
  //                             //Get.to(SearchBarScreen());
  //                            // loclist = controller.propertyModel.where((element) => element.locationn!.contains(locController.text)).toList();
  //                           },
  //                           child: Icon(FontAwesomeIcons.magnifyingGlass,
  //                               size: 20,
  //                               color: HouseAppTheme.buildLightTheme().backgroundColor),
  //                         ),
  //                     );
  //                   }
  //                 ),
                  
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: HouseAppTheme.buildLightTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: HouseAppTheme.buildLightTheme().backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GetBuilder<GetPropertyController>(
                      builder: (controller2) => Text(
                        '${controller2.propertyModel.length} Houses Found',
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => FiltersScreen(),
                            fullscreenDialog: true),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.sort,
                                color: HouseAppTheme.buildLightTheme()
                                    .primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: HouseAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Explore',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Material(
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
                          //  Get.to(SavingListScreen());
                           Get.to(SavedScreen());
                          },
                          child: Icon(Icons.favorite_border)),
                      ),
                    ),
                  ),
                  Material(
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
                            Get.to(ProfileScreen());
                          },
                          child: Icon(Icons.person)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
