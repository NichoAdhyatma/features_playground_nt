import '../models/user_model.dart';

const String baseUrl = "https://staging-api-productivity2023.agileteknik.com";

const String loginUrl = "$baseUrl/api/v1/login";
const String registerUrl = "$baseUrl/api/v1/register";
const String userUrl = "$baseUrl/api/v1/user";
const String noteUrl = "$baseUrl/api/v1/user/notes";
const String shareNoteUrl = "https://note-taker-web.vercel.app/show-note/";
const String somethingWentWrong = "Maaf ada masalah server";

User? authUser;


