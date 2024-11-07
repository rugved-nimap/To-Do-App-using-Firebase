import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/todo_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple.shade200,
            title: const Text('Firebase'),
            titleTextStyle: const TextStyle(
                color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
          ),
          body: ListView.builder(
            itemCount: controller.todoList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple.shade50),
                child: Row(
                  children: [
                    controller.todoList[index].status
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.check_circle_outline),
                          )
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.circle_outlined),
                          ),
                    Expanded(child: Text(controller.todoList[index].task)),
                    PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'update') {
                          controller.updateTask(index);
                        } else if (value == 'completed' ||
                            value == 'not_completed') {
                          controller.changeStatusTask(index);
                        } else if (value == 'delete') {
                          controller.deleteTask(index);
                        }
                      },
                      itemBuilder: (context) {
                        return <PopupMenuEntry<String>>[
                          const PopupMenuItem(
                              value: 'update', child: Text('Update')),
                          !controller.todoList[index].status
                              ? const PopupMenuItem(
                                  value: 'completed', child: Text('Completed'))
                              : const PopupMenuItem(
                                  value: 'not_completed',
                                  child: Text('Not-Completed')),
                          const PopupMenuItem(
                              value: 'delete', child: Text('Delete')),
                        ];
                      },
                    )
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.createTask();
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
