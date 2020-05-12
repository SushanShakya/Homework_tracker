class LastUpdated {
  String lastUpdated;
  String id;

  LastUpdated({
    this.lastUpdated
  });

  LastUpdated.fromJson(Map<String, dynamic> json, String id)
      : lastUpdated = json["last_updated"],
        id = id;

  Map<String, dynamic> toJson() => {
        "last_updated": lastUpdated,
      };
}
