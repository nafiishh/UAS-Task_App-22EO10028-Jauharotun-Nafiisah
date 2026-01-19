import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onChanged; // Callback untuk refresh
  final TaskService taskService = TaskService();

  TaskCard({super.key, required this.task, this.onChanged});

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'Tinggi':
        return Colors.red;
      case 'Sedang':
        return Colors.orange;
      case 'Rendah':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Checkbox(
          value: task.isDone,
          onChanged: (_) async {
            // Gunakan updateStatus dari TaskService
            await taskService.updateStatus(task.id, !task.isDone);
            // Panggil callback untuk refresh UI
            if (onChanged != null) {
              onChanged!();
            }
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration:
                task.isDone ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Deadline: ${DateFormat('dd MMM yyyy').format(task.deadline)}',
            ),
            const SizedBox(height: 2),
            Text(
              'Prioritas: ${task.priority}',
              style: TextStyle(
                color: _priorityColor(task.priority),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            // Konfirmasi sebelum hapus
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Hapus Tugas'),
                content: Text('Yakin ingin menghapus "${task.title}"?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Batal'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Hapus'),
                  ),
                ],
              ),
            );

            if (confirm == true) {
              await taskService.deleteTask(task.id);
              // Panggil callback untuk refresh UI
              if (onChanged != null) {
                onChanged!();
              }
            }
          },
        ),
        onTap: () {
          // Edit task (dipanggil dari HomeScreen)
        },
      ),
    );
  }
}