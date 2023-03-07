import 'package:flutter/material.dart';

import 'package:flutter_story/src/core/common/date_format.dart';
import 'package:flutter_story/src/core/common/localization.dart';
import 'package:flutter_story/src/core/common/result_state.dart';
import 'package:flutter_story/src/core/common/shared_p.dart';
import 'package:flutter_story/src/core/data/datasource/local_datasource.dart';
import 'package:flutter_story/src/core/data/datasource/remote_datasource.dart';
import 'package:flutter_story/src/core/data/repository.dart';
import 'package:flutter_story/src/presentation/widget/maps_widget.dart';
import 'package:flutter_story/src/presentation/widget/loading_animation_widget.dart';
import 'package:flutter_story/src/provider/story_detail_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'package:geocoding/geocoding.dart' as geo;

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
          title: Text(AppLocalizations.of(context)!.storyDetail),
        ),
        body: Consumer<StoryDetailProvider>(builder: (_, prov, __) {
          final state = prov.state;
          if (state == ResultState.loading) {
            return const LoadingAnimationWidget();
          } else if (state == ResultState.error) {
            return Center(
              child: Text(prov.errMessage),
            );
          }

          final story = prov.story;
          return DetailSection(
              imageUrl: story.photoUrl,
              name: story.name,
              description: story.description,
              date: dateFormat(context, story.createdAt),
              longitude: story.lon,
              latitude: story.lat);
        }),
      ),
    );
  }
}

class DetailSection extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String description;
  final String date;
  final double? longitude;
  final double? latitude;

  const DetailSection({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.date,
    required this.longitude,
    required this.latitude,
  });

  @override
  State<DetailSection> createState() => _DetailSectionState();
}

class _DetailSectionState extends State<DetailSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SlideTransition(
              position: _offsetAnimation,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.date,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 8),
                    (widget.latitude == null)
                        ? const SizedBox()
                        : FutureBuilder(
                            future: geo.placemarkFromCoordinates(
                                widget.latitude!, widget.longitude!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                final place = snapshot.data![0];
                                final street = place.street!;
                                final address =
                                    '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                                return Text(
                                  "${AppLocalizations.of(context)!.location} : $street, $address",
                                );
                              }
                              return const CircularProgressIndicator();
                            }),
                    const SizedBox(height: 8),
                    (widget.latitude != null && widget.longitude != null)
                        ? MapsWidget(
                            latLng: LatLng(widget.latitude!, widget.longitude!),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
