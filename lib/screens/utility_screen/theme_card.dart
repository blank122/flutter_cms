import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ThemeCard extends StatelessWidget {
  final String themeName;
  final int status;
  final String createdAt;
  final String updatedAt;
  const ThemeCard(
      {super.key,
      required this.themeName,
      required this.status,
      required this.createdAt,
      required this.updatedAt});

  @override
  Widget build(BuildContext context) {
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
                  status.toString() == '1' ? 'Active' : 'Inactive',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: status.toString() == '1' ? Colors.green : Colors.red,
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
  }
}
