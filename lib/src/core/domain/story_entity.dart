import 'package:equatable/equatable.dart';

class StoryEnity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final DateTime createdAt;
  final double? lat;
  final double? lon;

  const StoryEnity(this.id, this.name, this.description, this.photoUrl,
      this.createdAt, this.lat, this.lon);

  @override
  List<Object?> get props =>
      [id, name, description, photoUrl, createdAt, lat, lon];
}
