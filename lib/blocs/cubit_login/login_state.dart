part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    required this.registeredSocket,
    required this.loggedIn,
    required this.role,
  });

  final bool registeredSocket;
  final bool loggedIn;
  final int role;

  @override
  List<Object> get props => [registeredSocket, loggedIn, role];
}
