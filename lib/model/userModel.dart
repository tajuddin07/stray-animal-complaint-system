class Users {
  String id;
  String address;
  String email;
  String name;
  String password;
  String phoneNo;
  String role;

  Users({this.id, this.address,this .name,this.password,this.email,this.phoneNo,this.role});


  Users.fromData( Map<String,dynamic> data)

      : id = data['id'],
        name = data['name'],
        email = data['email'],
        address = data['address'],
        password = data['password'],
        phoneNo = data['phoneNo'],
        role = data['role'];


  Map <String,dynamic> toJson()  {
    return {
      "id": id,
      "Name": name,
      "Email": email,
      "Address": address,
      "Password": password,
      "Phone Number": phoneNo,
      "Role": role,
     };
    }
  }

