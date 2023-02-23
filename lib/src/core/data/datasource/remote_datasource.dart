import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_story/src/core/common/story_api.dart';
import 'package:flutter_story/src/core/data/model/login_response.dart';
import 'package:http/http.dart';

import '../model/common_response.dart';
import '../model/stories_response.dart';

abstract class RemoteDatasource {
  Future<CommonResponse> register({
    required String name,
    required String email,
    required String password,
  });
  Future<LoginResponse> login(String email, String password);
  Future<CommonResponse> addNewStory({
    required String description,
    required List<int> photoBytes,
    required String fileName,
    required String token,
  });
  Future<StoriesResponse> getAllStories(String token);
  Future<StoriesResponse> getAllStoriesWithPage(String token, int page);
  Future<StoryResponse> getStoriesById(String id, String token);
}

class RemoteDatasourceImpl implements RemoteDatasource {
  final Client client;

  RemoteDatasourceImpl(this.client);

  @override
  Future<CommonResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await client.post(Uri.parse(StoryApi.register),
        body: {"name": name, "email": email, "password": password});
    if (res.statusCode != 201) {
      throw Exception(CommonResponse.fromJson(jsonDecode(res.body)).message);
    }
    return CommonResponse.fromJson(jsonDecode(res.body));
  }

  @override
  Future<LoginResponse> login(String email, String password) async {
    final res = await client.post(Uri.parse(StoryApi.login),
        body: {"email": email, "password": password});
    if (res.statusCode != 200) {
      throw Exception(CommonResponse.fromJson(jsonDecode(res.body)).message);
    }

    return LoginResponse.fromJson(jsonDecode(res.body));
  }

  @override
  Future<CommonResponse> addNewStory({
    required String description,
    required List<int> photoBytes,
    required String fileName,
    required String token,
  }) async {
    final request = MultipartRequest("POST", Uri.parse(StoryApi.addStories));

    final multiPartFile = MultipartFile.fromBytes(
      "photo",
      photoBytes,
      filename: fileName,
    );
    final Map<String, String> fields = {
      "description": description,
    };
    final Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token"
    };

    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);

    final StreamedResponse streamedResponse = await request.send();

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);
    if (streamedResponse.statusCode != 201) {
      throw Exception(
          CommonResponse.fromJson(jsonDecode(responseData)).message);
    }
    return CommonResponse.fromJson(jsonDecode(responseData));
  }

  @override
  Future<StoriesResponse> getAllStories(String token) async {
    final res = await client.get(
      Uri.parse(StoryApi.stories),
      headers: {"Authorization": "Bearer $token"},
    );
    if (res.statusCode != 200) {
      throw Exception(CommonResponse.fromJson(jsonDecode(res.body)).message);
    }
    return StoriesResponse.fromJson(jsonDecode(res.body));
  }

  @override
  Future<StoryResponse> getStoriesById(String id, String token) async {
    final res = await client.get(
      Uri.parse(StoryApi.detailStories(id)),
      headers: {"Authorization": "Bearer $token"},
    );
    if (res.statusCode != 200) {
      throw Exception(CommonResponse.fromJson(jsonDecode(res.body)).message);
    }
    return StoryResponse.fromJson(jsonDecode(res.body));
  }

  @override
  Future<StoriesResponse> getAllStoriesWithPage(String token, int page) async {
    final res = await client.get(
      Uri.parse(StoryApi.storiesWithPage(page)),
      headers: {"Authorization": "Bearer $token"},
    );
    if (res.statusCode != 200) {
      throw Exception(CommonResponse.fromJson(jsonDecode(res.body)).message);
    }
    return StoriesResponse.fromJson(jsonDecode(res.body));
  }
}
