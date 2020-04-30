class UserModel {

  // Field
  int id;
  String name, user, password;


  // Method
  UserModel(this.id, this.name, this.user, this.password);


  UserModel.fromJSON(Map<String, dynamic> map){
    id = int.parse(map['id']);
    name = map['Name'];
    user = map['User'];
    password = map['Password'];
  }


  
}