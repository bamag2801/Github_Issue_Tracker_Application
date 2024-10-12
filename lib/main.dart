import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_issue_tracker_app/provider/issue_provider.dart';
import 'package:github_issue_tracker_app/ui/screens/issue_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const GitHubIssueTrackerApp());
}

class GitHubIssueTrackerApp extends StatelessWidget {
  const GitHubIssueTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IssueProvider(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'GitHub Issue Tracker',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: IssueListScreen(),
          );
        },
      ),
    );
  }
}
