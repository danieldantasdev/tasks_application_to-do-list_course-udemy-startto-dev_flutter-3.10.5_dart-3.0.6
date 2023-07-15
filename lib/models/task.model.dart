class Task {
  String title;
  bool ok;

  Task({required this.title, required this.ok});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      ok: json['ok'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'ok': ok,
    };
  }
}
