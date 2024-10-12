import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_issue_tracker_app/provider/issue_provider.dart';
import 'package:github_issue_tracker_app/service/api_services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class IssueListScreen extends StatefulWidget {
  const IssueListScreen({super.key});

  @override
  State<IssueListScreen> createState() => _IssueListScreenState();
}

class _IssueListScreenState extends State<IssueListScreen> {
  final ApiServices _service = ApiServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiServices.fetchIssues();
  }

  @override
  Widget build(BuildContext context) {
    final issueProvider = Provider.of<IssueProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GitHub Issue Tracker',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            width: 330.w,
            height: 50.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.r))),
            child: TextField(
              onChanged: (value) => issueProvider.setRepo(value),
              decoration: InputDecoration(
                  hintText: 'Enter owner/repository',
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  suffixIcon: InkWell(
                      onTap: () async {
                        try {
                          await issueProvider.searchRepo();
                        } catch (e) {
                          _showErrorDialog(context, e.toString());
                        }
                      },
                      child: const Icon(Icons.search))),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  issueProvider.toggleIssues(true);
                  issueProvider.searchRepo();
                },
                child: const Text('Open Issues'),
              ),
              TextButton(
                onPressed: () {
                  issueProvider.toggleIssues(false);
                  issueProvider.searchRepo();
                },
                child: const Text('Closed Issues'),
              ),
            ],
          ),
          issueProvider.isLoading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!scrollInfo.metrics.atEdge &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        issueProvider.loadMoreIssues();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: issueProvider.issues.length + 1,
                      itemBuilder: (context, index) {
                        if (index == issueProvider.issues.length) {
                          return issueProvider.isLoading
                              ? const CircularProgressIndicator()
                              : Container();
                        }
                        final issue = issueProvider.issues[index];
                        print(issue.issueTrackerList![index].title!);
                        print("++++++++");
                        return Container(
                          width: 330,
                          margin: const EdgeInsets.all(10.0),
                          child: Card(
                            child: ListTile(
                              title: Text(
                                issue.issueTrackerList![index].title!,
                                style: TextStyle(color: Colors.pinkAccent),
                              ),
                              subtitle: Text(
                                  'Issue #${issue.issueTrackerList![index].number} by ${issue.issueTrackerList![index].authorAssociation}'),
                              onTap: () {
                                launchUrl(Uri.parse(
                                    'https://github.com/${issueProvider.repo}/issues/${issue.issueTrackerList![index].number}'));
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK')),
            ],
          );
        });
  }
}
