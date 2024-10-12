import 'package:flutter/material.dart';
import 'package:github_issue_tracker_app/model/issue_tracker_model.dart';
import 'package:github_issue_tracker_app/service/api_services.dart';

class IssueProvider extends ChangeNotifier {
  // IssueTrackerModel model = IssueTrackerModel();
  //
  // List<IssueTrackerModel>? issueList;
  //
  // Future getAllIssueData() async {
  //   model = await ApiServices.fetchIssues();
  //   notifyListeners();
  // }
  //
  // Future getSelectStateIssueData(String state) async {
  //   model = await ApiServices.selectStateIssue(state);
  //   notifyListeners();
  // }

  final List<IssueTrackerModel> _issues = [];
  String _repo = '';
  bool _isLoading = false;
  bool _showOpenIssues = true;

  List<IssueTrackerModel> get issues => _issues;

  bool get isLoading => _isLoading;

  String get repo => _repo;

  bool get showOpenIssues => _showOpenIssues;

  void setRepo(String repo) {
    _repo = repo;
    notifyListeners();
  }

  void toggleIssues(bool showOpen) {
    _showOpenIssues = showOpen;
    _issues.clear();
    notifyListeners();
  }

  Future<void> searchRepo() async {
    if (_repo.isNotEmpty) {
      _isLoading = true;
      notifyListeners();
      try {
        await ApiServices.fetchIssues();
      } catch (e) {
        throw e;
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> loadMoreIssues() async {
    if (!_isLoading) {
      _isLoading = true;
      notifyListeners();
      try {
        await ApiServices.fetchIssues();
      } catch (e) {
        throw e;
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}
