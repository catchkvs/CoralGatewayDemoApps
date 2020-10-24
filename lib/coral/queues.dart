import 'package:sembast/sembast.dart';

class Queue {
  String queueStoreName = "queue";
  var db;
  static final Queue _instance = Queue._internal();

  Queue._internal();

  factory Queue(var db) {
    _instance.db = db;
    return _instance;
  }
  static Queue getInstance() {
    return _instance;
  }

  Future<void> saveCmd(QueueCommand queueCommand) async {
    var now = new DateTime.now();
    queueCommand.creationTime = now.millisecondsSinceEpoch;
    var store = stringMapStoreFactory.store(queueStoreName);
    await store.record(queueCommand.id).put(db, queueCommand.toJson());
  }

  Future<List<QueueCommand>> getAllCmds() async {
    var store = stringMapStoreFactory.store(queueStoreName);
    var records = (await store.find(db,
        finder: Finder()));
    List<QueueCommand> commandList = new List<QueueCommand>();
    for(var i=0;i<records.length;i++){
      commandList.add(QueueCommand.fromJson(records[i].value));
    }
    return commandList;
  }

  Future<void> delete(String id) async {
    var store = stringMapStoreFactory.store(queueStoreName);
    await store.record(id).delete(db);
  }
}


class QueueCommand {
  String id;
  String name;
  String data;
  int creationTime;

  QueueCommand({
    this.id,
    this.name,
    this.data,
    this.creationTime
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'data': this.data,
      'creationTime': this.creationTime
    };
  }

  static QueueCommand fromJson(Map<String, dynamic> json) {
    return QueueCommand(
        id: json['id'] as String,
        name: json['name'] as String,
        data: json['data'] as String,
        creationTime: json['creationTime'] as int
    );
  }
}