import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptask/features/auth/domain/entities/user_entity.dart';
import 'package:uptask/features/auth/domain/usecases/check_login_status.dart';
import 'package:uptask/features/auth/domain/usecases/login_user.dart';
import '../../domain/usecases/logout_user.dart';
import '../../domain/usecases/register_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final CheckLoginStatus checkLoginStatus;
  final LogoutUser logoutUser;

  AuthBloc({
    required this.loginUser,
    required this.registerUser,
    required this.checkLoginStatus,
    required this.logoutUser,
  }) : super(AuthInitial()) {
    // Register event handlers
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<CheckLoginStatusEvent>(_onCheckLoginStatusEvent);
    on<LogoutEvent>(_onLogoutEvent);

    add(CheckLoginStatusEvent());
  }

  // Handler for LoginEvent
  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUser(event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Handler for RegisterEvent
  Future<void> _onRegisterEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await registerUser(event.email, event.password, event.name);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Handler for LogoutEvent
  Future<void> _onLogoutEvent(
      LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await logoutUser();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Handler for CheckLoginStatusEvent
  Future<void> _onCheckLoginStatusEvent(
      CheckLoginStatusEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final isLoggedIn = await checkLoginStatus();
      if (isLoggedIn) {
        emit(AuthSuccess(UserEntity(
            email: "test@example.com", name: "User", id: '8947589')));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
