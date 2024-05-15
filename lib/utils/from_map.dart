import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'base_model.dart';

class FromMap {
  static T? _safeJsonOperation<T>(dynamic jsonValue, T Function() operation) {
    try {
      if (jsonValue == null) return null;

      return operation();
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('$e : $jsonValue');
        print(stackTrace);
      }
    }
    return null;
  }

  static String? string(dynamic jsonValue) {
    return _safeJsonOperation<String?>(jsonValue, () => jsonValue as String?);
  }

  static bool? boolean(dynamic jsonValue) {
    return _safeJsonOperation<bool?>(jsonValue, () => jsonValue as bool?);
  }

  static int? integer(dynamic jsonValue) {
    return _safeJsonOperation<int?>(jsonValue, () => jsonValue as int?);
  }

  static double? doubleValue(dynamic jsonValue) {
    return _safeJsonOperation<double?>(jsonValue, () => jsonValue as double?);
  }

  static Model? model<Model extends BaseModel>(
    dynamic jsonValue,
    Model Function(dynamic) fromJsonFunction,
  ) {
    return _safeJsonOperation<Model?>(
      jsonValue,
      () => fromJsonFunction(jsonValue),
    );
  }

  static List<T>? list<T>(dynamic jsonValue) {
    return _safeJsonOperation<List<T>>(
      jsonValue,
      () => List<T>.from(jsonValue),
    );
  }

  static List<Model>? modelList<Model extends BaseModel>(
    dynamic jsonValue,
    Model Function(dynamic) fromJsonFunction,
  ) {
    return _safeJsonOperation<List<Model>?>(
      jsonValue,
      () => List<Model>.from(jsonValue.map((e) => fromJsonFunction(e))),
    );
  }

  static TimeOfDay? timeOfDay(dynamic jsonValue) {
    return _safeJsonOperation<TimeOfDay?>(
      jsonValue,
      () {
        final time = jsonValue.toString().split(':');

        return TimeOfDay(
          hour: int.tryParse(time[0]) ?? 0,
          minute: int.tryParse(time[1]) ?? 0,
        );
      },
    );
  }

  static DateTime? dateTime(dynamic jsonValue) {
    return _safeJsonOperation<DateTime?>(
      jsonValue,
      () => DateTime.tryParse(jsonValue),
    );
  }

  static DateTime? dateTimeFromMilliseconds(dynamic jsonValue) {
    return _safeJsonOperation<DateTime?>(
      jsonValue,
      () => DateTime.fromMillisecondsSinceEpoch(
        jsonValue is int ? jsonValue : int.tryParse(jsonValue) ?? 0,
      ),
    );
  }

  static Enum? enumValue<Enum>(dynamic jsonValue, List<dynamic> values) {
    return _safeJsonOperation(
      jsonValue,
      () => values.firstWhere((e) => e.databaseValue == jsonValue),
    );
  }

  static List<Enum>? enumList<Enum>(dynamic jsonValue, List<dynamic> values) {
    return _safeJsonOperation(
      jsonValue,
      () => List<Enum>.from(
        jsonValue.map((e) => enumValue(e, values)),
      ),
    );
  }
}
