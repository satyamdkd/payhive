import 'package:flutter/material.dart';
import 'package:payhive/utils/screen_size.dart';
import 'package:payhive/utils/theme/apptheme.dart';

class AppBottomSheet {
  static kImagePickerBottomSheet(
    BuildContext context, {
    VoidCallback? onCameraTap,
    VoidCallback? onGalleryTap,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _Popover(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: onCameraTap,
                    child: Container(
                      width: 110,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: appColors.primaryLight.withOpacity(0.4),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt_rounded,
                              size: 40, color: appColors.primaryLight),
                          SizedBox(height: height / 70),
                          Text(
                            "Camera",
                            style: theme.textTheme.bodyLarge?.copyWith(
                                color: appColors.primaryLight,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onGalleryTap,
                    child: Container(
                      width: 110,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: appColors.primaryLight.withOpacity(0.4),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.photo_rounded,
                              size: 40, color: appColors.primaryLight),
                          SizedBox(height: height / 70),
                          Text(
                            "Gallery",
                            style: theme.textTheme.bodyLarge?.copyWith(
                                color: appColors.primaryLight,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 30),
            ],
          ),
        );
      },
    );
  }

  static kDefaultBottomSheet(BuildContext context, {Widget? body}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return _Popover(
          child: body,
        );
      },
    );
  }
}

class _Popover extends StatelessWidget {
  const _Popover({this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        margin: EdgeInsets.all(height / 20),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_buildHandle(context), if (child != null) child!],
        ),
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      widthFactor: 0.25,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: theme.dividerColor,
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }
}

class BottomSheetForFilter {
  static kImagePickerBottomSheet(
    BuildContext context, {
    VoidCallback? onCameraTap,
    VoidCallback? onGalleryTap,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _Popover(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height / 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: onCameraTap,
                    child: Container(
                      width: 110,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: appColors.primaryColor.withOpacity(0.4),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt_rounded,
                              size: 40, color: appColors.primaryDark),
                          SizedBox(height: height / 70),
                          Text(
                            "Camera",
                            style: theme.textTheme.bodyLarge?.copyWith(
                                color: appColors.primaryDark,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onGalleryTap,
                    child: Container(
                      width: 110,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: appColors.primaryColor.withOpacity(0.4),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.photo_rounded,
                              size: 40, color: appColors.primaryDark),
                          SizedBox(height: height / 70),
                          Text(
                            "Gallery",
                            style: theme.textTheme.bodyLarge?.copyWith(
                                color: appColors.primaryDark,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 10),
            ],
          ),
        );
      },
    );
  }

  static kDefaultBottomSheet(BuildContext context, {Widget? body}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return _Popover(
          child: body,
        );
      },
    );
  }
}
