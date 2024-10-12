class IssueTrackerModel {
  List<IssueTrackerList>? issueTrackerList;

  IssueTrackerModel({this.issueTrackerList});

  IssueTrackerModel.fromJson(List jsonList) {
    print(jsonList);
    print("bbbbb");
    issueTrackerList = (jsonList as List<dynamic>?)
        ?.map((e) => IssueTrackerList.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class IssueTrackerList {
  String? url;
  String? repoUrl;
  String? labelUrl;
  String? commentsUrl;
  String? eventsUrl;
  String? htmlUrl;
  int? id;
  String? nodeId;
  int? number;
  String? title;
  UserData? userData;
  List<LabelsData>? labelsData;
  String? state;
  bool? locked;
  String? createdData;
  String? updatedData;
  String? authorAssociation;

  IssueTrackerList(
      {this.url,
      this.repoUrl,
      this.labelUrl,
      this.commentsUrl,
      this.eventsUrl,
      this.htmlUrl,
      this.id,
      this.nodeId,
      this.number,
      this.title,
      this.userData,
      this.labelsData,
      this.state,
      this.locked,
      this.createdData,
      this.updatedData,
      this.authorAssociation});

  IssueTrackerList.fromJson(Map<String, dynamic> json) {
    url = json["url"] ?? "";
    repoUrl = json["repository_url"] ?? "";
    labelUrl = json["labels_url"] ?? "";
    commentsUrl = json["comments_url"] ?? "";
    eventsUrl = json["events_url"] ?? "";
    htmlUrl = json["html_url"] ?? "";
    id = json["id"] ?? 0;
    nodeId = json["node_id"] ?? "";
    number = json["number"] ?? 0;
    title = json["title"] ?? "";
    userData =
        json["user"] != null ? UserData.fromJson(json["user"] ?? {}) : null;
    if (json["labels"] != null) {
      labelsData = <LabelsData>[];
      json["labels"].forEach((element) {
        labelsData!.add(LabelsData.fromJson(element));
      });
    }
    state = json["state"] ?? "";
    locked = json["locked"] ?? false;
    createdData = json["created_at"] ?? "";
    updatedData = json["updated_at"] ?? "";
  }
}

class UserData {
  String? login;
  int? id;
  String? noteId;
  String? avatarUrl;
  String? gravatarId;
  String? url;
  String? htmlUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? starredUrl;
  String? subscriptionUrl;
  String? organizationsUrl;
  String? reposUrl;
  String? eventsUrl;
  String? receivedEventsUrl;
  String? type;
  bool? siteAdmin;

  UserData(
      {this.login,
      this.id,
      this.noteId,
      this.avatarUrl,
      this.gravatarId,
      this.url,
      this.htmlUrl,
      this.followersUrl,
      this.followingUrl,
      this.gistsUrl,
      this.starredUrl,
      this.subscriptionUrl,
      this.organizationsUrl,
      this.reposUrl,
      this.eventsUrl,
      this.receivedEventsUrl,
      this.type,
      this.siteAdmin});

  UserData.fromJson(Map<String, dynamic> json) {
    login = json["login"] ?? "";
    id = json["id"] ?? 0;
    noteId = json["node_id"] ?? "";
    avatarUrl = json["avatar_url"] ?? "";
    gravatarId = json['gravatar_id'] ?? "";
    url = json["url"] ?? "";
    htmlUrl = json["html_url"] ?? "";
    followersUrl = json["followers_url"] ?? "";
    followingUrl = json["following_url"] ?? "";
    gistsUrl = json["gists_url"] ?? "";
    starredUrl = json["starred_url"] ?? "";
    subscriptionUrl = json["subscriptions_url"] ?? "";
    organizationsUrl = json["organizations_url"] ?? "";
    reposUrl = json["repos_url"] ?? "";
    eventsUrl = json["events_url"] ?? "";
    receivedEventsUrl = json["received_events_url"] ?? "";
    type = json["type"] ?? "";
    siteAdmin = json["site_admin"] ?? false;
  }
}

class LabelsData {
  int? id;
  String? nodeId;
  String? url;
  String? name;
  String? color;
  bool? defaultType;
  String? description;

  LabelsData(
      {this.id,
      this.nodeId,
      this.url,
      this.name,
      this.color,
      this.defaultType,
      this.description});

  LabelsData.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? 0;
    nodeId = json['node_id'] ?? "";
    url = json["url"] ?? "";
    name = json["name"] ?? "";
    color = json["color"] ?? "";
    defaultType = json["default"] ?? "";
    description = json["description"] ?? "";
  }
}
