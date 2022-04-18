import 'package:floor/floor.dart';

@entity
class Code{
  late final String value;
  @PrimaryKey(autoGenerate: true)
  late int? id;
  late final String date;
  late final String formatCode;
  late final String formatData;

  Code(this.id, this.value, this.date, this.formatCode, this.formatData);


  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Code && runtimeType == other.runtimeType
        && id == other.id && value == other.value;
  }
}