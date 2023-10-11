

import 'package:weather_app/core/services/preference_service.dart';

class SessionKeys {
  static const String authUserModel = 'authUserModel';
  static const String authToken = 'authToken';
  static const String uses = 'uses';
  static const String views = 'views';
}

class SessionService {
  static final SessionService _instance = SessionService._internal();

  String _token = '';

  final List<String> _uses = [];
  final List<String> _views = [];

  factory SessionService() => _instance;
  SessionService._internal();

  String get token => _token;

  List<String> get uses => _uses;
  List<String> get views => _views;

  Future<void> initialize() async {
    //TODO 123
  
    _token = PreferenceService.getString(SessionKeys.authToken) ?? '';

    _uses.addAll(PreferenceService.getStringList(SessionKeys.uses) ?? []);
    _views.addAll(PreferenceService.getStringList(SessionKeys.views) ?? []);
  }

  // Future<void> setUserModel(UserModel userModel) async {
  //   _userModel = userModel;
  //   await PreferenceService.setString(
  //       SessionKeys.authUserModel, json.encode(userModel.toMap()));
  // }

  // Future<void> updateUserImage(String url) async {
  //   _userModel = _userModel!.copyWith(picture: url);
  //   await PreferenceService.setString(
  //       SessionKeys.authUserModel, json.encode(_userModel!.toMap()));
  // }

  // Future<void> updateUserName(String name) async {
  //   _userModel = _userModel!.copyWith(name: name);
  //   await PreferenceService.setString(
  //       SessionKeys.authUserModel, json.encode(_userModel!.toMap()));
  // }

  Future<void> setToken(String token) async {
    _token = token;
    await PreferenceService.setString(SessionKeys.authToken, _token);
  }

  Future<bool> viewSticker(String hash) async {
    if (!_views.contains(hash)) {
      _views.add(hash);
      await PreferenceService.setStringList(SessionKeys.views, _views);
      return true;
    }
    return false;
  }

  Future<bool> useSticker(int id) async {
    final strId = id.toString();
    if (!_uses.contains(strId)) {
      _uses.add(strId);
      await PreferenceService.setStringList(SessionKeys.uses, _uses);
      return true;
    }
    return false;
  }
}
