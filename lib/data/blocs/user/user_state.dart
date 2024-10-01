import 'package:equatable/equatable.dart';
import 'package:shopping_app/data/models/user_profile_model.dart';

abstract class UserState extends Equatable{
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserProfileModel userInfo;

  const UserLoaded(this.userInfo);

  @override
  List<Object> get props => [userInfo];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}
