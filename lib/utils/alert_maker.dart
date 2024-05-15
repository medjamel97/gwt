import 'package:flutter/material.dart';
import 'package:gwt/utils/style/alert_type.dart';
import 'package:gwt/utils/style/app_theme.dart';
import 'package:gwt/utils/style/dimensions.dart';

class AlertMaker {
  static void showSimpleAlertDialog({
    required BuildContext context,
    required String title,
    required String description,
    required AlertType alertType,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomDialogBox(
          title: title,
          description: description,
          alertType: alertType,
        );
      },
    );
  }

  static void showSingleActionAlertDialog({
    required BuildContext context,
    required String title,
    required String description,
    required AlertType alertType,
    required VoidCallback? action,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomDialogBox(
          title: title,
          description: description,
          alertType: alertType,
          positiveAction: action,
        );
      },
    );
  }

  static Future<void> showActionAlertDialog({
    required BuildContext context,
    required String title,
    required String description,
    required AlertType alertType,
    required VoidCallback? positiveAction,
    required VoidCallback? negativeAction,
    required String positiveActionTitle,
    required String negativeActionTitle,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomDialogBox(
          title: title,
          description: description,
          alertType: alertType,
          positiveAction: positiveAction,
          negativeAction: negativeAction,
          positiveActionTitle: positiveActionTitle,
          negativeActionTitle: negativeActionTitle,
        );
      },
    );
  }

  static Future<void> showWidgetAlertDialog({
    required BuildContext context,
    required AlertType alertType,
    VoidCallback? negativeAction,
    VoidCallback? positiveAction,
    String? negativeActionTitle,
    String? positiveActionTitle,
    required Widget widget,
    bool hasDefaultButtons = true,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomDialogBox(
          alertType: alertType,
          negativeAction: negativeAction,
          positiveAction: positiveAction,
          negativeActionTitle: negativeActionTitle,
          positiveActionTitle: positiveActionTitle,
          widget: widget,
          hasDefaultButtons: hasDefaultButtons,
        );
      },
    );
  }

  static void notImplementedYet({
    required BuildContext context,
  }) {
    showSimpleAlertDialog(
      context: context,
      title: "Information" /* TODO */,
      description: "Not implemented yet" /* TODO */,
      alertType: AlertType.information,
    );
  }
}

class CustomDialogBox extends StatelessWidget {
  final String? title;
  final String? description;
  final AlertType alertType;
  final VoidCallback? positiveAction;
  final VoidCallback? negativeAction;
  final String? positiveActionTitle;
  final String? negativeActionTitle;
  final Widget? widget;
  final bool hasDefaultButtons;

  const CustomDialogBox({
    super.key,
    this.title,
    this.description,
    required this.alertType,
    this.positiveAction,
    this.negativeAction,
    this.positiveActionTitle,
    this.negativeActionTitle,
    this.widget,
    this.hasDefaultButtons = true,
  });

  // --------------------------- BUILD METHODS -----------------------------  //

  @override
  Widget build(BuildContext context) {
    late IconData icon;
    late Color mainColor;

    switch (alertType) {
      case AlertType.success:
        mainColor = Colors.greenAccent /* TODO */;
        icon = Icons.check_circle;
        break;
      case AlertType.information:
        mainColor = Colors.lightBlueAccent /* TODO */;
        icon = Icons.info;
        break;
      case AlertType.warning:
        mainColor = Colors.orangeAccent /* TODO */;
        icon = Icons.warning;
        break;
      case AlertType.danger:
        mainColor = Colors.redAccent /* TODO */;
        icon = Icons.error;
        break;
    }

    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: Dimensions.largeBorderRadius,
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight: screenHeight * 0.9,
        ),
        padding: Dimensions.paddingExtraLarge,
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor.withOpacity(0.95),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget ??
                Column(
                  children: [
                    Icon(icon, size: 75, color: mainColor),
                    Dimensions.heightHuge,
                    Text(
                      title ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                    Dimensions.heightHuge,
                    Text(description ?? ''),
                    Dimensions.heightHuge,
                  ],
                ),
            if (hasDefaultButtons)
              Row(
                children: [
                  if (positiveAction == null && negativeAction == null)
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(mainColor),
                          foregroundColor: const MaterialStatePropertyAll(
                            Colors.white,
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              side: BorderSide(
                                color: mainColor,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: Dimensions.largeBorderRadius,
                            ),
                          ),
                        ),
                        child: const Text(
                          "OK" /* TODO */,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  if (positiveAction != null && negativeAction != null)
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                if (negativeAction != null) {
                                  negativeAction!();
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  AppTheme.backgroundColor,
                                ),
                                foregroundColor: const MaterialStatePropertyAll(
                                  Colors.white,
                                ),
                              ),
                              child: Text(
                                negativeActionTitle ?? "No" /* TODO */,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppTheme.textColor,
                                ),
                              ),
                            ),
                          ),
                          Dimensions.widthLarge,
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                if (positiveAction != null) {
                                  positiveAction!();
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  mainColor,
                                ),
                                foregroundColor: const MaterialStatePropertyAll(
                                  Colors.white,
                                ),
                              ),
                              child: Text(
                                positiveActionTitle ?? "Yes" /* TODO */,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (positiveAction != null && negativeAction == null)
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (positiveAction != null) positiveAction!();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            mainColor.withOpacity(0.2),
                          ),
                          foregroundColor: MaterialStatePropertyAll(
                            mainColor,
                          ),
                        ),
                        child: const Text(
                          "Proceed" /* TODO */,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  if (positiveAction == null && negativeAction != null)
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (negativeAction != null) negativeAction!();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            mainColor.withOpacity(0.2),
                          ),
                          foregroundColor: MaterialStatePropertyAll(
                            mainColor,
                          ),
                        ),
                        child: Text(
                          negativeActionTitle ?? "Cancel" /* TODO */,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
