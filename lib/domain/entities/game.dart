import 'package:cloud_firestore/cloud_firestore.dart';

class Game {
  Game({
    this.id = '',
    this.title = '',
    this.platform = '',
    this.completed = 0,
  });

  String id;
  String title;
  String platform;
  int completed;

  bool get validGame => title.isNotEmpty && title.isNotEmpty && platform.isNotEmpty;

  factory Game.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data() ?? {};
    data['id'] = snapshot.id;
    return Game.fromMap(data);
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id'] as String,
      title: map['title'] as String,
      platform: map['platform'] as String,
      completed: map['completed'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'platform': platform,
      'completed': completed,
    };
  }

  @override
  toString() {
    return 'Game(id: $id, title: $title, platform: $platform, completed: $completed)';
  }
}