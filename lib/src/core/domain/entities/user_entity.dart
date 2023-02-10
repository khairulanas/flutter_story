import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String id;

  const UserEntity(this.name, this.id);

  @override
  List<Object?> get props => [name, id];
}
