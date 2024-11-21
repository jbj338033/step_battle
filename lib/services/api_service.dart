import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/battle.dart';
import '../models/user.dart';

class ApiService {
  static const String baseUrl =
      'https://your-api-domain.com/api'; // 실제 서버 주소로 변경 필요
  final String? authToken;

  ApiService({this.authToken});

  // HTTP 헤더 생성
  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };

  // 인증 관련 API
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: _headers,
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('로그인 실패: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> register(
      String email, String password, String username) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: _headers,
      body: jsonEncode({
        'email': email,
        'password': password,
        'username': username,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('회원가입 실패: ${response.body}');
    }
  }

  // 걸음 수 관련 API
  Future<void> syncSteps(int steps, DateTime date) async {
    final response = await http.post(
      Uri.parse('$baseUrl/steps/sync'),
      headers: _headers,
      body: jsonEncode({
        'steps': steps,
        'date': date.toIso8601String(),
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('걸음 수 동기화 실패: ${response.body}');
    }
  }

  // 배틀 관련 API
  Future<Battle> createBattle() async {
    final response = await http.post(
      Uri.parse('$baseUrl/battles/create'),
      headers: _headers,
    );

    if (response.statusCode == 201) {
      return Battle.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('배틀 생성 실패: ${response.body}');
    }
  }

  Future<Battle> joinBattle(String battleId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/battles/$battleId/join'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return Battle.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('배틀 참가 실패: ${response.body}');
    }
  }

  Future<List<Battle>> getActiveBattles() async {
    final response = await http.get(
      Uri.parse('$baseUrl/battles/active'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> battles = jsonDecode(response.body);
      return battles.map((battle) => Battle.fromJson(battle)).toList();
    } else {
      throw Exception('배틀 목록 조회 실패: ${response.body}');
    }
  }

  // 유저 프로필 관련 API
  Future<User> getUserProfile() async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/profile'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('프로필 조회 실패: ${response.body}');
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> updateData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/profile'),
      headers: _headers,
      body: jsonEncode(updateData),
    );

    if (response.statusCode != 200) {
      throw Exception('프로필 업데이트 실패: ${response.body}');
    }
  }
}
