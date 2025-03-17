class Topic {
  String id;
  String name;
  int votes;

  Topic({required this.id, required this.name, required this.votes});

  factory Topic.fromMap(Map<String, dynamic> obj) =>
      Topic(id: obj['id'], name: obj['name'], votes: obj['votes']);
}
