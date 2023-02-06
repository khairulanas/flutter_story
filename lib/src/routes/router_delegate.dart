import 'package:flutter/material.dart';

import 'package:flutter_story/src/core/data/repository.dart';
import 'package:flutter_story/src/presentation/screen/add_new_story_screen.dart';
import 'package:flutter_story/src/presentation/screen/login_screen.dart';
import 'package:flutter_story/src/presentation/screen/register_screen.dart';
import 'package:flutter_story/src/presentation/screen/splash_screen.dart';
import 'package:flutter_story/src/presentation/screen/stories_list_screen.dart';
import 'package:flutter_story/src/presentation/screen/story_detail_screen.dart';
import 'package:flutter_story/src/presentation/screen/unknown_screen.dart';
import 'package:flutter_story/src/routes/page_configuration.dart';

class MyRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final Repository repository;

  bool? isUnknown;

  MyRouterDelegate(
    this.repository,
  ) : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() {
    isLoggedIn = repository.isLoggedIn();
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  String? selectedStory;
  bool isCreateNewStrory = false;

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;

  @override
  Widget build(BuildContext context) {
    if (isUnknown == true) {
      historyStack = _unknownStack;
    } else if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }
    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        isRegister = false;
        selectedStory = null;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  PageConfiguration? get currentConfiguration {
    if (isLoggedIn == null) {
      return PageConfiguration.splash();
    } else if (isRegister == true) {
      return PageConfiguration.register();
    } else if (isLoggedIn == false) {
      return PageConfiguration.login();
    } else if (isUnknown == true) {
      return PageConfiguration.unknown();
    } else if (selectedStory == null) {
      return PageConfiguration.home();
    } else if (selectedStory != null) {
      return PageConfiguration.detailStory(selectedStory!);
    } else {
      return null;
    }
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async {
    if (configuration.isUnknownPage) {
      isUnknown = true;
      isRegister = false;
    } else if (configuration.isRegisterPage) {
      isRegister = true;
    } else if (configuration.isHomePage ||
        configuration.isLoginPage ||
        configuration.isSplashPage) {
      isUnknown = false;
      selectedStory = null;
      isRegister = false;
    } else if (configuration.isDetailPage) {
      isUnknown = false;
      isRegister = false;
      selectedStory = configuration.storyId.toString();
    } else {
      debugPrint(' Could not set new route');
    }

    notifyListeners();
  }

  List<Page> get _unknownStack => const [
        MaterialPage(
          key: ValueKey("UnknownPage"),
          child: UnknownScreen(),
        ),
      ];

  List<Page> get _splashStack => const [
        MaterialPage(
          key: ValueKey("SplashScreen"),
          child: SplashScreen(),
        ),
      ];

  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey("LoginPage"),
          child: LoginScreen(
            onLogin: () {
              isLoggedIn = true;
              notifyListeners();
            },
            onRegister: () {
              isRegister = true;
              notifyListeners();
            },
          ),
        ),
        if (isRegister == true)
          MaterialPage(
            key: const ValueKey("RegisterPage"),
            child: RegisterScreen(
              onRegister: () {
                isRegister = false;
                notifyListeners();
              },
              onLogin: () {
                isRegister = false;
                notifyListeners();
              },
            ),
          ),
      ];

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey("StoriesListPage"),
          child: StoriesListScreen(
            // stories: repository,
            onTapped: (String storyId) {
              selectedStory = storyId;
              notifyListeners();
            },
            onLogout: () {
              isLoggedIn = false;
              notifyListeners();
            },
          ),
        ),
        if (selectedStory != null)
          MaterialPage(
            key: ValueKey(selectedStory),
            child: StoryDetailScreen(
              storyId: selectedStory!,
            ),
          ),
        if (isCreateNewStrory)
          MaterialPage(
            key: ValueKey(selectedStory),
            child: const AddNewStoryScreen(),
          ),
      ];
}
