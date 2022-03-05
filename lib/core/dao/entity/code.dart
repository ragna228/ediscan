import 'package:floor/floor.dart';

@entity
class Code{
  late final String value;
  @PrimaryKey(autoGenerate: true)
  late int? id;

  Code(this.id, this.value);


  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Code && runtimeType == other.runtimeType
        && id == other.id && value == other.value;
  }
}