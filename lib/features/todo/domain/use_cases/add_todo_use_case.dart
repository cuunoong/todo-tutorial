import 'package:fpdart/fpdart.dart';
import 'package:todo_tutorial/core/exceptions/server_exception.dart';

import '../repositories/todo_repository.dart';

class AddTodoUseCase {
  final TodoRepository _repository;

  AddTodoUseCase({required TodoRepository repository})
      : _repository = repository;

  Future<Either<ServerException, bool>> call({
    required String title,
  }) async {
    return _repository.addTodo(
      title: title,
    );
  }
}
