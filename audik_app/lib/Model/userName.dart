import 'package:hive_flutter/adapters.dart';
part 'userName.g.dart';

@HiveType(typeId: 5)
class nickName {
  @HiveField(0)
  String? name;

  nickName({
    required this.name,
  });
}
