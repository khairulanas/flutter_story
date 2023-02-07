class PageConfiguration {
  final bool unknown;
  final bool register;
  final bool? loggedIn;
  final String? storyId;
  final bool createStory;

  PageConfiguration.splash()
      : unknown = false,
        register = false,
        loggedIn = null,
        storyId = null,
        createStory = false;

  PageConfiguration.login()
      : unknown = false,
        register = false,
        loggedIn = false,
        storyId = null,
        createStory = false;

  PageConfiguration.register()
      : unknown = false,
        register = true,
        loggedIn = false,
        storyId = null,
        createStory = false;

  PageConfiguration.home()
      : unknown = false,
        register = false,
        loggedIn = true,
        storyId = null,
        createStory = false;

  PageConfiguration.detailStory(String id)
      : unknown = false,
        register = false,
        loggedIn = true,
        storyId = id,
        createStory = false;

  PageConfiguration.createStory()
      : unknown = false,
        register = false,
        loggedIn = true,
        storyId = null,
        createStory = true;

  PageConfiguration.unknown()
      : unknown = true,
        register = false,
        loggedIn = null,
        storyId = null,
        createStory = false;

  bool get isSplashPage => unknown == false && loggedIn == null;
  bool get isLoginPage => unknown == false && loggedIn == false;
  bool get isHomePage =>
      unknown == false &&
      loggedIn == true &&
      storyId == null &&
      createStory == false;
  bool get isDetailPage =>
      unknown == false && loggedIn == true && storyId != null;
  bool get isCreateStoryPage =>
      unknown == false && loggedIn == true && createStory == true;
  bool get isRegisterPage => register == true;
  bool get isUnknownPage => unknown == true;
}
