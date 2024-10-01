import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/models/user_profile_model.dart';
import '../../repositories/user_repo/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<LoadUserEvent>(_onLoadUserEvent);
  }

  Future<void> _onLoadUserEvent(
      LoadUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final UserProfileModel userInfo = await userRepository.getUserInfo(event.token);
      emit(UserLoaded(userInfo));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }
}
