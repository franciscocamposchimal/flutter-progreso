class Reports {
  List<Report> items = new List();
  Reports();
  Reports.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final fixItem = item['data'];
      fixItem['id'] = item['id'];
      final report = new Report.fromJsonMap(fixItem);
      items.add(report);
    }
  }
}

class Report {
  String id;
  String photoUrl;
  String ubication;
  String description;

  Report({
    this.id,
    this.photoUrl,
    this.ubication,
    this.description,
  });

  Report.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    photoUrl = json["photoUrl"];
    ubication = json["ubication"];
    description = json["description"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "photoUrl": photoUrl,
        "ubication": ubication,
        "description": description,
  };
}
