class StoryApi {
  static const String _base = "https://story-api.dicoding.dev/v1";
  static const String register = "$_base/register";
  static const String login = "$_base/login";
  static const String addStories = "$_base/stories";
  static const String stories = "$_base/stories";
  static String detailStories(String id) => "$stories/:$id";
}
