import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_merchant/locators/service_locator.dart';
import 'package:flutter_merchant/repositories/auth_repository.dart';

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class Loading extends AuthState {
  const Loading();
}

class Authenticated extends AuthState {
  const Authenticated();
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthenticationError extends AuthState {
  final String error;

  const AuthenticationError(this.error);
  @override
  List<Object?> get props => [error];
}

// Events
class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);
}

class RegistrationRequested extends AuthEvent {
  final String email;
  final String password;

  RegistrationRequested(this.email, this.password);
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = ServiceLocator.get<AuthRepository>();
  AuthBloc() : super(Unauthenticated()) {
    on<LoginRequested>((event, emit) async {
      emit(Loading());
      try {
        await _authRepository.login(
            email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthenticationError(e.toString()));
        emit(Unauthenticated());
      }
    });
    on<RegistrationRequested>((event, emit) async {
      emit(Loading());
      try {
        await _authRepository.register(
            email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthenticationError(e.toString()));
        emit(Unauthenticated());
      }
    });
    on<LogoutRequested>((event, emit) async {
      emit(Loading());
      await _authRepository.logout();
      emit(Unauthenticated());
    });
  }
}
