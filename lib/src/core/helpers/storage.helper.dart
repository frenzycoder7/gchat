import 'package:gchat/src/common/authentication/model/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static final StorageHelper instance = StorageHelper._internal();

  factory StorageHelper() {
    return instance;
  }
  StorageHelper._internal();

  MUser? _user;
  String? _token;

  MUser? get user => _user;
  String? get token => _token;

  String userImage() {
    if (_user == null) return 'NOT_FOUND';
    return _user!.image;
  }

  Future<void> saveToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token);
    _token = token;
  }

  void setUser(MUser user) {
    _user = user;
  }

  void removeUser() {
    _user = null;
  }

  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _token = preferences.getString('token');
    return preferences.getString('token') ?? 'NOT_FOUND';
  }

  Future<void> removeToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('token');
    _token = null;
  }

  Future<void> saveNextResendTime() async {
    DateTime time = DateTime.now().add(const Duration(minutes: 2));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('nextResendTime', time.millisecondsSinceEpoch);
  }

  Future<DateTime?> getNextResendTime() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? time = preferences.getInt('nextResendTime');
    if (time == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(time);
  }

  Future<void> removeNextResendTime() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('nextResendTime');
  }
}
