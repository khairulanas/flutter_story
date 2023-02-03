import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_story/src/core/common/story_api.dart';
import 'package:flutter_story/src/core/data/model/login_response.dart';
import 'package:http/http.dart';

import '../model/register_response.dart';
import '../model/stories_response.dart';

class RemoteDatasource {
  final Client client;

  RemoteDatasource(this.client);

  Future<CommonResponse> register(
      {required String name,
      required String email,
      required String password}) async {
    final res = await client.post(Uri.parse(StoryApi.register),
        body: {"name": name, "email": email, "password": password});

    return CommonResponse.fromJson(jsonDecode(res.body));
  }

  Future<LoginResponse> login(String email, String password) async {
    final res = await client.post(Uri.parse(StoryApi.register),
        body: {"email": email, "password": password});

    return LoginResponse.fromJson(jsonDecode(res.body));
  }

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

    return CommonResponse.fromJson(jsonDecode(responseData));
  }

  Future<StoriesResponse> getAllStories(String token) async {
    final res = await client.get(
      Uri.parse(StoryApi.stories),
      headers: {"Authorization": "Bearer $token"},
    );
    return StoriesResponse.fromJson(jsonDecode(res.body));
  }

  Future<StoryResponse> getStoriesById(String id, String token) async {
    final res = await client.get(
      Uri.parse(StoryApi.detailStories(id)),
      headers: {"Authorization": "Bearer $token"},
    );
    return StoryResponse.fromJson(jsonDecode(res.body));
  }
}
