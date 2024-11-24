import 'package:fpdart/fpdart.dart';
import 'package:todo_tutorial/core/exceptions/server_exception.dart';
import 'package:todo_tutorial/features/todo/data/data_sources/todo_remote_data_source.dart';
import 'package:todo_tutorial/features/todo/domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource _remoteDataSource;

  TodoRepositoryImpl({
    required TodoRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<ServerException, bool>> addTodo({required String title}) async {
    return run(() async {
      await _remoteDataSource.addTodo(title: title);
      return right(true);
    });
  }

  @override
  Future<Either<ServerException, bool>> deleteTodo({required int id}) {
    return run(() async {
      await _remoteDataSource.deleteTodo(id: id);
      return right(true);
    });
  }

  @override
  Future<Either<ServerException, List<Todo>>> getTodos() {
    return run(() async {
      final todos = await _remoteDataSource.getTodos();
      return right(todos);
    });
  }

  @override
  Future<Either<ServerException, bool>> updateTodo({
    required int id,
    String? title,
    bool? isChecked,
  }) {
    return run(() async {
      await _remoteDataSource.updateTodo(
        id: id,
        title: title,
        isChecked: isChecked,
      );
      return right(true);
    });
  }

  Future<Either<ServerException, T>> run<T>(
    Future<Either<ServerException, T>> Function() function,
  ) async {
    try {
      return await function();
    } on ServerException catch (error) {
      return left(error);
    }
  }
}
