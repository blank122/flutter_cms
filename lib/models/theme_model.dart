import 'dart:convert';

class ThemeModel {
  String appBarColor;
  String bottomNavColor;
  String drawerColor;
  String themeName;
  ThemeModel({
    required this.appBarColor,
    required this.bottomNavColor,
    required this.drawerColor,
    required this.themeName,
  });

  Map<String, dynamic> toMap() {
    return {
      'appBarColor': appBarColor,
      'bottomNavColor': bottomNavColor,
      'drawerColor': drawerColor,
      'themeName': themeName,
    };
  }

  factory ThemeModel.fromMap(Map<String, dynamic> map) {
    return ThemeModel(
      appBarColor: map['appBarColor'] ?? '',
      bottomNavColor: map['bottomNavColor'] ?? '',
      drawerColor: map['drawerColor'] ?? '',
      themeName: map['themeName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ThemeModel.fromJson(String source) =>
      ThemeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ThemeModel(appBarColor: $appBarColor, bottomNavColor: $bottomNavColor, drawerColor: $drawerColor, themeName: $themeName)';
  }
}
