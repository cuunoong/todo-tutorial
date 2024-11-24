import 'package:fpdart/fpdart.dart';
import 'package:todo_tutorial/core/exceptions/server_exception.dart';
import 'package:todo_tutorial/features/todo/domain/entities/todo.dart';

abstract interface class TodoRepository {
  Future<Either<ServerException, bool>> addTodo({
    required String title,
  });

  Future<Either<ServerException, bool>> deleteTodo({
    required int id,
  });

  Future<Either<ServerException, List<Todo>>> getTodos();

  Future<Either<ServerException, bool>> updateTodo({
    required int id,
    String? title,
    bool? isChecked,
  });
}
