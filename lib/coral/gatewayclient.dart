
import 'dart:convert';
import 'dart:io';

import 'package:coral_gateway_demo_app/coral/coralmsg.dart';

class GatewayClient {
  String GATEWAY_URL = "ws://192.168.0.23:3030/sync-db";
  WebSocket _webSocket;
  String sessionId;
  bool isConnected;
  bool inSession;
  String authToken;
  GatewayClient._privateConstructor();

  static final GatewayClient _instance = GatewayClient._privateConstructor();

  static GatewayClient getInstance() {
    return _instance;
  }

  void connect() {
    print("Connecting a new connection: ");
    Future<WebSocket> future = WebSocket.connect(GATEWAY_URL);
    future.then(setWebsocket);
  }

  String getSessionId() {
    return this.sessionId;
  }

  void setWebsocket(WebSocket value) {
    print("Socket connected:::");
    this._webSocket = value;
    this._webSocket.listen(receiveData);
  }

  void receiveData(dynamic data) {
    this.isConnected = true;
    print("Data: " + data.toString());
    var serverMsg = ServerMsg.fromJson(jsonDecode(data));
    print("Session ID: " + serverMsg.SessionId);
    this.sessionId = serverMsg.SessionId;
    // Handler other logic based on other server commands
  }

  void sendMessage(dynamic data) {
    print("Sending data: " + data.toString());
    _webSocket.add(data);
  }
}

