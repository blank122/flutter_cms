import 'package:flutter/material.dart';
import 'package:flutter_cms/screens/utility_screen/themes/create_themes_view.dart';
import 'package:flutter_cms/screens/utility_screen/theme_card.dart';
import 'package:flutter_cms/services/db/database_helper.dart';
import 'package:flutter_cms/widget/custom_app_bar.dart';
import 'package:flutter_cms/widget/something_went_wrong.dart';

class ThemesView extends StatefulWidget {
  final Color appBarColor;
  const ThemesView({super.key, required this.appBarColor});

  @override
  State<ThemesView> createState() => _ThemesViewState();
}

class _ThemesViewState extends State<ThemesView> {
  List<Map<String, dynamic>> themesData = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadThemes();
  }

  Future<void> loadThemes() async {
    try {
      final surveys = await DatabaseHelper().getThemes(1);
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
                  child: SomethingWentWrong(
                      title: "No Theme found.",
                      description:
                          "Please Create a Theme First"), //change into no created system themes
                )
              : ListView.builder(
                  itemCount: themesData.length,
                  itemBuilder: (context, index) {
                    final survey = themesData[index];
                    final String themeName = survey['theme_name'];
                    final int status = survey['status'];
                    final String createdAt = survey['created_at'];
                    final String updatedAt = survey['updated_at'];

                    return ThemeCard(
                      themeName: themeName,
                      status: status,
                      createdAt: createdAt,
                      updatedAt: updatedAt,
                      themeID: survey['id'],
                      isSystemTheme: false,
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
                  CreateThemesView(appbarColor: widget.appBarColor),
            ),
          );
        },
        tooltip: 'Add New Theme',
        child: const Icon(Icons.add),
      ),
    );
  }
}
