import 'package:flutter/material.dart';
import 'package:flutter_story/main.dart';
import 'package:flutter_story/src/core/data/datasource/local_datasource.dart';
import 'package:flutter_story/src/core/data/datasource/remote_datasource.dart';
import 'package:flutter_story/src/core/data/repository.dart';
import 'package:flutter_story/src/routes/route_information_parser.dart';
import 'package:flutter_story/src/routes/router_delegate.dart';
import 'package:http/http.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: MyRouteInformationParser(),
      routerDelegate: MyRouterDelegate(
        RepositoryImpl(
          RemoteDatasourceImpl(Client()),
          LocalDatasourceImpl(preferences),
        ),
      ),
    );
  }
}
