class Event {

  int id;
  String name;
  String date;
  String image;

  Event({this.id, this.name, this.date, this.image});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'image': image
    };
  }

  static Event fromMap(Map<String, dynamic> map) {
   
    return Event(
      id: map['id'],
      name: map['name'],
      date: map['date'],
      image: map['image']
    );
  }
}