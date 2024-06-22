class ContractModel{
  String? sellerEmail, buyerEmail;
  List? contractPic;
  ContractModel({
    this.sellerEmail,
    this.buyerEmail,
    this.contractPic
  });
  ContractModel.fromJson(Map<dynamic, dynamic> map){
  if(map == null){
    return;
  }
  sellerEmail = map['seller email'];
  buyerEmail = map['buyer email'];
  contractPic = map['contract picture'];
}
tojson(){
  return{
    'seller email': sellerEmail,
    'buyer email': buyerEmail,
    'contract picture': contractPic
  };
}
}