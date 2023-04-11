// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 1)
class Person {
  Person({
    required this.name,
    required this.age,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  // @HiveField(2)
  // List<Person> friends;
}
