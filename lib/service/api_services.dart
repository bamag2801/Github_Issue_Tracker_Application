import 'dart:convert';

import 'package:github_issue_tracker_app/model/issue_tracker_model.dart';
import 'package:dio/dio.dart';

class ApiServices {
  static Future<IssueTrackerModel> fetchIssues() async {
    Response response = await Dio()
        .get('https://api.github.com/repos/flutter/flutter/issues?state=open');
    return IssueTrackerModel.fromJson(response.data);
  }

  static const String baseUrl = 'https://api.github.com/repos';

  Future<List<dynamic>> selectStateIssue(String repo,
      {String state = 'open', int page = 1}) async {
    final response = await Dio()
        .get('$baseUrl/$repo/issues?state=$state&page=$page&per_page=10');

    if (response.statusCode == 200) {
      return json.decode(response.data);
    } else {
      throw Exception('Failed to load issues');
    }
  }
}
