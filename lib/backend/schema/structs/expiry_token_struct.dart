// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ExpiryTokenStruct extends BaseStruct {
  ExpiryTokenStruct({
    DateTime? expiryTime,
  }) : _expiryTime = expiryTime;

  // "expiryTime" field.
  DateTime? _expiryTime;
  DateTime? get expiryTime => _expiryTime;
  set expiryTime(DateTime? val) => _expiryTime = val;
  bool hasExpiryTime() => _expiryTime != null;

  static ExpiryTokenStruct fromMap(Map<String, dynamic> data) =>
      ExpiryTokenStruct(
        expiryTime: data['expiryTime'] as DateTime?,
      );

  static ExpiryTokenStruct? maybeFromMap(dynamic data) => data is Map
      ? ExpiryTokenStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'expiryTime': _expiryTime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'expiryTime': serializeParam(
          _expiryTime,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static ExpiryTokenStruct fromSerializableMap(Map<String, dynamic> data) =>
      ExpiryTokenStruct(
        expiryTime: deserializeParam(
          data['expiryTime'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'ExpiryTokenStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ExpiryTokenStruct && expiryTime == other.expiryTime;
  }

  @override
  int get hashCode => const ListEquality().hash([expiryTime]);
}

ExpiryTokenStruct createExpiryTokenStruct({
  DateTime? expiryTime,
}) =>
    ExpiryTokenStruct(
      expiryTime: expiryTime,
    );
