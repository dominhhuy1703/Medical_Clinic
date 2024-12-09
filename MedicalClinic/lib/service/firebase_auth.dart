import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Đăng ký người dùng mới
  Future<User?> signUp({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      // Gửi email xác thực khi đăng ký thành công
      await sendVerificationEmail(user);
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception('Đăng ký thất bại: ${e.message}');
    }
  }

  // Đăng nhập người dùng
  Future<User?> signIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception('Đăng nhập thất bại: ${e.message}');
    }
  }

  // Gửi lại email xác thực
  Future<void> sendVerificationEmail(User? user) async {
    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
      } catch (e) {
        throw Exception('Gửi email xác thực thất bại: $e');
      }
    }
  }

  // Kiểm tra trạng thái xác thực email
  Future<bool> isEmailVerified() async {
    User? user = _auth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  // Đăng xuất người dùng
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Lấy thông tin người dùng hiện tại
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Kiểm tra xem người dùng đã đăng nhập hay chưa
  bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }

  // Đăng nhập qua Google (Có thể mở rộng nếu muốn hỗ trợ các phương thức khác)
  Future<User?> signInWithGoogle() async {
    try {
      // Thực hiện đăng nhập qua Google
      // Cần thêm cài đặt cho đăng nhập Google nếu sử dụng
      return null;
    } catch (e) {
      throw Exception('Đăng nhập qua Google thất bại: $e');
    }
  }
}
