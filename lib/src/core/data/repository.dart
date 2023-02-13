import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_story/src/core/common/failure.dart';
import 'package:flutter_story/src/core/data/datasource/local_datasource.dart';
import 'package:flutter_story/src/core/data/datasource/remote_datasource.dart';
import 'package:flutter_story/src/core/data/model/common_response.dart';
import 'package:flutter_story/src/core/domain/entities/story_entity.dart';
import 'package:flutter_story/src/core/domain/entities/user_entity.dart';

abstract class Repository {
  Future<Either<Failure, CommonResponse>> register({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, CommonResponse>> addNewStory({
    required String description,
    required List<int> photoBytes,
    required String fileName,
  });
  Future<Either<Failure, List<StoryEnity>>> getAllStories();
  Future<Either<Failure, StoryEnity>> getStoryById(String id);
  Future<Either<Failure, bool>> logout();
  bool? isLoggedIn();
  Either<Failure, UserEntity> getLoginData();
}

class RepositoryImpl implements Repository {
  final RemoteDatasource remoteDatasource;
  final LocalDatasource localDatasource;

  RepositoryImpl(this.remoteDatasource, this.localDatasource);

  @override
  Future<Either<Failure, CommonResponse>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final resData = await remoteDatasource.register(
        name: name,
        email: email,
        password: password,
      );
      return right(resData);
    } on SocketException {
      return left(Failure("no internet", failurType: FailurType.noInternet));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(
      String email, String password) async {
    try {
      final resData = await remoteDatasource.login(email, password);
      await localDatasource.saveLoginData(resData.loginResult);
      return right(
          UserEntity(resData.loginResult.name, resData.loginResult.userId));
    } on SocketException {
      return left(Failure("no internet", failurType: FailurType.noInternet));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommonResponse>> addNewStory({
    required String description,
    required List<int> photoBytes,
    required String fileName,
  }) async {
    try {
      final token = localDatasource.getToken();
      final resData = await remoteDatasource.addNewStory(
          description: description,
          photoBytes: photoBytes,
          fileName: fileName,
          token: token);
      return right(resData);
    } on SocketException {
      return left(Failure("no internet", failurType: FailurType.noInternet));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StoryEnity>>> getAllStories() async {
    try {
      final token = localDatasource.getToken();
      final res = await remoteDatasource.getAllStories(token);
      return right(res.listStory.map((e) => e.toEntity()).toList());
    } on SocketException {
      return left(Failure("no internet", failurType: FailurType.noInternet));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StoryEnity>> getStoryById(String id) async {
    try {
      final token = localDatasource.getToken();
      final res = await remoteDatasource.getStoriesById(id, token);
      return right(res.story.toEntity());
    } on SocketException {
      return left(Failure("no internet", failurType: FailurType.noInternet));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final isSuccessLogout = await localDatasource.deleteLoginData();
      return right(isSuccessLogout);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  bool? isLoggedIn() {
    return localDatasource.isLoggedIn() ?? false;
  }

  @override
  Either<Failure, UserEntity> getLoginData() {
    try {
      final resData = localDatasource.getLoginData();
      return right(UserEntity(resData.name, resData.userId));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
