
class Aisle {
  String id;
  String name;

  Aisle({ this.id, this.name});

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'name': name
    };
  }

  static Aisle fromJson(Map<String, dynamic> map) {
    return Aisle(id: map['id'], name: map['name']);
  }
}