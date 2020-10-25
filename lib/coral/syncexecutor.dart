import 'dart:async';
import 'dart:convert';

import 'package:coral_gateway_demo_app/coral/coralmsg.dart';
import 'package:coral_gateway_demo_app/coral/gatewayclient.dart';
import 'package:coral_gateway_demo_app/coral/queues.dart';
import 'package:sembast/sembast.dart';

class SyncExecutor {

  static Map<String, String> cmdStoreMap;
  static var database;
  static var authToken;
  static GatewayClient client;
  static void initExecutor(var db, String token) {
    database = db;
    authToken = token;
    client = GatewayClient.getInstance();
    cmdStoreMap = new Map();
    cmdStoreMap['UpdateItem'] = 'items';
  }

  static void execute(Timer t) {
    print("Running the command runner");
    drainQueue();
  }

  static void drainQueue() {
    Future<List<QueueCommand>> commandFuture = Queue.getInstance().getAllCmds();
    commandFuture.then((value) =>
    {
      if(value == null) {
        print(" No command to execute")
      } else
        {
          value.forEach((element) {
            print("Processing command: " + element.name);
            print("collection name: " + cmdStoreMap[element.name]);
            Future<DataToSync> dataFuture = getDataToSync(element.data, cmdStoreMap[element.name]);
            dataFuture.then(syncData);
          })
        }
    });
  }

  static void deleteCommand(String id) {
    Queue.getInstance().delete(id);
  }


  static void syncData(DataToSync input) {
    if(input != null) {
      SyncDataMsg msg = new SyncDataMsg(AuthToken: authToken,
          SessionId: client.sessionId,
          CollectionName: input.collectionName,
          DataKey: input.dataKey,
          DataValue: input.dataValue);
      client.sendMessage(jsonEncode(msg.toJson()));
      deleteCommand(input.dataKey);
    }
  }

  static Future<DataToSync> getDataToSync(String id, String dbStoreName) async {
    print("String id: " + id + " Collection name: " + dbStoreName);
    var store = stringMapStoreFactory.store(dbStoreName);
    var record = await store.record(id).getSnapshot(database);
    print(record);
    if(record != null) {
      String dataValue = base64.encode(utf8.encode(jsonEncode(record.value)));
      String collectionName = dbStoreName;
      String dataKey = record.value['id'];
      return new DataToSync(collectionName: collectionName, dataKey: dataKey, dataValue: dataValue);
    } else {
      deleteCommand(id);
    }
  }
}

class DataToSync {
  String collectionName;
  String dataKey;
  String dataValue;

  DataToSync({
    this.collectionName,
    this.dataKey,
    this.dataValue
  });
}