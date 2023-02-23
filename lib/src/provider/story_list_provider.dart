import 'package:flutter/material.dart';
import 'package:flutter_story/src/core/common/result_state.dart';
import 'package:flutter_story/src/core/data/repository.dart';
import 'package:flutter_story/src/core/domain/entities/story_entity.dart';

class StoryListProvider with ChangeNotifier {
  final Repository repository;

  StoryListProvider(this.repository);

  int? pageItems = 1;
  int sizeItems = 10;

  ResultState state = ResultState.loading;
  List<StoryEnity> listStory = [];
  String errMessage = '';

  Future<void> getStoryList({bool isReset = false}) async {
    if (isReset) {
      pageItems = 1;
    }
    if (pageItems == 1) {
      state = ResultState.loading;
      notifyListeners();
    }
    print("called api");

    final res = await repository.getAllStoriesWithPage(pageItems!);
    res.fold((l) {
      state = ResultState.error;
      errMessage = l.message;
    }, (r) {
      state = ResultState.sucess;
      if (pageItems == 1) {
        listStory.clear();
      }
      listStory.addAll(r);
      listStory.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      print(r.length);
      if (r.length < sizeItems) {
        pageItems = null;
      } else {
        pageItems = pageItems! + 1;
      }
      print(pageItems);
    });

    notifyListeners();
  }
}
