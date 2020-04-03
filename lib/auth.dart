import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import './http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(String email, String password, String urlSegment,
      BuildContext context, String displayName) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyB8cQJTMXYTAkAmdXJLpZerjDkimo_xTxw';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );

      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      print("fffffffffffffffffffffffffffffffffffffffff");
      prefs.setString('userData', userData);

      print(_userId);
      if (urlSegment == "signInWithPassword") {
        final idResponse = await http.get('https://disabilty-app.firebaseio.com/accountInfo.json?auth=$_token&orderBy="userId"&equalTo="${userId}"');
        print(json.decode(idResponse.body));
        final dataBaseId = (json.decode(idResponse.body).values.toList())[0]["dataBaseId"];
        print(dataBaseId);
        prefs.setString('dataBaseId', json.encode(dataBaseId));
        _autoLogout();
      }

    } catch (error) {
      throw error;
    }
    if (urlSegment == "signUp") {
      final url = "https://disabilty-app.firebaseio.com/accountInfo.json?auth=$_token";
      var sendData = {
        "userId": userId,
        "displayName": displayName,
        "email": email,
        "password": password,
        "profilePic": "noPicture",
      };
      final response = await http.post(url, body: json.encode(sendData));
      final response2 = json.decode(response.body);
      final id = response2["name"];
      final idurl = "https://disabilty-app.firebaseio.com/accountInfo/$id.json?auth=$_token";
      http.patch(idurl, body: json.encode({"dataBaseId": id}));
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('dataBaseId', json.encode(id));
    }
  }

  Future<void> signup(String email, String password, BuildContext context,
      String displayName) async {
    return _authenticate(email, password, 'signUp', context, displayName);
  }

  Future<void> login(String email, String password,
      BuildContext context) async {
    return _authenticate(email, password, 'signInWithPassword', context, "_");
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')) as Map<
        String,
        dynamic>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate
        .difference(DateTime.now())
        .inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
