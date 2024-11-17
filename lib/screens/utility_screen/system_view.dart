import 'package:flutter/material.dart';
import 'package:flutter_cms/screens/utility_screen/create_system_theme_view.dart';
import 'package:flutter_cms/screens/utility_screen/theme_card.dart';
import 'package:flutter_cms/services/db/database_helper.dart';
import 'package:flutter_cms/widget/custom_app_bar.dart';

class SystemView extends StatefulWidget {
  final Color appBarColor;
  const SystemView({super.key, required this.appBarColor});

  @override
  State<SystemView> createState() => _SystemViewState();
}

class _SystemViewState extends State<SystemView> {
  List<Map<String, dynamic>> themesData = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadThemes();
  }

  Future<void> loadThemes() async {
    try {
      final surveys = await DatabaseHelper().getSystemThemes(1);
      setState(() {
        themesData = surveys;
        isLoading = false; // Stop loading
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading in case of error
      });
      print('Error loading surveys: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Utility View",
        backgroundColor: widget.appBarColor,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : themesData.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: themesData.length,
                  itemBuilder: (context, index) {
                    final survey = themesData[index];
                    final String themeName = survey['name'];
                    final int status = survey['status'];
                    final String createdAt = survey['created_at'];
                    final String updatedAt = survey['updated_at'];

                    return ThemeCard(
                      themeName: themeName,
                      status: status,
                      createdAt: createdAt,
                      updatedAt: updatedAt,
                      themeID: survey['id'],
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to CreateThemesView
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateSystemThemeView(appbarColor: widget.appBarColor),
            ),
          );
        },
        tooltip: 'Add New Theme',
        child: const Icon(Icons.add),
      ),
    );
  }
}
