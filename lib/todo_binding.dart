import 'package:get/get.dart';
import 'package:untitled/todo_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => TodoController(),
    );
  }
}
