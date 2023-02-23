import 'package:flutter/material.dart';
import 'package:flutter_story/src/core/common/date_format.dart';
import 'package:flutter_story/src/core/common/localization.dart';
import 'package:flutter_story/src/core/common/result_state.dart';
import 'package:flutter_story/src/core/domain/entities/story_entity.dart';
import 'package:flutter_story/src/presentation/widget/dropdown_language.dart';
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
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<StoryEnity> listItems = [];
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
        child: Consumer<LocalizationProvider>(builder: (_, localizeProv, __) {
          return ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.blueAccent),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.wellcome,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      context.watch<AuthProvider>().userData.name,
                      style:
                          const TextStyle(color: Colors.yellow, fontSize: 15.0),
                    ),
                  ],
                ),
              ),
              ListTile(
                  title: Text(AppLocalizations.of(context)!.changeLanguage),
                  subtitle: const DropdownLanguage()),
              ListTile(
                title: Text(AppLocalizations.of(context)!.logOut),
                onTap: () async {
                  final isSuccessLogOut =
                      await context.read<AuthProvider>().logout();
                  if (isSuccessLogOut) {
                    widget.onLogout();
                  }
                },
              ),
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
          if (stories.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.emptyStoryList),
            );
          }
          var future = Future(() {});
          for (var i = 0; i < stories.length; i++) {
            future = future.then((_) {
              return Future.delayed(const Duration(milliseconds: 100), () {
                listItems.add(stories[i]);
                listKey.currentState!.insertItem(listItems.length - 1);
              });
            });
          }
          return AnimatedList(
            key: listKey,
            initialItemCount: listItems.length,
            itemBuilder: (context, index, animation) {
              final story = listItems[index];
              return ListItemWidget(
                widget: widget,
                story: story,
                animation: animation,
              );
            },
          );
        },
      ),
    );
  }
}

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    super.key,
    required this.widget,
    required this.story,
    required this.animation,
  });

  final StoriesListScreen widget;
  final StoryEnity story;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: InkWell(
        onTap: () {
          widget.onTapped(story.id);
        },
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Image.network(
                  story.photoUrl,
                  width: 150,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported),
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        story.name,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(dateFormat(context, story.createdAt))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
