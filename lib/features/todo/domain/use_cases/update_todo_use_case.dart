import 'package:fpdart/fpdart.dart';
import 'package:todo_tutorial/core/exceptions/server_exception.dart';

import '../repositories/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository _repository;

  UpdateTodoUseCase({required TodoRepository repository})
      : _repository = repository;

  Future<Either<ServerException, bool>> call({
    required int id,
    String? title,
    bool? isChecked,
  }) async {
    return _repository.updateTodo(
      id: id,
      title: title,
      isChecked: isChecked,
    );
  }
}
