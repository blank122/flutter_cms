import 'dart:convert';

class ThemeModel {
  String appBarColor;
  String bottomNavColor;
  String drawerColor;
  String themeName;
  int status;
  String createdAt;
  String updatedAt;

  ThemeModel({
    required this.appBarColor,
    required this.bottomNavColor,
    required this.drawerColor,
    required this.themeName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'appBarColor': appBarColor,
      'bottomNavColor': bottomNavColor,
      'drawerColor': drawerColor,
      'themeName': themeName,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ThemeModel.fromMap(Map<String, dynamic> map) {
    return ThemeModel(
      appBarColor: map['appBarColor'] ?? '',
      bottomNavColor: map['bottomNavColor'] ?? '',
      drawerColor: map['drawerColor'] ?? '',
      themeName: map['themeName'] ?? '',
      status: map['status']?.toInt() ?? 0,
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ThemeModel.fromJson(String source) =>
      ThemeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ThemeModel(appBarColor: $appBarColor, bottomNavColor: $bottomNavColor, drawerColor: $drawerColor, themeName: $themeName, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
