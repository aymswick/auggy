import 'package:equatable/equatable.dart';

class Player implements Equatable {
  const Player({
    required this.username,
    required this.email,
  });

  final String username;
  final String email;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [username, email];
}
