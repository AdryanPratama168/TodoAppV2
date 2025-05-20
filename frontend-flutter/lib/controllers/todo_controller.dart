import 'package:get/get.dart';
import 'package:login_sqflite_getx/models/task.dart';
import 'package:login_sqflite_getx/services/api_services.dart';

class TodoController extends GetxController {
  var tasks = <Task>[].obs;
  var isLoading = false.obs;
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    isLoading.value = true;
    try {
      final taskList = await apiService.fetchTasks();
      tasks.value = taskList;
    } catch (e) {
      print('Error fetching tasks: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addTask(Task task) async {
    isLoading.value = true;
    try {
      final id = await apiService.createTask(task.toMap());
      if (id > 0) {
        task.id = id;
        tasks.add(task);
        return true;
      }
      return false;
    } catch (e) {
      print('Error adding task: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateTask(Task task) async {
    isLoading.value = true;
    try {
      final result = await apiService.updateTask(task.id!, task.toMap());
      if (result > 0) {
        final index = tasks.indexWhere((element) => element.id == task.id);
        if (index != -1) {
          tasks[index] = task;
        }
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating task: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteTask(int id) async {
    isLoading.value = true;
    try {
      final result = await apiService.deleteTask(id);
      if (result > 0) {
        tasks.removeWhere((task) => task.id == id);
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting task: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}