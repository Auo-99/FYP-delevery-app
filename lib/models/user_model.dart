class UserModel{
   int id;
   String email;
   //String password;
   String name;
   String phone;
   int orderCount;
  UserModel({
    required this.id,
    required this.email,
    //required this.password,
    required this.phone,
    required this.name,
    required this.orderCount
});
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
        name: json["f_name"],
        orderCount: json["order_count"]);
  }
}