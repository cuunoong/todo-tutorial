import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_tutorial/core/exceptions/server_exception.dart';
import 'package:todo_tutorial/features/todo/data/models/todo_model.dart';

import 'todo_remote_data_source.dart';

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final SupabaseClient _supabaseClient;

  TodoRemoteDataSourceImpl({
    required SupabaseClient supabaseClient,
  }) : _supabaseClient = supabaseClient;

  @override
  Future<void> addTodo({
    required String title,
  }) async {
    return run(() {
      return _supabaseClient.from('todos').insert({
        'title': title,
      });
    });
  }

  @override
  Future<void> deleteTodo({
    required int id,
  }) async {
    return run(() {
      return _supabaseClient.from('todos').delete().eq('id', id);
    });
  }

  @override
  Future<List<TodoModel>> getTodos() async {
    return run(() async {
      final response = await _supabaseClient
          .from('todos')
          .select()
          .order('is_checked', ascending: true)
          .order('title', ascending: true);

      return TodoModel.fromJsonList(response);
    });
  }

  @override
  Future<void> updateTodo({required int id, String? title, bool? isChecked}) {
    return run(() {
      final data = <String, dynamic>{};
      if (title != null) {
        data['title'] = title;
      }
      if (isChecked != null) {
        data['is_checked'] = isChecked;
      }

      return _supabaseClient.from('todos').update(data).eq('id', id);
    });
  }

  Future<T> run<T>(Future<T> Function() function) async {
    try {
      return await function();
    } on PostgrestException catch (error) {
      throw ServerException(message: error.message);
    } catch (error) {
      throw ServerException(message: error.toString());
    }
  }
}
