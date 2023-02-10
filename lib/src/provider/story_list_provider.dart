import 'package:flutter/material.dart';
import 'package:flutter_story/src/core/common/result_state.dart';
import 'package:flutter_story/src/core/data/repository.dart';
import 'package:flutter_story/src/core/domain/entities/story_entity.dart';

class StoryListProvider with ChangeNotifier {
  final Repository repository;

  StoryListProvider(this.repository);

  ResultState state = ResultState.loading;
  List<StoryEnity> listStory = [];
  String errMessage = '';

  Future<void> getStoryList() async {
    state = ResultState.loading;
    notifyListeners();

    final res = await repository.getAllStories();
    res.fold((l) {
      state = ResultState.error;
      errMessage = l.message;
    }, (r) {
      state = ResultState.sucess;
      listStory = r;
      listStory.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });

    notifyListeners();
  }
}
