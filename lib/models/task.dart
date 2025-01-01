import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Task({
    this.id = Isar.autoIncrement,
    required this.name,
  });

  Id id;
  String name;
}
