// ignore_for_file: deprecated_member_use, unused_element

import 'package:firstapp/constance.dart';
import 'package:firstapp/model/property_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class PropertyDetailsScreen extends StatelessWidget {

  late PropertyModel model;

  PropertyDetailsScreen({required this.model});


  @override
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: primaryColor,
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
  title: Text('House', style: TextStyle(fontStyle: FontStyle.italic),),
),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           _buildPropertyImage(),
          _buildPropertyInfo(),
          _buildPropertyFeatures(),
         // _buildPropertyDescription(),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonTheme(
                minWidth: 100,
                child: ElevatedButton(
                  onPressed: () {
                  launch('tel:+2${model.brokerPhone}');
                  },
                  child: Text('call', style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),),
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              ButtonTheme(
                minWidth: 100,
                child: ElevatedButton(
                  onPressed: () async {
                    String? encodeQueryParameters(Map<String, String> params) {
                            return params.entries
                                .map((MapEntry<String, String> e) =>
                                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                .join('&');
                          }
              
                    final Uri emailUri = Uri(
                      scheme: 'mailto',
                      path: model.brokerEmail,
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
                  
                  child: Text('email', style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              ButtonTheme(
                minWidth: 100,
                child: ElevatedButton(
                  onPressed: () async {
              var whatsappUrl = Uri.parse(
                       "whatsapp://send?phone=+2${model.brokerPhone}" +
                       "&text=${Uri.encodeComponent("i aim to ask about your posted property")}");
                          try {
                            launchUrl(whatsappUrl);
                          } catch (e) {
                            debugPrint(e.toString());
                          }                },
                  child: Text('whatsapp', style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),),
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
  Widget _buildPropertyImage() {
    return Container(
      height: 200,
      child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: model.picList?.length,
                      itemBuilder: (context, index1) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: model.picList == null? Image.network('https://www.buyrentkenya.com/discover/wp-content/uploads/2022/06/brk-blog-4reasons-why.png'): Image.network(model.picList![index1].toString())
                          // child: Image.network(controller.propertyModel[index].picList![index1].toString(), fit:BoxFit.cover, width: 250,)
                        );
                      },
                    ),
      // child:  Image.asset(
      // 'assets/hotel_2.png',
      //   fit: BoxFit.cover,
      // ),
    );
  }
  


 Widget _buildPropertyInfo() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Icon(Icons.bed, color: primaryColor),
                Text('${model.noOfRooms.toString()} Rooms')
              ],),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Icon(Icons.bathtub, color: primaryColor),
                Text('${model.noOfBaths.toString()} Baths')
              ],),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Icon(Icons.square_foot, color: primaryColor),
                Text('${model.area.toString()} sqft')
              ],),
            )
        ],),
        // Text(
          
        //   '${model.area} sqft, ${model.noOfRooms} bedrooms, ${model.noOfBaths} bathrooms',
        //   style: TextStyle(
        //     fontSize: 24,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        SizedBox(height: 25),
        Row(
          children: [
            Text(
              'Location:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.city.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              'Estimated Price:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.price.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
        Divider(height: 5,thickness: 2, color: primaryColor,)
      ],
    ),

  );
}

  Widget _buildPropertyFeatures() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
          children: [
            Text(
              'Lot Area:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.lotArea.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
          SizedBox(height: 15,),
          Row(
          children: [
            Text(
              'Number of Floors:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.noOfFloors.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
          SizedBox(height: 15,),
          Row(
          children: [
            Text(
              'Water Front:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.waterfrontOrNot.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
          SizedBox(height: 15,),
          Row(
          children: [
            Text(
              'View Rate:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.viewRate.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
        Divider(thickness: 2,color: primaryColor,),
          SizedBox(height: 15,),
          Row(
          children: [
            Text(
              'Condition Rate:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.conditionRate.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
          SizedBox(height: 15,),
          Row(
          children: [
            Text(
              'Grade:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.grade.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
          SizedBox(height: 15,),
          Row(
          children: [
            Text(
              'Roof Area:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.roofArea.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
          SizedBox(height: 15,),
          Row(
          children: [
            Text(
              'Year Built:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.yearbuilt.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
        Divider(height: 5,thickness: 2, color: primaryColor,),
          SizedBox(height: 15,),
          Row(
          children: [
            Text(
              'Zipcode:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.zipcode.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
          SizedBox(height: 15,),
          Row(
          children: [
            Text(
              'Latitude:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.lat.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
          SizedBox(height: 15,),
          Row(
          children: [
            Text(
              'Longitude:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.lon.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
          SizedBox(height: 15,),
          Row(
          children: [
            Text(
              'Area15:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.area15.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
        Divider(height: 5,thickness: 2, color: primaryColor,),
          SizedBox(height: 15,),
          Row(
          children: [
            Text(
              'Lot Area15:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.lotArea15.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
          SizedBox(height: 15,),
          Row(
          children: [
            Text(
              'Payment Type:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.paymentType.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
          SizedBox(height: 15,),
          Row(
          children: [
            Text(
              'Down Payment:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.downPayment.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
          SizedBox(height: 15,),
          Row(
          children: [
            Text(
              'Installment Value:',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.installmentValue.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
        Divider(height: 5,thickness: 2, color: primaryColor,),
          SizedBox(height: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description:-',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(' ${model.description.toString()}', style:TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600
                //color: primaryColor
              ) ,)
          ],
        ),
          // Text(
          //   'Amenties: ${model.amenty.toString()}',
          //   style: TextStyle(
          //     fontSize: 18,
          //   ),
          // ),
          // SizedBox(height: 8),
          // Text(
          //   model.amenty.toString(),
          //   style: TextStyle(
          //     fontSize: 24,
          //     fontWeight: FontWeight.bold,
          //   ),
          // )
          // Wrap(
          //   spacing: 8,
          //   runSpacing: 8,
          //   children: [
          //     _buildFeatureChip('Air Conditioning'),
          //     _buildFeatureChip('Swimming Pool'),
          //     _buildFeatureChip('Gym'),
          //     _buildFeatureChip('Garage'),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildPropertyDescription() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description: ${model.description.toString()}',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          // Text(
          //   model.description.toString(),style: TextStyle(fontFamily: AutofillHints.addressCity ),
          // ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String label) {
    return Chip(
      label: Text(label,style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),),
      backgroundColor: primaryColor,
    );
    
  }
}