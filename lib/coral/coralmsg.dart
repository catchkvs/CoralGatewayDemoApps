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

class SyncDataMsg {
  String SessionId;
  String AuthToken;
  String DataKey;
  String DataValue;
  String CollectionName;

  SyncDataMsg({
    this.AuthToken,
    this.SessionId,
    this.DataKey,
    this.DataValue,
    this.CollectionName
  });
  Map<String, dynamic> toJson() {
    return {
      'AuthToken': this.AuthToken,
      'SessionId': this.SessionId,
      'DataKey' : this.DataKey,
      'DataValue': this.DataValue,
      'CollectionName': this.CollectionName
    };
  }

  static SyncDataMsg fromJson(Map<String, dynamic> map) {
    return SyncDataMsg(AuthToken: map['AuthToken'], SessionId: map['SessionId'], DataKey: map['DataKey'],
        DataValue: map['DataValue'], CollectionName: map['CollectionName'] );
  }
}
