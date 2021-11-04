class Book {
  String id;
  String author;
  String title;
  String subtitle;
  String category;
  String language;
  int qty;
  String description;
  String date;
  String image;

  Book(
      {this.id,
      this.author,
      this.title,
      this.subtitle,
      this.category,
      this.language,
      this.qty,
      this.description,
      this.date,
      this.image});

  Book.fromMap(Map data) {
    this.id = data['id'];
    this.author = data['author'];
    this.title = data['title'];
    this.subtitle = data['subtitle'];
    this.category = data['category'];
    this.qty = data['qty'];
    this.description = data['description'];
    this.date = data['date'];
    this.image = data['image'];
    this.language = data['language'];
  }

  toMap() {
    return {
      'id': this.id,
      'author': this.author,
      'title': this.title,
      'subtitle': this.subtitle,
      'category': this.category,
      'qty': this.qty,
      'description': this.description,
      'date': this.date,
      'image':this.image,
      'language' : this.language
    };
  }
}
