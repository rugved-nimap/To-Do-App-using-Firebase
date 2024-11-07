import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/database_services.dart';
import 'package:untitled/todo_model.dart';

class TodoController extends GetxController {
  List<TodoModel> todoList = [];

  final TextEditingController textEditingController = TextEditingController();
  final DatabaseServices _dbServices = DatabaseServices();

  @override
  void onInit() {
    getDataWhenStart();
    super.onInit();
  }

  void getDataWhenStart() async {
    todoList = await _dbServices.readMethod();
    update();
  }

  void createTask() {
    showDialogBox(
      'Add task',
      'Enter Task here',
      'Add',
      () async {
        if (textEditingController.text.toString().isNotEmpty &&
            textEditingController.text.trim().toString() != "") {
          todoList.add(TodoModel(
              id: todoList.length,
              task: textEditingController.text,
              status: false));

          await _dbServices.createMethod(
              todoList.length, textEditingController.text, false);

          update();
        }
        Get.back();
        textEditingController.clear();
      },
    );
  }

  void updateTask(int index) {
    textEditingController.text = todoList[index].task;
    showDialogBox(
      'Update the task',
      'Update the task',
      'Update',
      () async {
        if (textEditingController.text.toString().isNotEmpty &&
            textEditingController.text.trim().toString() != "") {
          todoList[index].task = textEditingController.text.toString();

          await _dbServices.updateMethod(todoList[index].id, 'task',
              textEditingController.text.toString());

          update();
        }
        Get.back();
        textEditingController.clear();
      },
    );
  }

  void changeStatusTask(int index) async {
    todoList[index].status = !todoList[index].status;
    await _dbServices.updateMethod(
        todoList[index].id, 'status', todoList[index].status);
    update();
  }

  void deleteTask(int index) async {
    await _dbServices.deleteMethod(todoList[index].id);
    todoList.removeAt(index);
    update();
  }

  void showDialogBox(
      String title, String hint, String button, VoidCallback todoFunction) {
    Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
      content: TextField(
        keyboardType: TextInputType.multiline,
        controller: textEditingController,
        decoration: InputDecoration(hintText: hint),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: todoFunction,
          style: const ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)))),
              backgroundColor: WidgetStatePropertyAll(Colors.lightGreen)),
          child: Text(button),
        ),
      ],
    );
  }
}
