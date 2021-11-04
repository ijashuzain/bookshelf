class Member {
  String id;
  String name;
  String phone;
  String place;
  String type;
  String house;
  String blood;
  String age;
  bool registered;
  String gender;
  String image;

  Member(
      {this.id,
      this.name,
      this.phone,
      this.place,
      this.house,
      this.blood,
      this.type,
      this.registered,
      this.age,
      this.gender,
      this.image});

  Member.fromMap(Map data) {
    this.name = data['name'];
    this.phone = data['phone'];
    this.id = data['id'];
    this.place = data['place'];
    this.registered = data['registered'];
    this.type = data['type'];
    this.house = data['house'];
    this.blood = data['blood'];
    this.age = data['age'];
    this.gender = data['gender'];
    this.image = data['image'];
  }

  toMap() {
    return {
      'name': this.name,
      'phone': this.phone,
      'place': this.place,
      'id': this.id,
      'registered': this.registered,
      'type': this.type,
      'blood': this.blood,
      'house': this.house,
      'age': this.age,
      'gender': this.gender,
      'image':this.image
    };
  }
}
