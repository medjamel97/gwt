import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gwt/main.dart';
import 'package:gwt/utils/alert_maker.dart';
import 'package:gwt/utils/style/alert_type.dart';

class BaseController extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<T> callService<T>(Future<T> service) async {
    try {
      setLoading(true);
      return await service;
    } catch (e) {
      AlertMaker.showSimpleAlertDialog(
        context: mainNavigatorKey.currentContext!,
        title: 'Error',
        description: e.toString(),
        alertType: AlertType.danger,
      );
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
