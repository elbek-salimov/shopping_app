import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repo/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final token = await authRepository.login(event.username, event.password);
      emit(LoginSuccess(token));
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }
}
