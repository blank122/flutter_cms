import 'package:flutter/material.dart';
import 'package:flutter_cms/screens/create_themes_view.dart';
import 'package:flutter_cms/services/db/database_helper.dart';
import 'package:flutter_cms/widget/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

class ThemesView extends StatefulWidget {
  const ThemesView({super.key});

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
      appBar: const CustomAppBar(title: "Utility View"),
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
                    final String themeName = survey['theme_name'];
                    final int status = survey['status'];
                    final String createdAt = survey['created_at'];
                    final String updatedAt = survey['updated_at'];

                    return SizedBox(
                      child: Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 4,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          child: Padding(
                            padding: EdgeInsets.all(16.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Theme name: $themeName',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  status.toString() == '1'
                                      ? 'Active'
                                      : 'Inactive',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: status.toString() == '1'
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  'Created at: $createdAt',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  'Updated at: $updatedAt',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to CreateThemesView
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateThemesView()),
          );
        },
        tooltip: 'Add New Theme',
        child: const Icon(Icons.add),
      ),
    );
  }
}
