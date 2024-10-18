/**
 * {convId: 666ec4b6be4c8817b79bb591, 
 * to: 6668a2c767609b2a6d6154a2, 
 * from: 6668a5f8355214c9b61ece86, 
 * text: ddgggfgdffffddsdfdfs, 
 * file: NOT_FOUND, 
 * lat: 0, 
 * long: 0, 
 * thumbnailUrl: NOT_FOUND, 
 * status: SENT, 
 * date: 2024-06-30, 
 * type: MESSAGE, 
 * localId: 7spzh, 
 * _id: 668197acb4b504bae75329be, 
 * createdAt: 2024-06-30T17:36:44.238Z, 
 * updatedAt: 2024-06-30T17:36:44.238Z, 
 * __v: 0
 * }
 * 
 * {
    "type": "ACK",
    "from": "CONVERSATION",
    "to": "6668a5f8355214c9b61ece86",
    "messageId": "6681acdf0fb19206d7b24f41",
    "messagelocalId": "plwgdh",
    "status": "SENT",
    "conversationId": "666ec4b6be4c8817b79bb591",
    "message": {
        "convId": "666ec4b6be4c8817b79bb591",
        "to": "6668a2c767609b2a6d6154a2",
        "from": "6668a5f8355214c9b61ece86",
        "text": "hello",
        "file": "NOT_FOUND",
        "lat": 0,
        "long": 0,
        "thumbnailUrl": "NOT_FOUND",
        "status": "SENT",
        "date": "2024-06-30",
        "type": "MESSAGE",
        "localId": "plwgdh",
        "_id": "6681acdf0fb19206d7b24f41",
        "createdAt": "2024-06-30T19:07:11.019Z",
        "updatedAt": "2024-06-30T19:07:11.019Z",
        "__v": 0
    },
    "socketId": "MfDYIsp0D4eMOJstAACA",
    "server": "gateway_1"
}
 */

class Message {
  String? _convId;
  String? _to;
  String? _from;
  String? _text;
  String? _file;
  double? _lat;
  double? _long;
  String? _thumbnailUrl;
  String? _status;
  String? _date;
  String? _type;
  String? _localId;
  String? _id;
  String? _createdAt;
  String? _updatedAt;

  String get convId => _convId ?? 'NOT_FOUND';
  String get to => _to ?? 'NOT_FOUND';
  String get from => _from ?? 'NOT_FOUND';
  String get text => _text ?? 'NOT_FOUND';
  String get file => _file ?? 'NOT_FOUND';
  double get lat => _lat ?? 0;
  double get long => _long ?? 0;
  String get thumbnailUrl => _thumbnailUrl ?? 'NOT_FOUND';
  String get status => _status ?? 'NOT_FOUND';
  String get date => _date ?? 'NOT_FOUND';
  String get type => _type ?? 'NOT_FOUND';
  String get localId => _localId ?? 'NOT_FOUND';
  String get id => _id ?? 'NOT_FOUND';
  String get createdAt => _createdAt ?? 'NOT_FOUND';
  String get updatedAt => _updatedAt ?? 'NOT_FOUND';

  Message.fromJSON(Map<String, dynamic> json) {
    _convId = json['convId'];
    _to = json['to'];
    _from = json['from'];
    _text = json['text'];
    _file = json['file'];
    _lat = double.parse('${json['lat']}');
    _long = double.parse('${json['long']}');
    _thumbnailUrl = json['thumbnailUrl'];
    _status = json['status'];
    _date = json['date'];
    _type = json['type'];
    _localId = json['localId'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
}
