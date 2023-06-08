import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:note_taker/constants/api_auth.dart';
import 'package:note_taker/models/api_response.dart';
import 'package:note_taker/models/user_model.dart';
import 'package:note_taker/screens/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AuthService {
  Future<ApiResponse> login(String email, String password) async {
    final ApiResponse apiResponse = ApiResponse();

    try {
      final response = await http.post(Uri.parse(loginUrl), headers: {
        'Accept': 'application/json'
      }, body: {
        'email': email,
        'password': password,
      }).onError(
        (error, stackTrace) {
          return http.Response(jsonEncode("Cek koneksi internet kamu"), 400);
        },
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = User.fromJson(json.decode(response.body)["data"]);
          authUser = apiResponse.data as User;
          break;
        case 422:
          apiResponse.error = "Maaf Email atau Password salah";
          break;
        case 403:
          apiResponse.error = json.decode(response.body)['message'];
          break;
        case 400:
          apiResponse.error = json.decode(response.body);
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      rethrow;
    }

    return apiResponse;
  }

  Future<ApiResponse> register(
      String name, String email, String password) async {
    final ApiResponse apiResponse = ApiResponse();

    try {
      final response = await http.post(Uri.parse(registerUrl), headers: {
        'Accept': 'application/json'
      }, body: {
        'name': name,
        'email': email,
        'password': password,
      }).onError(
        (error, stackTrace) {
          return http.Response(
              jsonEncode("Tolong Cek koneksi internet kamu ya : ("), 400);
        },
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = User.fromJson(json.decode(response.body)["data"]);
          authUser = apiResponse.data as User;
          break;
        case 422:
          apiResponse.error = json.decode(response.body)['message'];
          break;
        case 403:
          apiResponse.error = json.decode(response.body)['message'];
          break;
        case 400:
          apiResponse.error = json.decode(response.body);
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      rethrow;
    }

    return apiResponse;
  }

  Future<ApiResponse> getUser() async {
    final ApiResponse apiResponse = ApiResponse();

    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse(userUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ).onError(
        (error, stackTrace) {
          return http.Response(
              jsonEncode("Tolong Cek koneksi internet kamu ya : ("), 400);
        },
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = User.fromJson(json.decode(response.body)["data"]);
          authUser = apiResponse.data as User;
          break;
        case 401:
          Get.offAllNamed(LoginScreen.routeName);
          break;
        case 422:
          apiResponse.error = json.decode(response.body)['message'];
          break;
        case 403:
          apiResponse.error = json.decode(response.body)['message'];
          break;
        case 400:
          apiResponse.error = json.decode(response.body);
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      rethrow;
    }

    return apiResponse;
  }

  Future<ApiResponse> updateUser(String name) async {
    final ApiResponse apiResponse = ApiResponse();

    try {
      String token = await getToken();
      final response = await http.patch(Uri.parse(userUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        'name': name
      }).onError(
        (error, stackTrace) {
          return http.Response(
              jsonEncode("Tolong Cek koneksi internet kamu ya : ("), 400);
        },
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = User.fromJson(json.decode(response.body)["data"]);
          authUser = apiResponse.data as User;
          break;
        case 401:
          Get.offAllNamed(LoginScreen.routeName);
          break;
        case 422:
          apiResponse.error = json.decode(response.body)['message'];
          break;
        case 403:
          apiResponse.error = json.decode(response.body)['message'];
          break;
        case 400:
          apiResponse.error = json.decode(response.body);
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      rethrow;
    }

    return apiResponse;
  }

  Future<void> setToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
  }

  Future<void> setUserId(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('id', id);
  }

  Future<void> setUserIdWithToken(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('id', user.id!);
    pref.setString('token', user.token!);
  }

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token') ?? '';
  }

  Future<int> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('userId') ?? 0;
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('token');
    pref.remove('id');
  }
}
