import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// import halaman dari folder screens
import 'screens/home_screen.dart';
import 'screens/add_task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://otzczondeqqewmbagwxm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im90emN6b25kZXFxZXdtYmFnd3htIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3Mjg1MTEsImV4cCI6MjA4NDMwNDUxMX0.txq-55K0JZy9_OE_0qXVku9rT7D7oy9mhHLWtPljYjk',
  );

  // Test koneksi
  try {
    print('=== TEST KONEKSI SUPABASE ===');
    final response = await Supabase.instance.client.from('tasks').select().limit(1);
    print('Koneksi berhasil! Response: $response');
  } catch (e) {
    print('Koneksi gagal! Error: $e');
  }

  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // halaman awal
      home: const HomeScreen(),

      // routing antar halaman
      routes: {
        '/add': (context) => const AddTaskScreen(),
      },
    );
  }
}