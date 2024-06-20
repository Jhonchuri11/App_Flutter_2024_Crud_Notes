class StudentFields {
  static const List<String> values = [
    id,
    name,
    carrera,
    edad,
    createdTime,
  ];
  static const String tableName = 'student';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';
  static const String id = '_id';
  static const String name = 'name';
  static const String carrera = 'carrera';
  static const String edad = 'edad';
  static const String createdTime = 'created_time';
}

class StudentModel {
  int? id;
  final String? name;
  final String? carrera;
  final int? edad;
  final DateTime? createdTime;
  StudentModel({
    this.id,
    this.name,
    this.carrera,
    this.edad,
    this.createdTime,
  });
  Map<String, Object?> toJson() => {
        StudentFields.id: id,
        StudentFields.name: name,
        StudentFields.carrera: carrera,
        StudentFields.edad: edad,
        StudentFields.createdTime: createdTime?.toIso8601String(),
      };

  factory StudentModel.fromJson(Map<String, Object?> json) => StudentModel(
        id: json[StudentFields.id] as int?,
        name: json[StudentFields.name] as String,
        carrera: json[StudentFields.carrera] as String,
        edad: json[StudentFields.edad] as int,
        createdTime:
            DateTime.tryParse(json[StudentFields.createdTime] as String? ?? ''),
      );

  StudentModel copy({
    int? id,
    String? name,
    String? carrera,
    int? edad,
    DateTime? createdTime,
  }) =>
      StudentModel(
        id: id ?? this.id,
        name: name ?? this.name,
        carrera: carrera ?? this.carrera,
        edad: edad ?? this.edad,
        createdTime: createdTime ?? this.createdTime,
      );
}
