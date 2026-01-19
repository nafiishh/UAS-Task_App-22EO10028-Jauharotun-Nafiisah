import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task.dart';

class TaskService {
  final SupabaseClient supabase = Supabase.instance.client;

  /// =====================
  /// CREATE TASK
  /// =====================
  Future<void> addTask({
    required String title,
    required String description,
    required DateTime deadline,
    required String priority,
  }) async {
    try {
      debugPrint('=== INSERT TASK ===');

      await supabase.from('tasks').insert({
        'title': title,
        'description': description,
        'deadline': deadline.toIso8601String(),
        'priority': priority,
        'is_done': false,
        'created_at': DateTime.now().toIso8601String(),
      });

      debugPrint('=== INSERT SUCCESS ===');
    } on PostgrestException catch (e) {
      debugPrint('SUPABASE ERROR: ${e.message}');
      throw Exception(e.message);
    } catch (e) {
      debugPrint('UNKNOWN ERROR: $e');
      rethrow;
    }
  }

  /// =====================
  /// READ TASKS
  /// =====================
  Future<List<Task>> getTasks() async {
    try {
      final response =
          await supabase.from('tasks').select().order('deadline');

      return response.map<Task>((e) => Task.fromMap(e)).toList();
    } catch (e) {
      debugPrint('GET TASK ERROR: $e');
      return [];
    }
  }

  /// =====================
  /// UPDATE STATUS
  /// =====================
  Future<void> updateStatus(String id, bool isDone) async {
    await supabase.from('tasks').update({
      'is_done': isDone,
    }).eq('id', id);
  }

  /// =====================
/// UPDATE TASK (EDIT)
/// =====================
Future<void> updateTask(Task task) async {
  await supabase
      .from('tasks')
      .update(task.toMap()) // id TIDAK DIKIRIM
      .eq('id', task.id);
}

  /// =====================
  /// DELETE
  /// =====================
  Future<void> deleteTask(String id) async {
    await supabase.from('tasks').delete().eq('id', id);
  }
}
