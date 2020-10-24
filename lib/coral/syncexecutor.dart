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
    cmdStoreMap = {"UpdateItem": "items"};
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
            Future<Map<String, dynamic>> dataFuture = get(element.data, cmdStoreMap[element.name]);
            dataFuture.then(syncData);
          })
        }
    });
  }

  static void syncData(Map<String, dynamic> input) {
    String data = base64.encode(utf8.encode(jsonEncode(input)));
    ClientMsg msg = new ClientMsg(Command: "SyncData", Data: data,  AuthToken: authToken, SessionId: client.sessionId);
    client.sendMessage(jsonEncode(msg.toJson()));
  }

  static Future<Map<String, dynamic>> get(String id, String dbStoreName) async {
    var store = stringMapStoreFactory.store(dbStoreName);
    var record = await store.record(id).getSnapshot(database);
    return record.value;
  }
}