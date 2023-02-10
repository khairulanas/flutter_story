import 'package:flutter/material.dart';
import 'package:flutter_story/src/core/common/result_state.dart';
import 'package:flutter_story/src/core/data/repository.dart';
import 'package:flutter_story/src/core/domain/entities/story_entity.dart';

class StoryDetailProvider with ChangeNotifier {
  final Repository repository;
  final String id;

  StoryDetailProvider(this.repository, this.id) {
    getStoryList(id);
  }

  ResultState state = ResultState.loading;
  late StoryEnity story;
  String errMessage = '';

  Future<void> getStoryList(String id) async {
    state = ResultState.loading;
    notifyListeners();

    final res = await repository.getStoryById(id);
    res.fold((l) {
      state = ResultState.error;
      errMessage = l.message;
    }, (r) {
      state = ResultState.sucess;
      story = r;
    });
    notifyListeners();
  }
}
