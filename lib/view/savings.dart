import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/controller/get_property_controller.dart';
import 'package:firstapp/controller/get_saved_property_controller.dart';
import 'package:firstapp/controller/profile_controller.dart';
import 'package:firstapp/view/details_screen.dart';
import 'package:firstapp/view/theme/house_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/profile_list_item.dart';

class ListingScreen extends StatefulWidget {
  
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  AnimationController? animationController;


  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          GetBuilder<ProfileController>(
            init: ProfileController(),
            builder: (controller) => ProfileListItem(
                          LineAwesomeIcons.home,
                          'Add a a photo',
                          true,
                          (){
                            controller.uploadProfileImg();
                          }
                        ),
          ),
          
        ]),
      )
    );
  }
  getbutton(){
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) => ProfileListItem(
                        LineAwesomeIcons.home,
                        'confirm photo',
                        true,
                        (){
                        }
                      ),
    );
  }
}