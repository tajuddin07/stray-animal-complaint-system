class Users {
  String id;
  String address;
  String email;
  String name;
  String password;
  String phoneNo;
  String role;

  Users({this.id, this.address,this .name,this.password,this.email,this.phoneNo,this.role});


  Users.fromJson(Map<String,dynamic>json) :
        id = json['_id'],
        name = json['_name'],
        email = json['_email'],
        address = json['_address'],
        password = json['_password'],
        phoneNo = json['_phoneNo'],
        role = json['_role'];

  Map<String,dynamic> toJson()=>
     {
      "id": id,
       "Name":name,
      "Email": email,
      "Address" : address,
      "Password" : password,
      "Phone Number" : phoneNo,
      "Role" : role,
    };
  }
}