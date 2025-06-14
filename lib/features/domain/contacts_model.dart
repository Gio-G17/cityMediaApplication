
class ContactsModel{
  final String email;
  final String phoneNb;

  ContactsModel({required this.email,required this.phoneNb});
  factory ContactsModel.fromMap(Map<String,dynamic> map){
    return ContactsModel(
      email: map['email'],
      phoneNb: map['phoneNb'],
    );
  }
}