import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_tutorial/features/todo/domain/entities/todo.dart';
import 'package:todo_tutorial/features/todo/presentation/blocs/todo_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  static const String routeName = '/todo';

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(GetTodosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addTodo(context);
          },
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is InitialState || state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is FailureState) {
              return Center(
                child: Text(state.message),
              );
            }

            return ListView.builder(
              itemCount: (state as SuccessState<List<Todo>>).data.length,
              itemBuilder: (context, index) {
                final todo = state.data[index];

                return ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Icon(
                    todo.isChecked
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _updateTodoTitle(context, todo);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context
                              .read<TodoBloc>()
                              .add(DeleteTodoEvent(id: todo.id));
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    context.read<TodoBloc>().add(
                          UpdateTodoEvent(
                            id: todo.id,
                            isChecked: !todo.isChecked,
                          ),
                        );
                  },
                );
              },
            );
          },
        ));
  }

  void _addTodo(BuildContext context) {
    _controller.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Enter todo title',
            ),
            focusNode: FocusNode()..requestFocus(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context
                    .read<TodoBloc>()
                    .add(AddTodoEvent(title: _controller.text));
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _updateTodoTitle(BuildContext context, Todo todo) {
    _controller.text = todo.title;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Enter todo title',
            ),
            focusNode: FocusNode()..requestFocus(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<TodoBloc>().add(
                      UpdateTodoEvent(
                        id: todo.id,
                        title: _controller.text,
                      ),
                    );
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
