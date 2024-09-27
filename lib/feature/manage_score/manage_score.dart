import 'package:flutter/material.dart';
import 'package:manage_student_score/core/utils/string.dart';
import 'package:manage_student_score/feature/manage_score/widgets/search_student.dart';

class ManageScore extends StatefulWidget {
  const ManageScore({super.key});

  @override
  State<ManageScore> createState() => _ManageScoreState();
}

class _ManageScoreState extends State<ManageScore> {
  // Khởi tạo Map để lưu tên học sinh và điểm số
  final Map<String, double> studentScores = {
    'john': 85,
    'alice': 92,
    'bob': 75,
    'mary': 88,
    'tom': 79,
  };

  // Hàm thêm điểm cho học sinh mới
  void _addStudent(String name, double score) {
    setState(() {
      studentScores[name] = score;
    });
  }

  void _updateStudent(String name, double score) {
    setState(() {
      studentScores[name] = score;
    });
  }

  void _removeStudent(String name) {
    setState(() {
      studentScores.remove(name);
    });
  }

  void _showInputDialog({
    required Function(String, double) onSubmit,
    String name = '',
    bool isUpdate = false,
  }) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _scoreController = TextEditingController(
      text: '0',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isUpdate ? 'Update $name score' : 'Add Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isUpdate
                ? const SizedBox()
                : TextField(
                    controller: _nameController,
                    decoration:
                        const InputDecoration(labelText: 'Student Name'),
                  ),
            TextField(
              controller: _scoreController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Score',
                hintText: 'Enter a number (0-100)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              String name = _nameController.text;
              double score = double.tryParse(_scoreController.text) ?? 0;
              onSubmit(name, score < 0 || score > 100 ? 0 : score);
              Navigator.of(context).pop();
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Score Manager'),
      ),
      body: Column(
        children: [
          SearchStudent(
            studentScores: studentScores,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: studentScores.length,
              itemBuilder: (context, index) {
                String name = studentScores.keys.elementAt(index);
                double score = studentScores[name]!;
                return ListTile(
                  title: Text('${capitalizeFirstLetter(name)}: $score'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showInputDialog(
                            name: capitalizeFirstLetter(name),
                            isUpdate: true,
                            onSubmit: (_, score) => _updateStudent(name, score),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _removeStudent(name);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _showInputDialog(
                  name: '',
                  onSubmit: (name, score) =>
                      _addStudent(name.toLowerCase(), score),
                );
              },
              child: const Text('Add New Student'),
            ),
          ),
        ],
      ),
    );
  }
}
