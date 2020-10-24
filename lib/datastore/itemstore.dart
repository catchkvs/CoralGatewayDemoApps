
import 'package:coral_gateway_demo_app/coral/queues.dart';
import 'package:coral_gateway_demo_app/model/item.dart';
import 'package:sembast/sembast.dart';

class ItemStore {

  String itemStoreName = "Items";
  var db;
  static ItemStore _instance = ItemStore._internal();

  ItemStore._internal();

  factory ItemStore(var db) {
    _instance.db = db;
    return _instance;
  }
  static ItemStore getInstance() {
    return _instance;
  }

  Future<void> save(Item item) async {
    print("Save the order");
    //print(order.toJson());
    var store = stringMapStoreFactory.store(itemStoreName);
    await store.record(item.id).put(db, item.toJson());
    QueueCommand queueCommand = new QueueCommand(id: item.id, name: "UpdateItem", data: item.id);
    await Queue.getInstance().saveCmd(queueCommand);
  }
}