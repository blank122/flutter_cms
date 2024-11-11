import 'dart:convert';

class ThemeModel {
  String appBarColor;
  String bottomNavColor;
  String drawerColor;
  ThemeModel({
    required this.appBarColor,
    required this.bottomNavColor,
    required this.drawerColor,
  });

  Map<String, dynamic> toMap() {
    return {
      'appBarColor': appBarColor,
      'bottomNavColor': bottomNavColor,
      'drawerColor': drawerColor,
    };
  }

  factory ThemeModel.fromMap(Map<String, dynamic> map) {
    return ThemeModel(
      appBarColor: map['appBarColor'] ?? '',
      bottomNavColor: map['bottomNavColor'] ?? '',
      drawerColor: map['drawerColor'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ThemeModel.fromJson(String source) =>
      ThemeModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ThemeModel(appBarColor: $appBarColor, bottomNavColor: $bottomNavColor, drawerColor: $drawerColor)';
}
