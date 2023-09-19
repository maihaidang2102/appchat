import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat/api_service/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat/api_service/socket_manager.dart';
import 'package:equatable/equatable.dart';

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

        log("Received from WebSocket: $data");
        if (data.toString().contains("Đăng ký thành công cho user: 6506781d602511b57ed65b43")) {
          emit(LoginState(registeredSocket: true, loggedIn: true , role: state.role));
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
    final userID = prefs.getString('userID');
    final userRole = prefs.getInt('userRole')?.toInt();

    if (userID != null) {
      log(userID);
      _socketManager.register(userID);
      emit(
          LoginState(registeredSocket: false, loggedIn: true, role: userRole!));
      // if (userRole == 0) {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => const ServerScreen()),
      //   );
      // } else if (userRole == 1) {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => const ClientScreen()),
      //   );
      // } else {
      //   // Xử lý trường hợp khác tùy theo role
      // }
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

          // if (role == 0) {
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(builder: (context) => const ServerScreen()),
          //   );
          // } else if (role == 1) {
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(builder: (context) => const ClientScreen()),
          //   );
          // } else {
          //   // Xử lý trường hợp khác tùy theo role
          // }
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
    const userIP = '1.2.3.9.2';
    try {
      final prefs = await SharedPreferences.getInstance();
      final userResponse = await apiService.registerUser(userIP);
      final role = userResponse.data?.role ?? -1;
      prefs.setString('userID', userResponse.data?.id ?? '');
      prefs.setInt('userRole', userResponse.data?.role ?? -1);

      _socketManager.register(userResponse.data!.id!);
      emit(LoginState(registeredSocket: false, loggedIn: true, role: role));

      // if (role == 0) {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => const ServerScreen()),
      //   );
      // } else if (role == 1) {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => const ClientScreen()),
      //   );
      // } else {
      //   // Xử lý trường hợp khác tùy theo role
      // }
    } catch (e) {
      // Xử lý lỗi từ API
      emit(
          const LoginState(registeredSocket: false, loggedIn: false, role: -1));

      print('Đăng ký thất bại: $e');
    }
  }
}
