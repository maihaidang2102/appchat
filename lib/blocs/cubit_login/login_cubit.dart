// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chat/api_service/authentication.dart';
import 'package:chat/api_service/socket_manager.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()
      : super(const LoginState(
          registeredSocket: false,
          loggedIn: false,
          role: -1,
        )) {
    _socketManager.addMessageListener((data) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final userID = prefs.getString('userID');

        if (userID != null &&
            data
                .toString()
                .contains("Đăng ký thành công cho user: $userID")) {
          log("Received from WebSocket: $data");

          emit(LoginState(
              registeredSocket: true, loggedIn: true, role: state.role));
        }
      } catch (e) {
        log("======================= Error LOGIN ===================");

        log(e.toString());
      }
    });
  }
  final _socketManager = SocketManager.instance;

  Future<void> checkAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userID');
    await prefs.remove('userRole');
    await prefs.remove('groupID');
    final userID = prefs.getString('userID');
    final userRole = prefs.getInt('userRole')?.toInt();

    if (userID != null) {
      log(userID);
      _socketManager.register(userID);
      emit(
          LoginState(registeredSocket: false, loggedIn: true, role: userRole!));
    } else {
      // Nếu userID là null, tiến hành gửi API đăng nhập
      final apiService = ApiServiceAuthentication();
      const userIP = '1.2.3.4.5';

      try {
        final userResponse = await apiService.loginUser(userIP);
        final status = userResponse.status ?? false;
        final role = userResponse.data?.role ?? -1;

        if (status == true) {
          prefs.setString('userID', userResponse.data?.id ?? '');
          prefs.setInt('userRole', userResponse.data?.role ?? -1);

          _socketManager.register(userResponse.data!.id!);

          emit(LoginState(registeredSocket: false, loggedIn: true, role: role));
        } else {
          // Xử lý trường hợp API trả về status là false (đăng ký thất bại)
          emit(const LoginState(
              registeredSocket: false, loggedIn: false, role: -1));

          log('Đăng nhập thất bại');
        }
      } catch (e) {
        // Xử lý lỗi từ API
        emit(const LoginState(
            registeredSocket: false, loggedIn: false, role: -1));
        log('Đăng nhập thất bại: $e');
      }
    }
  }

  void registerUser() async {
    final apiService = ApiServiceAuthentication();
    const userIP = '1.2.3.4.1';
    try {
      final prefs = await SharedPreferences.getInstance();
      final userResponse = await apiService.registerUser(userIP);
      final role = userResponse.data?.role ?? -1;
      prefs.setString('userID', userResponse.data?.id ?? '');
      prefs.setInt('userRole', userResponse.data?.role ?? -1);

      _socketManager.register(userResponse.data!.id!);
      emit(LoginState(registeredSocket: false, loggedIn: true, role: role));
    } catch (e) {
      // Xử lý lỗi từ API
      emit(
          const LoginState(registeredSocket: false, loggedIn: false, role: -1));

      log('Đăng ký thất bại: $e');
    }
  }
}
