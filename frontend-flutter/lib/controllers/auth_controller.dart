import 'package:get/get.dart';
import 'package:login_sqflite_getx/services/api_services.dart';
import 'package:login_sqflite_getx/pages/home_page.dart';
import 'package:login_sqflite_getx/pages/login_page.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  final ApiService apiService = ApiService();

  login(String username, String password) async {
    var result = await apiService.login(username, password);
    if (result != null) {
      isLoggedIn.value = true;
      Get.snackbar(
        "Login Successful",
        "Welcome back, $username!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
      );
      Get.offAll(() => HomePage());
    } else {
      Get.snackbar(
        "Login Failed",
        "Invalid username or password",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
    }
  }

  register(String username, String password) async {
    var result = await apiService.register(username, password);
    if (result != null) {
      Get.snackbar(
        "Registration Success",
        "Your account has been created successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
      );
      Get.to(() => LoginPage());
    } else {
      Get.snackbar(
        "Registration Failed",
        "Username might already exist",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
    }
  }
}