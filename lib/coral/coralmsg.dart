class ServerMsg {
  String Command;
  String Data;
  String SessionId;

  ServerMsg({
    this.Command,
    this.Data,
    this.SessionId
  });

  Map<String, dynamic> toJson() {
    return {
      'Command': this.Command,
      'Data' : this.Data,
      'SessionId': this.SessionId
    };
  }

  static ServerMsg fromJson(Map<String, dynamic> map) {
    return ServerMsg(Command: map['Command'], Data: map['Data'], SessionId: map['SessionId']);
  }
}

class ClientMsg {
  String Command;
  String SessionId;
  String AuthToken;
  String Data;

  ClientMsg({
    this.Command,
    this.Data,
    this.AuthToken,
    this.SessionId
  });
  Map<String, dynamic> toJson() {
    return {
      'Command': this.Command,
      'Data' : this.Data,
      'AuthToken': this.AuthToken,
      'SessionId': this.SessionId
    };
  }

  static ClientMsg fromJson(Map<String, dynamic> map) {
    return ClientMsg(Command: map['Command'], Data: map['Data'], AuthToken: map['AuthToken'], SessionId: map['SessionId']);
  }
}
