import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable{
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUserEvent extends UserEvent {
  final String token;

  const LoadUserEvent(this.token);

  @override
  List<Object> get props => [token];
}
