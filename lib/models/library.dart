class Library {
  String id;
  String email;
  String name;
  String phone;
  String place;

  Library(
      {this.email,
      this.id,
      this.name,
      this.phone,
      this.place,
      });

  Library.fromMap(Map data) {
    this.email = data['email'];
    this.name = data['name'];
    this.phone = data['phone'];
    this.id = data['id'];
    this.place = data['place'];
  }

  toMap() {
    return {
      'email': this.email,
      'name': this.name,
      'phone': this.phone,
      'place': this.place,
      'id':this.id
    };
  }
}
