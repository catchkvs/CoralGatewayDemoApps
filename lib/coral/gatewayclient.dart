
import 'dart:io';

class GatewayClient {

  WebSocket _webSocket;

  GatewayClient._privateConstructor();

  static final GatewayClient _instance = GatewayClient._privateConstructor();

  static GatewayClient getInstance() {
    return _instance;
  }

}

