import 'package:flutter/material.dart';
import 'package:flutter_story/main.dart';
import 'package:flutter_story/src/core/data/datasource/local_datasource.dart';
import 'package:flutter_story/src/core/data/datasource/remote_datasource.dart';
import 'package:flutter_story/src/core/data/repository.dart';
import 'package:flutter_story/src/provider/auth_provider.dart';
import 'package:flutter_story/src/provider/localization_provider.dart';
import 'package:flutter_story/src/provider/story_list_provider.dart';
import 'package:flutter_story/src/provider/upload_provider.dart';
import 'package:flutter_story/src/routes/route_information_parser.dart';
import 'package:flutter_story/src/routes/router_delegate.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Repository repository;
  @override
  void initState() {
    repository = RepositoryImpl(
      RemoteDatasourceImpl(Client()),
      LocalDatasourceImpl(preferences),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider(repository)),
        ChangeNotifierProvider(create: (_) => StoryListProvider(repository)),
        ChangeNotifierProvider(create: (_) => UploadProvider(repository)),
      ],
      child: MaterialApp.router(
        routeInformationParser: MyRouteInformationParser(),
        routerDelegate: MyRouterDelegate(repository),
        theme: ThemeData(primaryColor: Colors.black87),
      ),
    );
  }
}
