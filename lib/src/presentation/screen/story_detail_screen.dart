import 'package:flutter/material.dart';
import 'package:flutter_story/main.dart';
import 'package:flutter_story/src/core/common/result_state.dart';
import 'package:flutter_story/src/core/data/datasource/local_datasource.dart';
import 'package:flutter_story/src/core/data/datasource/remote_datasource.dart';
import 'package:flutter_story/src/core/data/repository.dart';
import 'package:flutter_story/src/provider/story_detail_provider.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class StoryDetailScreen extends StatelessWidget {
  final String storyId;
  const StoryDetailScreen({super.key, required this.storyId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StoryDetailProvider>(
      create: (_) => StoryDetailProvider(
          RepositoryImpl(
            RemoteDatasourceImpl(Client()),
            LocalDatasourceImpl(preferences),
          ),
          storyId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Consumer<StoryDetailProvider>(builder: (_, prov, __) {
          final state = prov.state;
          if (state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state == ResultState.error) {
            return Center(
              child: Text(prov.errMessage),
            );
          }
          return Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Image.network(prov.story.photoUrl),
                (prov.story.lat != null && prov.story.lon != null)
                    ? Row(
                        children: [
                          Expanded(child: Text(prov.story.lat.toString())),
                          Expanded(child: Text(prov.story.lon.toString())),
                        ],
                      )
                    : const SizedBox(),
                Text(prov.story.name),
                Text(prov.story.description),
              ],
            ),
          );
        }),
      ),
    );
  }
}
