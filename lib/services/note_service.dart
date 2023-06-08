import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:note_taker/constants/api_auth.dart';
import 'package:note_taker/models/note_model.dart';
import 'package:note_taker/services/auth_service.dart';

import '../models/api_response.dart';
import 'package:get/get.dart';

import '../screens/auth/login_screen.dart';

//consume api untuk note
class NoteService {
  Future<ApiResponse> store(String title, String content) async {
    final ApiResponse apiResponse = ApiResponse();
    final String token = await (AuthService()).getToken();

    final response = await http.post(
      Uri.parse(noteUrl),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
      body: {"title": title, "content": content},
    ).onError(
      (error, stackTrace) {
        return http.Response(
            jsonEncode("Tolong Cek koneksi internet kamu ya : ("), 400);
      },
    );

    switch (response.statusCode) {
      case 201:
        apiResponse.data =
            NoteModel.fromJson(json.decode(response.body)["data"]);
        break;
      case 422:
        apiResponse.error = json.decode(response.body)['message'];
        break;
      case 401:
        Get.offAllNamed(LoginScreen.routeName);
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

    return apiResponse;
  }

  Future<ApiResponse> destroy(int id) async {
    final ApiResponse apiResponse = ApiResponse();
    final String token = await (AuthService()).getToken();

    final response = await http.delete(
      Uri.parse("$noteUrl/$id"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    ).onError(
      (error, stackTrace) {
        return http.Response(
            jsonEncode("Tolong Cek koneksi internet kamu ya : ("), 400);
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body)['message'];
        break;
      case 422:
        apiResponse.error = json.decode(response.body)['message'];
        break;
      case 401:
        Get.offAllNamed(LoginScreen.routeName);
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

    return apiResponse;
  }

  Future<ApiResponse> update(int id, String title, String content) async {
    final ApiResponse apiResponse = ApiResponse();
    final String token = await (AuthService()).getToken();

    final response = await http.patch(Uri.parse("$noteUrl/$id"), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    }, body: {
      'title': title,
      'content': content,
    }).onError(
      (error, stackTrace) {
        return http.Response(
            jsonEncode("Tolong Cek koneksi internet kamu ya : ("), 400);
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body)['message'];
        break;
      case 422:
        apiResponse.error = json.decode(response.body)['message'];
        break;
      case 401:
        Get.offAllNamed(LoginScreen.routeName);
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

    return apiResponse;
  }

  Future<ApiResponse> getAll() async {
    final ApiResponse apiResponse = ApiResponse();
    final String token = await (AuthService()).getToken();

    final response = await http.get(
      Uri.parse(noteUrl),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    ).onError(
      (error, stackTrace) {
        return http.Response(
            jsonEncode("Tolong Cek koneksi internet kamu ya : ("), 400);
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body)['data'] as List<dynamic>;
        break;
      case 422:
        apiResponse.error = json.decode(response.body)['message'];
        break;
      case 401:
        Get.offAllNamed(LoginScreen.routeName);
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

    return apiResponse;
  }
}
