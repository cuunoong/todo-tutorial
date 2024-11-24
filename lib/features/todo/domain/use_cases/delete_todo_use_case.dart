import 'package:fpdart/fpdart.dart';
import 'package:todo_tutorial/core/exceptions/server_exception.dart';

import '../repositories/todo_repository.dart';

class DeleteTodoUseCase {
  final TodoRepository _repository;

  DeleteTodoUseCase({required TodoRepository repository})
      : _repository = repository;

  Future<Either<ServerException, bool>> call({
    required int id,
  }) async {
    return _repository.deleteTodo(
      id: id,
    );
  }
}
