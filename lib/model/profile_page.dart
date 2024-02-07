class Users {
  String uid;
  String name;
  String email;
  String? photoURL;
  String street;
  String city;
  String nearby;

  Users(
      {required this.uid,
      required this.name,
      required this.email,
      required this.street,
      required this.city,
      required this.nearby,
      this.photoURL});
}
