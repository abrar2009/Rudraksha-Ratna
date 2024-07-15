// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProductDetailsStruct extends BaseStruct {
  ProductDetailsStruct({
    String? productImage,
    String? productName,
  })  : _productImage = productImage,
        _productName = productName;

  // "ProductImage" field.
  String? _productImage;
  String get productImage => _productImage ?? '';
  set productImage(String? val) => _productImage = val;
  bool hasProductImage() => _productImage != null;

  // "ProductName" field.
  String? _productName;
  String get productName => _productName ?? '';
  set productName(String? val) => _productName = val;
  bool hasProductName() => _productName != null;

  static ProductDetailsStruct fromMap(Map<String, dynamic> data) =>
      ProductDetailsStruct(
        productImage: data['ProductImage'] as String?,
        productName: data['ProductName'] as String?,
      );

  static ProductDetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? ProductDetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'ProductImage': _productImage,
        'ProductName': _productName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'ProductImage': serializeParam(
          _productImage,
          ParamType.String,
        ),
        'ProductName': serializeParam(
          _productName,
          ParamType.String,
        ),
      }.withoutNulls;

  static ProductDetailsStruct fromSerializableMap(Map<String, dynamic> data) =>
      ProductDetailsStruct(
        productImage: deserializeParam(
          data['ProductImage'],
          ParamType.String,
          false,
        ),
        productName: deserializeParam(
          data['ProductName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ProductDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ProductDetailsStruct &&
        productImage == other.productImage &&
        productName == other.productName;
  }

  @override
  int get hashCode => const ListEquality().hash([productImage, productName]);
}

ProductDetailsStruct createProductDetailsStruct({
  String? productImage,
  String? productName,
}) =>
    ProductDetailsStruct(
      productImage: productImage,
      productName: productName,
    );
