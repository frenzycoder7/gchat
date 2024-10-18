/**
 * {
        "createdAt": "2024-06-16T10:55:50.995Z",
        "updatedAt": "2024-06-16T11:08:00.551Z",
        "last_message": {
            "_id": "666ec790be4c8817b79bb5a6",
            "text": "Hi form self",
            "file": "NOT_FOUND",
            "lat": 0,
            "long": 0,
            "thumbnailUrl": "NOT_FOUND",
            "status": "SENT",
            "date": "2024-06-16",
            "type": "MESSAGE",
            "localId": "123",
            "createdAt": "2024-06-16T11:08:00.493Z"
        },
        "userId": "6668a5f8355214c9b61ece86",
        "convId": "666ec4b6be4c8817b79bb591",
        "user": {
            "_id": "6668a5f8355214c9b61ece86",
            "email": "mohitx1203@gmail.com",
            "name": "Mohit Singh",
            "isOnline": false,
            "last_seen": 1718536134158
        }
    }
 * 
 */
class Conversation {
  String? _userId;
  String? _convId;
  String? _createdAt;
  String? _updatedAt;
  LastMessage? _lastMessage;
  _User? _user;

  String get userId => _userId ?? "NOT_FOUND";
  String get convId => _convId ?? "NOT_FOUND";
  String get createAt => _createdAt ?? "NOT_FOUND";
  String get updateAt => _updatedAt ?? "NOT_FOUND";
  LastMessage get lastMessage => _lastMessage ?? LastMessage.fromJSON({});
  _User get user => _user ?? _User.fromJSON({});

  Conversation.fromJSON(Map<String, dynamic> json) {
    _userId = json['userId'];
    _convId = json['convId'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _lastMessage = LastMessage.fromJSON(json['last_message']);
    _user = _User.fromJSON(json['user']);
  }
}

class _User {
  String? _id;
  String? _email;
  String? _name;
  bool? _isOnline;
  String? _lastSeen;
  String? _image;

  String get id => _id ?? "NOT_FOUND";
  String get userEmail => _email ?? "NOT_FOUND";
  String get userName => _name ?? "NOT_FOUND";
  bool get isOnlineUser => _isOnline ?? false;
  String get lastSeenTime => _lastSeen ?? "NOT_FOUND";
  String get userImage => _image ?? "NOT_FOUND";

  _User.fromJSON(Map<String, dynamic> json) {
    _id = json['_id'];
    _email = json['email'];
    _name = json['name'];
    _isOnline = json['isOnline'];
    _lastSeen = '${json['last_seen']}';
    _image = json['image'];
  }
}

class LastMessage {
  String? _id;
  String? _text;
  String? _file;
  dynamic _lat;
  dynamic _long;
  String? _thumbnailUrl;
  String? _status;
  String? _date;
  String? _type;
  String? _localId;
  String? _createdAt;

  String get id => _id ?? "NOT_FOUND";
  String get messageText => _text ?? "NOT_FOUND";
  String get fileUrl => _file ?? "NOT_FOUND";
  dynamic get latitude => _lat ?? 0;
  dynamic get longitude => _long ?? 0;
  String get thumbnail => _thumbnailUrl ?? "NOT_FOUND";
  String get messageStatus => _status ?? "NOT_FOUND";
  String get messageDate => _date ?? "NOT_FOUND";
  String get messageType => _type ?? "NOT_FOUND";
  String get localMessageId => _localId ?? "NOT_FOUND";
  String get messageCreatedAt => _createdAt ?? "NOT_FOUND";

  LastMessage.fromJSON(Map<String, dynamic> json) {
    _id = json['_id'];
    _text = json['text'];
    _file = json['file'];
    _lat = json['lat'];
    _long = json['long'];
    _thumbnailUrl = json['thumbnailUrl'];
    _status = json['status'];
    _date = json['date'];
    _type = json['type'];
    _localId = json['localId'];
    _createdAt = json['createdAt'];
  }
}
