import 'package:flutter/material.dart';
import 'package:flutter_story/src/core/common/result_state.dart';
import 'package:flutter_story/src/core/domain/entities/story_entity.dart';
import 'package:flutter_story/src/provider/auth_provider.dart';
import 'package:flutter_story/src/provider/localization_provider.dart';
import 'package:flutter_story/src/provider/story_list_provider.dart';
import 'package:provider/provider.dart';

class StoriesListScreen extends StatefulWidget {
  final Function(String) onTapped;
  final Function() onCreateNewStory;
  final Function() onLogout;

  const StoriesListScreen({
    Key? key,
    required this.onTapped,
    required this.onLogout,
    required this.onCreateNewStory,
  }) : super(key: key);

  @override
  State<StoriesListScreen> createState() => _StoriesListScreenState();
}

class _StoriesListScreenState extends State<StoriesListScreen> {
  @override
  void initState() {
    Future.microtask(() => context.read<AuthProvider>().loadUserData());
    Future.microtask(() => context.read<StoryListProvider>().getStoryList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story App'),
      ),
      drawer: Drawer(
        child: Consumer2<AuthProvider, LocalizationProvider>(
            builder: (_, authProv, localizeProv, __) {
          return ListView(
            children: [
              DrawerHeader(child: Text(authProv.userData.name)),
              ListTile(
                title: const Text("log out"),
                onTap: () async {
                  final isSuccessLogOut = await authProv.logout();
                  if (isSuccessLogOut) {
                    widget.onLogout();
                  }
                },
              )
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onCreateNewStory();
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<StoryListProvider>(
        builder: (_, storyProv, __) {
          final state = storyProv.state;
          if (state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state == ResultState.error) {
            return Center(
              child: Text(storyProv.errMessage),
            );
          }

          List<StoryEnity> stories = storyProv.listStory;
          return ListView.builder(
            itemCount: stories.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                widget.onTapped(stories[index].id);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image.network(
                        stories[index].photoUrl,
                        width: 150,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(stories[index].name),
                            Text(stories[index].createdAt.toString())
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
