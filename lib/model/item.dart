
import 'package:coral_gateway_demo_app/model/aisle.dart';

class Item {
  String id;
  String name;
  String description;
  String category;
  Aisle aisle;
  String price;

  Item({ this.id, this.name, this.description, this.category, this.aisle, this.price});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name' : this.name,
      'description': this.description,
      'category': this.category,
      'aisle' : this.aisle.toJson(),
      'price' : this.price
    };
  }

  static Item fromJson(Map<String, dynamic> map) {
    return Item(id: map['id'], name: map['name'], description: map['description'], category: map['category'], aisle: map['aisle'], price: map['price']);
  }
}