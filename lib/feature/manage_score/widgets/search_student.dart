import 'package:flutter/material.dart';

import '../../../core/context/text_styles.dart';
import '../../../core/utils/string.dart';

class SearchStudent extends StatefulWidget {
  const SearchStudent({super.key, this.studentScores});

  final studentScores;

  @override
  State<SearchStudent> createState() => _SearchStudentState();
}

class _SearchStudentState extends State<SearchStudent> {
  final TextEditingController _findNameController = TextEditingController();

  void _showSearchResult(String name) {
    double? score = widget.studentScores[name.toLowerCase()];
    String searchResult = '';
    setState(() {
      if (score != null) {
        searchResult = '${capitalizeFirstLetter(name)} has a score of $score';
      } else {
        searchResult = 'Student not found';
      }
    });

    _showAlert(context, 'Search student score', searchResult);
  }

  void _showAlert(BuildContext context, String title, String result) {
    var okButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {});
      },
      child: Text(
        "Close",
        style: AppTextStyle.buttonText(context),
      ),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: AppTextStyle.title(context),
          ),
          content: Text(
            result,
            style: AppTextStyle.content(context),
          ),
          actions: [okButton],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black45,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: _findNameController,
              maxLength: 30,
              decoration: const InputDecoration(
                hintText: 'Search for a student',
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _showSearchResult(_findNameController.text);
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
