import 'package:flutter/material.dart';

import '../core/theme/theme.dart';
import '../feature/manage_score/manage_score.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme().theme(),
      home: ManageScore(),
    );
  }
}
