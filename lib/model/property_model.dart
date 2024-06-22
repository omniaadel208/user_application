class PropertyModel{

  // String? locationn, area, type, paymentType,price, amenty, noOfRooms, noOfBaths, downPayment, installmentValue, description, brokerPhone, brokerEmail, userEmail, pic;
  String? noOfRooms, noOfBaths, area, lotArea, noOfFloors, waterfrontOrNot, viewRate, conditionRate, grade, roofArea, yearbuilt, zipcode, lat, lon, area15, lotArea15, paymentType, downPayment, installmentValue,description, userEmail, pic, brokerPhone, brokerEmail, price, estimatedPrice, city;
  List? picList;

  PropertyModel({
    this.noOfRooms,
    this.noOfBaths, 
    this.area,
    this.lotArea,
    this.noOfFloors,
    this.waterfrontOrNot,
    this.viewRate,
    this.conditionRate,
    this.grade,
    this.roofArea,
    this.yearbuilt,
    this.zipcode,
    this.lat,
    this.lon,
    this.area15,
    this.lotArea15,
    this.paymentType, 
    this.downPayment, 
    this.installmentValue,
    this.description,
    this.brokerPhone,
    this.brokerEmail,
    this.userEmail,
    this.pic,
    this.picList,
    this.price,
    this.estimatedPrice,
    this.city
    });
PropertyModel.fromJson(Map<dynamic, dynamic> map){
  if(map == null){
    return;
  }
  noOfRooms = map['number of rooms'];
  noOfBaths = map['number of baths'];
  area = map['area'];
  lotArea = map['lotArea'];
  noOfFloors = map['number of floors'];
  waterfrontOrNot = map['water front'];
  viewRate = map['view rate'];
  conditionRate = map['condition rate'];
  grade = map['grade'];
  roofArea = map['roof area'];
  yearbuilt = map['year built'];
  zipcode = map['zipcode'];
  lat = map['lat'];
  lon = map['lon'];
  area15 = map['area15'];
  lotArea15 = map['lot area 15'];
  paymentType = map['payment type'];
  downPayment = map['down payment'];
  installmentValue = map['installment value'];
  description = map['description'];
  brokerPhone = map['broker phone'];
  brokerEmail = map['broker email'];
  userEmail = map['user email'];
  pic = map['pic'];
  picList = map['picList'];
  price = map['price'];
  estimatedPrice = map['estimated price'];
  city = map['city'];
}
tojson(){
  return{
    'number of rooms': noOfRooms,
    'number of baths': noOfBaths,
    'area': area,
    'lotArea': lotArea,
    'number of floors': noOfFloors,
    'water front': waterfrontOrNot,
    'view rate': viewRate,
    'condition rate': conditionRate,
    'grade': grade,
    'roof area': roofArea,
    'year built': yearbuilt,
    'zipcode': zipcode,
    'lat': lat,
    'lon': lon,
    'area15': area15,
    'lot area 15': lotArea15,
    'payment type':paymentType,
    'down payment':downPayment,
    'installment value': installmentValue,
    'description': description,
    'broker phone': brokerPhone,
    'broker email': brokerEmail,
    'user email': userEmail,
    'pic': pic,
    'picList': picList,
    'price': price,
    'estimated price': estimatedPrice,
    'city': city
  };
}
  // PropertyModel.fromJson(Map<dynamic, dynamic> map){
  //   if(map == null){
  //     return;
  //   }
  //   locationn = map['Location'];
  //   area = map['area'];
  //   type = map['type'];
  //   price = map['price'];
  //   noOfRooms = map['number of rooms'];
  //   noOfBaths = map['number of baths'];
  //   amenty = map['Amenties'];
  //   paymentType = map['payment type'];
  //   downPayment = map['down payment'];
  //   installmentValue = map['installment value'];
  //   description = map['description'];
  //   brokerPhone = map['broker phone'];
  //   brokerEmail = map['broker email'];
  //   userEmail = map['user email'];
  //   pic = map['pic'];
  //   picList = map['picList'];
  // }

  // toJson(){
  //   return{
  //     'Location': locationn,
  //     'area': area,
  //     'type': type,
  //     'price': price,
  //     'number of rooms': noOfRooms,
  //     'number of baths': noOfBaths,
  //     'Amenties': amenty,
  //     'payment type':paymentType,
  //     'down payment':downPayment,
  //     'installment value': installmentValue,
  //     'description': description,
  //     'broker phone': brokerPhone,
  //     'broker email': brokerEmail,
  //     'user email': userEmail,
  //     'pic': pic,
  //     'picList': picList,
  //   };
  // }

}