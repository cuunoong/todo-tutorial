import 'package:fpdart/fpdart.dart';
import 'package:todo_tutorial/core/exceptions/server_exception.dart';
import 'package:todo_tutorial/features/todo/domain/entities/todo.dart';

import '../repositories/todo_repository.dart';

class GetTodosUseCase {
  final TodoRepository _repository;

  GetTodosUseCase({required TodoRepository repository})
      : _repository = repository;

  Future<Either<ServerException, List<Todo>>> call() async {
    return _repository.getTodos();
  }
}
