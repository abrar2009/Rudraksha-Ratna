import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';
export 'api_manager.dart' show ApiCallResponse;
import 'package:http/http.dart' as http;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/*class ExploreCategoryListCall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'ExploreCategoryList',
      apiUrl: '${sanityurl}/otherproductmaster/web-explore-category-list',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? categoryNames(dynamic response) => (getJsonField(
    response,
    r'''$.categorydata[:].category''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
  static List<String>? productName(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].productname''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
  static List<int>? sellingPrice(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].selling_price''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  static List<int>? categoryId(dynamic response) => (getJsonField(
    response,
    r'''$.categorydata[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
}*/


class ExploreCategoryListCall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
  }) async {
    final apiUrl = '${sanityurl}/otherproductmaster/web-explore-category-list';
    log('Making API call to: $apiUrl'); // Log the API URL

    try {
      final response = await ApiManager.instance.makeApiCall(
        callName: 'ExploreCategoryList',
        apiUrl: apiUrl,
        callType: ApiCallType.GET,
        headers: {},
        params: {},
        returnBody: true,
        bodyType: BodyType.JSON,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        alwaysAllowBody: false,
      );
      log('API response: ${response.jsonBody}'); // Log the response
      return response;
    } catch (e) {
      log('Error during API call: $e'); // Log any errors
      rethrow;
    }
  }

  static List<String>? categoryNames(dynamic response) => (getJsonField(
    response,
    r'''$.categorydata[:].category''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();

  static List<String>? productName(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].productname''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();

  static List<int>? sellingPrice(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].selling_price''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();

  static List<int>? categoryId(dynamic response) => (getJsonField(
    response,
    r'''$.categorydata[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
}


class ExploreProductsCall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
    String? id = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'ExploreProducts',
      apiUrl: '${sanityurl}/otherproductmaster/web-explore-category',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'id': id,
      },
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? productslugvalue(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].slug_value''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class LoginWithOTPCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? mobileNumber = '',
    String? countryCode = '',
    String? hosturl = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'LoginWithOTP',
      apiUrl: '${hosturl}/customermaster/login-send-otp',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'email': email,
        'mobile_number': mobileNumber != null ? mobileNumber : '',
        'country_code': countryCode != null ? countryCode : '',
      },
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class LoginCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? email = '',
    String? emailotp = '',
    String? mobilenumber = '',
    String? mobileotp = '',
    String? countryCode = '',
    String? fcmToken = '',
    String source = 'app'
  }) async {
    final ffApiRequestBody = '''
{
    "email": "${email}",
    "emailotp": "${emailotp}",
    "mobilenumber": "${mobilenumber}",
    "mobileotp": "${mobileotp}",
    "country_code": "${countryCode}",
    "hosturl": "${hosturl}",
    "fcm_token": "${fcmToken}",
    "source": "${source}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Login',
      apiUrl: '${hosturl}/customermaster/login',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body:ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic? jwt(dynamic response) => getJsonField(
        response,
        r'''$.token''',
      );
  static String? uid(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.id''',
      ));
  static String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.customer_name''',
      ));
}

/*class UpdateCustomerCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? mobileNumber = '',
    String? countryCode = '',
    String? hosturl = '',
    String? customerName = '',
    String? token = '',
    File? imagePath,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'UpdateCustomer',
      apiUrl: '${hosturl}/customermaster/update-customer-admin',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {
        'email': email,
        'mobilenumber': mobileNumber,
        'country_code': countryCode,
        'customer_name': customerName,
        'profilepic': imagePath,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}*/

class UpdateCustomerCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? mobileNumber = '',
    String? countryCode = '',
    String? hosturl = '',
    String? customerName = '',
    String? token = '',
    File? imagePath,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${hosturl}/customermaster/update-customer-admin'),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });

    request.fields.addAll({
      'email': email ?? '',
      'mobilenumber': mobileNumber ?? '',
      'country_code': countryCode ?? '',
      'customer_name': customerName ?? '',
      'profilepic': imagePath != null ? imagePath.path : '',
    });

    if (imagePath != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'profilepic',
        imagePath.path,
      ));
    }

    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);

    return ApiCallResponse.fromHttpResponse(response, true, false);
  }
}

class CustomerDetailsCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? hosturl = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'CustomerDetails',
      apiUrl: '${hosturl}/customermaster/customer-details',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? customerName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.customer_name''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.email''',
  ));
  static int? phone(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.mobilenumber''',
  ));
}

class SignUpSendOTPCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? mobileNumber = '',
    String? countryCode = '',
    String? hosturl = '',
    String? customerName = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'SignUpSendOTP',
      apiUrl: '${hosturl}/customermaster/send-otp',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'email': email,
        'mobile_number': mobileNumber,
        'country_code': countryCode,
        'customer_name': customerName,
      },
      //bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

/*class RegisterCustomerCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? customerName = '',
    String? customerType = '',
    String? mobilenumber = '',
    String? email = '',
    String? countryCode = '',
    String? registerVia = '',
    String? otp = '',
    String source = 'app',
  }) async {
    final ffApiRequestBody = '''
{
    "hosturl": "${hosturl}",
    "customer_name": "${customerName}",
    "customer_type": "${customerType}",
    "mobilenumber": "${mobilenumber}",
    "email": "${email}",
    "country_code": "${countryCode}",
    "register_via": "${registerVia}",
    "otp": "${otp}",
    "source": "${source}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'RegisterCustomer',
      apiUrl: '${hosturl}/customermaster/web-register-customer',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? customerName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.customer_name''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.email''',
  ));
  static int? phone(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.mobilenumber''',
  ));
}*/

class RegisterCustomerCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? customerName = '',
    String? customerType = '',
    String? mobilenumber = '',
    String? email = '',
    String? countryCode = '',
    String? registerVia = 'login',
    String? otp = '',
    String source = 'app',
  }) async {
    final ffApiRequestBody = jsonEncode({
      "hosturl": hosturl,
      "customer_name": customerName,
      "customer_type": customerType,
      "mobilenumber": mobilenumber,
      "email": email,
      "country_code": countryCode,
      "register_via": registerVia,
      "otp": otp,
      "source": source,
    });

    return ApiManager.instance.makeApiCall(
      callName: 'RegisterCustomer',
      apiUrl: '${hosturl}/customermaster/web-register-customer',
      callType: ApiCallType.POST,
      headers: {'Content-Type': 'application/json'},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? customerName(dynamic response) {
    final data = response['data'] as Map<String, dynamic>;
    return data['customer_name'] as String?;
  }

  static String? email(dynamic response) {
    final data = response['data'] as Map<String, dynamic>;
    return data['email'] as String?;
  }

  static int? phone(dynamic response) {
    final data = response['data'] as Map<String, dynamic>;
    return data['mobilenumber'] as int?;
  }
}

/*class RegisterCustomerCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? customerName = '',
    String? customerType = '',
    String? mobilenumber = '',
    String? email = '',
    String? countryCode = '',
    String? registerVia = '',
    String? otp = ''
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'RegisterCustomer',
      apiUrl: '${hosturl}/customermaster/web-register-customer',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'hosturl': hosturl,
        'customer_name': customerName,
        'customer_type': customerType,
        'mobilenumber': mobilenumber,
        'email': email,
        'country_code': countryCode,
        'register_via': registerVia,
        'otp': otp,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? customerName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.customer_name''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.email''',
  ));
  static int? phone(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.mobilenumber''',
  ));
}*/

class AddressListCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'AddressList',
      apiUrl: '${hosturl}/customermaster/address-detail',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class StateListCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? countryId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "country_id": "${countryId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'StateList',
      apiUrl: '${hosturl}/customermaster/state-list',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? stateName(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class CountryListCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'CountryList',
      apiUrl: '${hosturl}/customermaster/country-list',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? id(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  static List<String>? name(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class AddAddressCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? hosturl = '',
    String? name = '',
    String? contactNo = '',
    String? address = '',
    String? email = '',
    String? addresstwo = '',
    String? landmark = '',
    String? countryCode = '',
    String? country = '',
    String? state = '',
    String? city = '',
    String? pincode = '',
  }) async {
    final ffApiRequestBody = '''
{
  "name": "${name}",
  "contact_no": "${contactNo}",
  "email": "${email}",
  "address": "${address}",
  "addresstwo": "${addresstwo}",
  "landmark": "${landmark}",
  "country_code": "${countryCode}",
  "country": "${country}",
  "state": "${state}",
  "city": "${city}",
  "pincode": "${pincode}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AddAddress',
      apiUrl: '${hosturl}/customermaster/add-address',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? customerName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.customer_name''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.email''',
  ));
  static int? phone(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.mobilenumber''',
  ));
}

class UpdateAddressCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? hosturl = '',
    String? name = '',
    String? contactNo = '',
    String? address = '',
    String? email = '',
    String? addresstwo = '',
    String? landmark = '',
    String? countryCode = '',
    String? country = '',
    String? state = '',
    String? city = '',
    String? pincode = '',
    String? id = '',
  }) async {
    final ffApiRequestBody = '''
{
  "id": "${id}",
  "name": "${name}",
  "contact_no": "${contactNo}",
  "email": "${email}",
  "address": "${address}",
  "addresstwo": "${addresstwo}",
  "landmark": "${landmark}",
  "country_code": "${countryCode}",
  "country": "${country}",
  "state": "${state}",
  "city": "${city}",
  "pincode": "${pincode}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UpdateAddress',
      apiUrl: '${hosturl}/customermaster/update-address',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? customerName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.customer_name''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.email''',
  ));
  static int? phone(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.mobilenumber''',
  ));
}

class DeleteAddressCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? id = '',
    String? token = '',
  }) async {
    final ffApiRequestBody = '''
{
  "id": "${id}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'DeleteAddress',
      apiUrl: '${hosturl}/customermaster/delete-address',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? customerName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.customer_name''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.email''',
  ));
  static int? phone(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.mobilenumber''',
  ));
}

class WishListCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'WishList',
      apiUrl: '${hosturl}/wishlist/customer-wishlist',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
  static List<int> id(dynamic response) {
    return (getJsonField(
      response,
      r'''$.data[:].id''',
      true,
    ) as List?)
        ?.withoutNulls
        .map((x) => castToType<int>(x))
        .withoutNulls
        .toList() ?? [];
  }


  static List<String>? name(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class RemovefromWishlistCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? hosturl = '',
    int? productId,
    int? productType,
  }) async {
    final ffApiRequestBody = '''
{
  "product_id": ${productId},
  "product_type": ${productType}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'RemovefromWishlist',
      apiUrl: '${hosturl}/wishlist/remove-customer-wishlist',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? customerName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.customer_name''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.email''',
  ));
  static int? phone(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.mobilenumber''',
  ));
}

class CartCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Cart',
      //apiUrl: '${hosturl}/cart/customer-cart',
      apiUrl: '${hosturl}/mobileapp/cart-list',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? stateName(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class GlobalSearchCall {
  static Future<ApiCallResponse> call({
    String? search = '',
    String? hosturl = '',
  }) async {
    final ffApiRequestBody = '''
{
  "search": "${search}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GlobalSearch',
      apiUrl: '${hosturl}/otherproductmaster/global-search',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
    response,
    r'''$.data''',
    true,
  ) as List?;
  static List<String>? productname(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].product_name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class AddReviewCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? main_product_type = '',
    String? star_rating = '',
    String? comment = '',
    String? product_id = '',
    String? token = ''

  }) async {
    final ffApiRequestBody = '''
{
  "main_product_type": "${main_product_type}",
  "star_rating": "${star_rating}",
  "comment": "${comment}",
  "product_id": "${product_id}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Add Review',
      apiUrl: '${hosturl}/customermaster/add-customer-review',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }


}



class TestimonialListCall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'TestimonialList',
      apiUrl: '${sanityurl}/enquirymaster/web-testimonial',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? categoryNames(dynamic response) => (getJsonField(
    response,
    r'''$.categorydata[:].category''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
  static List<String>? productName(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].productname''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
  static List<int>? sellingPrice(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].selling_price''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  static List<int>? categoryId(dynamic response) => (getJsonField(
    response,
    r'''$.categorydata[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
}

class Bannercall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Banner call',
      apiUrl: '${sanityurl}/banner/web-banner-list',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? Bannerimage(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].mobileimage''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
  static int? datamainprodtype(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.data[:].mainprodtype''',
      ));
  static int? datalevel(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data[:].level''',
  ));
  static bool? dataproductlist(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$.data[:].product_list''',
      ));
}

class EncryptedBannercall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Banner call',
      apiUrl: '${sanityurl}/banner/enc-web-banner-list',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }


  static List<String>? Bannerimage(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].mobileimage''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();

}

class UpdateCartCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? token = '',
    String? cartId = '',
    int? quantity,
  }) async {
    final ffApiRequestBody = '''
{
  "cart_id": "${cartId}",
  "quantity": "${quantity}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UpdateCart',
      apiUrl: '${hosturl}/cart/update-customer-cart',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? id(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  static List<String>? name(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class RemovefromCartlistCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? hosturl = '',
    int? cartId,
  }) async {
    final ffApiRequestBody = '''
{
  "cart_id": ${cartId}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'RemovefromCartlist',
      apiUrl: '${hosturl}/cart/delete-customer-cart',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? customerName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.customer_name''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.email''',
  ));
  static int? phone(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.mobilenumber''',
  ));
}

class CurrencyCall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Currency',
      apiUrl: '${sanityurl}/pujaenergization/product-hierarchy',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class HomeBlogCall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'HomeBlog',
      apiUrl: '${sanityurl}/blog/home-blog',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? stateName(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class ProductHeirarchyCall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
    String? referName = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Product  Heirarchy',
      apiUrl: '${sanityurl}/pujaenergization/filter-mobile-menu',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'refer_name': referName,
      },
      //bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static List? productDataList(dynamic response) => getJsonField(
    response,
    r'''$.data''',
    true,
  ) as List?;
}

class SubProductHeirarchyCall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
    String? slugValue = '',
    String? subcategory = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'SubProduct  Heirarchy ',
      apiUrl: '${sanityurl}/mobileapp/${subcategory}',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'slug_value': slugValue,
      },
      //bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static List? productDataList(dynamic response) => getJsonField(
    response,
    r'''$.data''',
    true,
  ) as List?;
}

class SlugSearchCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? slugValue = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'SlugSearch',
      apiUrl: '${hosturl}/pujaenergization/slug-search',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'slug_value': slugValue,
      },
      //bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static int? datamainprodtype(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.data[:].mainprodtype''',
      ));
  static int? datalevel(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data[:].level''',
  ));
  static bool? dataproductlist(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$.data[:].product_list''',
      ));
}

class MobileMenuCategoriesCall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Mobile Menu Categories',
      apiUrl: '${sanityurl}/pujaenergization/mobile-menu',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? menuItems(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class ProductDetailsCall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
    String? producttype = '',
    String? rudrakshproductslugvalue = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'ProductDetails',
      apiUrl: '${sanityurl}/${producttype}=${rudrakshproductslugvalue}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? productimageurl(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.image_url[:].path''',
      ));
  static String? productname(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.product_name''',
      ));
  static String? productcode(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.product_code''',
      ));
  static double? productrating(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.overall_rating''',
      ));
  static double? productcount(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.review_count''',
      ));

  static List<String>? pendentgroupname(dynamic response) => (getJsonField(
    response,
    r'''$.data.pendentgroup[:].name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
  static List? pendentgroup(dynamic response) => getJsonField(
    response,
    r'''$.data.pendentgroup''',
    true,
  ) as List?;
  static List<String>? pendentgroupimageurllist(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.pendentgroup[:].image''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? pendentprice(dynamic response) => (getJsonField(
    response,
    r'''$.data.pendentgroup[:].price''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  static int? productsellingprice(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.data.selling_price''',
      ));
  static String? longdescription(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.long_description''',
      ));
  static List? reviewData(dynamic response) => getJsonField(
    response,
    r'''$.data.review_data''',
    true,
  ) as List?;
  static List? relatedproduct(dynamic response) => getJsonField(
    response,
    r'''$.data.related_products''',
    true,
  ) as List?;
  static List? braceletgroup(dynamic response) => getJsonField(
    response,
    r'''$.data.braceletgroup''',
    true,
  ) as List?;
}


class OtherProductsDetailsCall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
    String? productslugvalue = '',
    String? producttype = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'OtherProductsDetails',
      //apiUrl: '${sanityurl}/${producttype}=${productslugvalue}',
      apiUrl: '${sanityurl}/${producttype}=${productslugvalue}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? productcode(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.product_code''',
      ));
  static String? yantracode(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data[:].yantracode''',
      ));

  static String? yantraproductcode(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.yantracode''',
      ));
  static double? productrating(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.data.overall_rating''',
      ));
  static double? productcount(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.review_count''',
      ));
  static bool? out_of_stock(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$.data.out_of_stock''',
      ));
  static bool? reserved(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$.data.reserved''',
      ));
  static List<String>? pendentgroupname(dynamic response) => (getJsonField(
    response,
    r'''$.data.pendentgroup[:].name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
  static List? pendentgroup(dynamic response) => getJsonField(
    response,
    r'''$.data.pendentgroup''',
    true,
  ) as List?;
  static List<String>? pendentgroupimageurllist(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.pendentgroup[:].image''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? pendentprice(dynamic response) => (getJsonField(
    response,
    r'''$.data.pendentgroup[:].price''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  static int? productsellingprice(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.data.selling_price''',
      ));
  static String? longdescription(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.long_description''',
      ));


  static List? reviewData(dynamic response) => getJsonField(
    response,
    r'''$.data.review_data''',
    true,
  ) as List?;
  static List? relatedproduct(dynamic response) => getJsonField(
    response,
    r'''$.data.related_products''',
    true,
  ) as List?;
  static List? braceletgroup(dynamic response) => getJsonField(
    response,
    r'''$.data.braceletgroup''',
    true,
  ) as List?;
  static String? otherproductname(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.product_name''',
      ));

  static String? yantraproductname(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.name''',
      ));
  static String? cotherproductcode(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.product_code''',
      ));
  static List? otherproductimageurl(dynamic response) => getJsonField(
    response,
    r'''$.data[:].image_url''',
    true,
  ) as List?;
  static List<String>? otherproductimageurlpath(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.image_url[:].path''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? yantraproductimageurlpath(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data .image_url[:].path''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? variantname(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].product_variant_data[:].variant_name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
  static List<int>? productvariantdatasellingprice(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.product_variant_data[:].selling_price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<int>? yantravariantdatasellingprice(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.product_variant_data[:].selling_price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? productvariantdataimageurlpath(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.product_variant_data[:].image_url[:].path''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? productvariantdatadescription(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.product_variant_data[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static String? otherProductsellingprice(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.selling_price''',
      ));

  static String? yantraProductsellingprice(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.selling_price''',
      ));
  static int? doubleotherProductsellingprice(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.data[:].selling_price''',
      ));
  static List? otherproductvariantdata(dynamic response) => getJsonField(
    response,
    r'''$.data.product_variant_data''',
    true,
  ) as List?;

  static List? yantraproductvariantdata(dynamic response) => getJsonField(
    response,
    r'''$.product_variant_data''',
    true,
  ) as List?;
  static List? otherProductsimilarcategoryproduct(dynamic response) =>
      getJsonField(
        response,
        r'''$.data.related_products''',
        true,
      ) as List?;
  static List? yantraProductsimilarcategoryproduct(dynamic response) =>
      getJsonField(
        response,
        r'''$.similar_category_product''',
        true,
      ) as List?;
  static String? otherProductlongDescription(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.long_description''',
      ));
  static String? yantraProductlongDescription(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.long_description''',
      ));
  static int? productid(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.id''',
  ));
  static int? productMainType(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.mainprodtype''',
  ));
  static bool? productVariantStatus(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$.data.variant_status''',
      ));

  static bool? yantraproductVariantStatus(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$.data.variant_status''',
      ));
  static List<int>? productVariantDataId(dynamic response) => (getJsonField(
    response,
    r'''$.data.product_variant_data[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();

  static List<int>? yantraVariantDataId(dynamic response) => (getJsonField(
    response,
    r'''$.data.product_variant_data[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  static List? productRingData(dynamic response) => getJsonField(
    response,
    r'''$.data.ringgroup''',
    true,
  ) as List?;
  static List<String>? productRingName(dynamic response) => (getJsonField(
    response,
    r'''$.data.ringgroup[:].name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
  static List<int>? productRingPrice(dynamic response) => (getJsonField(
    response,
    r'''$.data.ringgroup[:].price''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  static List<String>? productRingImages(dynamic response) => (getJsonField(
    response,
    r'''$.data.ringgroup[:].image''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
  static List? pujaenergizationlist(dynamic response) => getJsonField(
    response,
    r'''$.data.puja_energization_list''',
    true,
  ) as List?;
  static List<String>? datapujaenergizationlistname(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.puja_energization_list[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? pujaenergizationlistprice(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.puja_energization_list[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? pujaenergizationlistid(dynamic response) => (getJsonField(
    response,
    r'''$.data.puja_energization_list[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  static List? certificationlist(dynamic response) => getJsonField(
    response,
    r'''$.data.certification_list''',
    true,
  ) as List?;

  static List? productvariantdata(dynamic response) => getJsonField(
    response,
    r'''$.product_variant_data''',
    true,
  ) as List?;
  static List<String>? datacertificationlistname(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.certification_list[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? certificationlistprice(dynamic response) => (getJsonField(
    response,
    r'''$.data.certification_list[:].price''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  static List<int>? certificationlistid(dynamic response) => (getJsonField(
    response,
    r'''$.data.certification_list[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  static String? productname(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.product_name''',
      ));
  static List? reviewdata(dynamic response) => getJsonField(
    response,
    r'''$.data.review_data''',
    true,
  ) as List?;

  static String? reviewcustomerstarrating(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.review_data[0].star_rating''',
      ));

  static String? Otherreviewcustomerstarrating(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.review_data[0].star_rating''',
      ));

  static String? reviewcustomercomment(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.review_data[0].comment''',
      ));

  static int? reviewcount(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.review_count''',
      ));

  static String? reviewcustomername(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.review_data[0].customer_name''',
      ));

  static String? Otherproductreviewcustomername(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.review_data[0].customer_name''',
      ));
  static String? Otherproductreviewcustomercomment(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.review_data[0].comment''',
      ));
  static String? Otherproductreviewdate(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.review_data[0].createdAt''',
      ));

  static String? reviewdate(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.review_data[0].createdAt''',
      ));
/*  static String? reviewcustomercomment(dynamic response) => getJsonField(
    response,
    r'''$.data[:].review_data.comment''',
    true,
  ) ;*/

  static List<String>? yantradesigngrpimage(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].designgrp[:].image''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
  static String? yantrametatitle(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data[:].meta_title''',
      ));
  static List? yantradesigngrp(dynamic response) => getJsonField(
    response,
    r'''$.data[:].designgrp''',
    true,
  ) as List?;
  static List? yantrapujaenergizationlist(dynamic response) => getJsonField(
    response,
    r'''$.data[:].puja_energization_list''',
    true,
  ) as List?;

  static int? rudrakshaProductid(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.data.id''',
      ));
  static int? rudrakshaMainProductType(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.data.mainprodtype''',
      ));
  static List<int>? otherproductvariantdataid(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.product_variant_data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? dataproductvariantdatadesigngrpprice(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data[:].product_variant_data[0].designgrp[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<int>? yantraproductvariantdatadesigngrpprice(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.product_variant_data[0].designgrp[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<int>? dataproductvariantdata1designgrpprice(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.product_variant_data[1].designgrp[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? dataproductvariantdata2designgrpprice(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.product_variant_data[2].designgrp[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<int>? dataproductvariantdata3designgrpprice(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.product_variant_data[3].designgrp[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? dataproductvariantdata4designgrpprice(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.product_variant_data[4].designgrp[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<int>? datapujaenergizationlistid(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data[:].puja_energization_list[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<int>? yantrapujaenergizationlistid(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.puja_energization_list[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<int>? pujadataproductvariantdatasellingprice(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.product_variant_data[:].selling_price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();

  static List<String>? pujavariantpath(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.product_variant_data[:].image_url[:].path''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<String>? pujavariantname(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.product_variant_data[:].variant_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List<Map<String, dynamic>>? pujavariantdata(dynamic response) {
    var jsonList = getJsonField(
      response,
      r'''$.data.product_variant_data''',
      true,
    ) as List?;

    if (jsonList == null) {
      return null;
    }

    List<Map<String, dynamic>> variantPaths = [];

    for (var item in jsonList.withoutNulls) {
      if (item is Map<String, dynamic>) {
        variantPaths.add(item);
      } else {
        print('Invalid item format: $item');
      }
    }

    return variantPaths;
  }

  static double? pujaRating(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.data.overall_rating''',
      ));

  static List<int>? pujadataproductvariantdataproductid(dynamic response) => (getJsonField(
    response,
    r'''$.data.product_variant_data[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  static List<String>? pujaimageurlpath(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data.image_url[:].path''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static String? Stringproductsellingprice(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.selling_price''',
      ));
  static bool? pujavariantstatus(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$.data.variant_status''',
      ));
}


class metalDependantDesign {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? slugValue = '',
    String? designType = '',
    String? metal = '',
    String? group = '',
  }) async {
    final ffApiRequestBody = '''
{
  "slug_value": "${slugValue}",
  "design_type": "${designType}",
  "metal": "${metal}",
  "group": "${group}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Metal dependant design',
      apiUrl: '${hosturl}/gemstonemaster/metal-dependent-design',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class metalDetail {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Metal Details Dropdown',
      apiUrl: '${sanityurl}/gemstonemaster/metal-detail',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PujaproductAddToCartCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? token = '',
    String? productid = '',
    String? productType = '',
    bool? productvariation,
    int? productvariationId = 2,
    String? quantity = '1',
    int? energization = 2,
    String? certification = '2',
    int? design = 2,
    int? chain = 2,
    int? bundlekit = 2,
    String? ringSizeSystem = '',
    String? ringSize = '',
    String? wristSize = '',
    String? personName = '',
    String? sankalp = '',
    String? specialInstructions = '',
    String? dob = '',
    String? tob = '',
    String? pob = '',
    String? fatherName = '',
    String? motherName = '',
    String? gotra = '',
    String? photo = '',
  }) async {
    final ffApiRequestBody = '''
{
  "productid": "${productid}",
  "productType": "${productType}",
  "productvariation": ${productvariation} ,
  "productvariationId": ${productvariationId},
  "quantity": "${quantity}",
  "energization": ${energization},
  "certification": " ${certification}",
  "design": ${design},
  "chain": ${chain},
  "bundlekit": ${bundlekit},
   "ring_size_system": null,
  "ring_size": null,
  "wrist_size": null,
   "person_name": "${personName}",
  "sankalp": "${sankalp}",
  "special_instructions": "${specialInstructions}",
  "dob": null,
  "tob": null,
  "pob": null,
  "father_name": "${fatherName}",
  "mother_name": "${motherName}",
  "gotra": "${gotra}",
  "photo": null
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Puja Add To Cart',
      apiUrl: '${hosturl}/cart/add-to-cart',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}


class NotificationsListCall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'NotificationList',
      //apiUrl: '${hosturl}/cart/customer-cart',
      apiUrl: '${sanityurl}/mobileapp/notification-list',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AddToCartCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? token = '',
    String? productid = '',
    String? productType = '',
    bool? productvariation,
    int? productvariationId = 2,
    String? quantity = '1',
    int? energization = 2,
    String? certification = '2',
    int? design = 2,
    int? chain = 2,
    int? bundlekit = 2,
    String? ringSizeSystem = '',
    String? ringSize = '',
    String? wristSize = '',
    String? personName = '',
    String? sankalp = '',
    String? specialInstructions = '',
    String? dob = '',
    String? tob = '',
    String? pob = '',
    String? fatherName = '',
    String? motherName = '',
    String? gotra = '',
    String? photo = '',
  }) async {
    final ffApiRequestBody = '''
{
  "productid": "${productid}",
  "productType": "${productType}",
  "productvariation": ${productvariation} ,
  "productvariationId": ${productvariationId},
  "quantity": "${quantity}",
  "energization": ${energization},
  "certification": " ${certification}",
  "design": ${design},
  "chain": ${chain},
  "bundlekit": ${bundlekit},
  "ring_size_system": ${ringSizeSystem != null ? '"$ringSizeSystem"' : null},
  "ring_size": ${ringSize != null ? '"$ringSize"' : null},
  "wrist_size": ${wristSize != null ? '"$wristSize"' : null},
  "person_name": null,
  "sankalp": null,
  "special_instructions": null,
  "dob": null,
  "tob": null,
  "pob": null,
  "father_name": null,
  "mother_name": null,
  "gotra": null,
  "photo": null
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Add To Cart',
      apiUrl: '${hosturl}/cart/add-to-cart',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class RudrakshaProductCall {
  static Future<ApiCallResponse> call({
    String? slugValue = '',
    String? sizeGrade = '',
    String? maxPrice = '',
    String? minPrice = '',
    String? beadMaxSize = '',
    String? beadMinSize = '',
    String? pageNo = '',
    String? hosturl = '',
    String? sort_by = '',
  }) async {
    final ffApiRequestBody = '''
{
  "slug_value": "${slugValue}",
  "size_grade": "${sizeGrade}",
  "max_price": "${maxPrice}",
  "min_price": "${minPrice}",
  "bead_max_size": "${beadMaxSize}",
  "bead_min_size": "${beadMinSize}",
  "page_no": "${pageNo}",
  "sort_by": "${sort_by}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'RudrakshaProduct',
      apiUrl: '${hosturl}/mobileapp/rudraksha-product-basedon-subcategory',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static List? productlist(dynamic response) => getJsonField(
    response,
    r'''$.data''',
    true,
  ) as List?;
  static int? constantmaxprice(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.constant.maxprice''',
      ));
  static int? constantminprice(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.constant.minprice''',
      ));
  static int? constantmaxbeadsize(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.constant.maxbeadsize''',
      ));
  static int? constantminbeadsize(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.constant.minbeadsize''',
      ));
}

class BlogCommentsCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? blogId = '',
    String? name = '',
    String? email = '',
    String? comment = '',

  }) async {
    final ffApiRequestBody = '''
{
  "blogId": "${blogId}",
  "name": "${name}",
  "email": "${email}",
  "comment": "${comment}"
   
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'YantraProduct',
      apiUrl: '${hosturl}/blog/add-blog-comment',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class YantraProductCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? slugValue = '',
    String? maxPrice = '',
    String? minPrice = '',
    String? diety = '',
    String? sort_by='',
    String? page_no = '',

  }) async {
    final ffApiRequestBody = '''
{
  "slug_value": "${slugValue}",
  "max_price": "${maxPrice}",
  "min_price": "${minPrice}",
  "sort_by": "${sort_by}",
  "diety": "${diety}"
   
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'YantraProduct',
      apiUrl: '${hosturl}/mobileapp/yantra-product-basedon-maincategory',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? yantrProductData(dynamic response) => getJsonField(
    response,
    r'''$.data''',
    true,
  ) as List?;
  static int? yantraconstantmaxprice(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.constant.maxprice''',
      ));
  static int? yantraconstantminprice(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.constant.minprice''',
      ));
  static List<String>? yantraconstantdietylist(dynamic response) =>
      (getJsonField(
        response,
        r'''$.constant.dietylist''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}


class BlogDetailsCall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
    String? slugUrl = '',
  }) async {
    final ffApiRequestBody = '''
{
  "sanityurl": "${sanityurl}",
  "slug_url": "${slugUrl}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'BlogDetails',
      apiUrl: '${sanityurl}/blog/blog-details',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? stateName(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class BlogListCall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
    String? categoryId = '',
    String? searchblog = '',
    int? p
  }) async {
    final ffApiRequestBody = '''
{
  "category_id": "${categoryId}",
  "searchblog": "${searchblog}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Blog list',
      apiUrl: '${sanityurl}/blog/blog-web-list?p=${p}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}


class ContactUsCall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
    String? name = '',
    String? email = '',
    String? mobilenumber = '',
    String? subject = '',
    String? query = '',
    String? phoneCode = '',
  }) async {
    final ffApiRequestBody = '''
{
  "sanityurl": "${sanityurl}",
  "name": "${name}",
  "email": "${email}",
  "mobilenumber": "${mobilenumber}",
  "subject": "${subject}",
  "query": "${query}",
  "phone_code": "${phoneCode}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ContactUs',
      apiUrl: '${sanityurl}/enquirymaster/add-enquiry',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? stateName(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}


class PujaProductCall {
  static Future<ApiCallResponse> call({
    String? slugValue = '',
    String? maxPrice = '',
    String? minPrice = '',
    String? hosturl = '',
    String? sort_by = '',
    String? subMainCategoryType = '',
  }) async {
    final ffApiRequestBody = '''
{
  "slug_value": "${slugValue}",
  "sort_by": "${sort_by}",
  "max_price": "${maxPrice}",
  "min_price": "${minPrice}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'PujaProduct',
      apiUrl: '${hosturl}/mobileapp/${subMainCategoryType}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? productlist(dynamic response) => getJsonField(
    response,
    r'''$.data''',
    true,
  ) as List?;
  static int? constantmaxprice(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.constant.maxprice''',
      ));
  static int? constantminprice(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.constant.minprice''',
      ));
}

class OtherProductMainCategoryCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? slugValue = '',
    String? maxPrice = '',
    String? minPrice = '',
    String? filter = '',
    String? subMainProductCategory = '',
    String? sort_by = '',
    String? page_no = '',
  }) async {
    final ffApiRequestBody = '''
{
  "slug_value": "${slugValue}",
  "max_price": "${maxPrice}",
  "min_price": "${minPrice}",
  "filters": "${filter}",
  "sort_by": "${sort_by}",
  "page_no": "${page_no}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'OtherProductMainCategory',
      apiUrl: '${hosturl}/mobileapp/${subMainProductCategory}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? yantrProductData(dynamic response) => getJsonField(
    response,
    r'''$.data''',
    true,
  ) as List?;
  static int? yantraconstantmaxprice(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.constant.maxprice''',
      ));
  static int? yantraconstantminprice(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.constant.minprice''',
      ));
  static List<String>? yantraconstantdietylist(dynamic response) =>
      (getJsonField(
        response,
        r'''$.constant.dietylist''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GemstoneProductOnSubCategoriesCall {
  static Future<ApiCallResponse> call({
    String? sanityurl = '',
    String? slugValue = '',
    String? maxCaratWeight = '',
    String? minCaratWeight = '',
    String? maxRattiWeight = '',
    String? minRattiWeight = '',
    String? maxPricePerCarat = '',
    String? minPricePerCarat = '',
    String? maxPrice = '',
    String? minPrice = '',
    String? origi = '',
    String? sort_by = '',
    String? page_no = '',
  }) async {
    final ffApiRequestBody = '''
{
  "slug_value": "${slugValue}",
  "max_carat_weight": "${maxCaratWeight}",
  "min_carat_weight": "${minCaratWeight}",
  "max_ratti_weight": "${maxRattiWeight}",
  "min_ratti_weight": "${minRattiWeight}",
  "max_price_per_carat": "${maxPricePerCarat}",
  "min_price_per_carat": "${minPricePerCarat}",
  "max_price": "${maxPrice}",
  "min_price": "${minPrice}",
  "origin": "${origi}",
  "page_no": "${page_no}",
  "sort_by": "${sort_by}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Gemstone Product On Sub Categories',
      apiUrl: '${sanityurl}/mobileapp/gemstone-product-basedon-subcategory',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? productDataList(dynamic response) => getJsonField(
    response,
    r'''$.data''',
    true,
  ) as List?;
  static int? constantmaxprice(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.constant.maxprice''',
      ));
  static int? constantminprice(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.constant.minprice''',
      ));
  static double? constantmaxcaratweight(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.constant.maxcaratweight''',
      ));
  static double? constantmincaratweight(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.constant.mincaratweight''',
      ));
  static double? constantmaxbeadsize(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.constant.maxbeadsize''',
      ));
  static double? constantminbeadsize(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.constant.minbeadsize''',
      ));
  static double? constantmaxrattiweight(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.constant.maxrattiweight''',
      ));
  static int? constantminrattiweight(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.constant.minrattiweight''',
      ));
  static int? constantmaxpricepercara(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.constant.maxpricepercarat''',
      ));
  static int? constantminpricepercarat(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.constant.minpricepercarat''',
      ));
  static List<String>? constantoriginlist(dynamic response) => (getJsonField(
    response,
    r'''$.constant.originlist''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class Product {
  final int? productType;
  final int? product;
  final String? productVariation;
  final int? quantity;
  final String personName;
  final String dob;
  final String pob;
  final String tob;
  final String? certification;
  final String? energization;
  final String? design;
  final String chain;
  final String bundlekit;
  final String ringSizeSystem;
  final String ringSize;
  final String wristSize;
  final String sankalp;
  final String specialInstructions;
  final String gotra;
  final String fatherName;
  final String motherName;
  final String photo;

  Product({
    this.productType,
    this.product,
    this.productVariation,
    this.quantity,
    this.personName = '',
    this.dob = '',
    this.pob = '',
    this.tob = '',
    this.certification ,
    this.energization ,
    this.design ,
    this.chain = '',
    this.bundlekit = '',
    this.ringSizeSystem = '',
    this.ringSize = '',
    this.wristSize = '',
    this.sankalp = '',
    this.specialInstructions = '',
    this.gotra = '',
    this.fatherName = '',
    this.motherName = '',
    this.photo = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      /*productType: json['productType'],
      product: json['product'],
      productVariation: json['productVariation'],*/
      productType: json['mainprodtype'],
      product: json['product_id'],
      productVariation: json['product_variation_id']?.toString() ?? '',
      quantity: json['quantity'],
      personName: json['person_name'] ?? '',
      dob: json['dob'] ?? '',
      pob: json['pob'] ?? '',
      tob: json['tob'] ?? '',
      certification: json['certification_id'].toString() ?? '',
      energization: json['energization_id'].toString() ?? '',
      /*certification: json['certification'] ?? '',
      energization: json['energization'] ?? '',*/
      design: json['design_id']?.toString() ?? '',
      chain: json['chain'] ?? '',
      bundlekit: json['bundlekit'] ?? '',
      ringSizeSystem: json['ring_size_system'] ?? '',
      ringSize: json['ring_size'] ?? '',
      wristSize: json['wrist_size'] ?? '',
      sankalp: json['sankalp'] ?? '',
      specialInstructions: json['special_instructions'] ?? '',
      gotra: json['gotra'] ?? '',
      fatherName: json['father_name'] ?? '',
      motherName: json['mother_name'] ?? '',
      photo: json['photo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productType': productType,
      'product': product==null? '': product,
      'productVariation': productVariation ?? '',
      'quantity': quantity,
      'person_name': personName,
      'dob': dob,
      'pob': pob,
      'tob': tob,
      'certification': certification,
      'energization': energization,
      'design': design ,
      'chain': chain,
      'bundlekit': bundlekit,
      'ring_size_system': ringSizeSystem,
      'ring_size': ringSize,
      'wrist_size': wristSize,
      'sankalp': sankalp,
      'special_instructions': specialInstructions,
      'gotra': gotra,
      'father_name': fatherName,
      'mother_name': motherName,
      'photo': photo,
    };
  }
}

class AddOrderCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? token = '',
    int? deliveryAddress,
    String? deliveryAddressText = '',
    int? billingAddress,
    String? billingAddressText = '',
    int? paymentMode,
    String? currencyType = '',
    int? deliveryCharges,
    String? coupenCode = '',
    double? coupenAmount,
    String? giftId = '',
    bool? rewardUsed,
    int? pendingamount,
    List<Product>? products,
    String? customerInstructions = '',
    String? shippingType = '',
    String? digitalSource = '',
    String source = 'app'
  }) async {
    final ffApiRequestBody = jsonEncode({
      "deliveryAddress": deliveryAddress,
      "billingAddress": billingAddress,
      "payment_mode": paymentMode,
      "currency_type": currencyType,
      "coupenCode": coupenCode ?? "",
      "giftId": giftId ?? "",
      "reward_used": rewardUsed,
      "products": products?.map((product) => product.toJson()).toList() ?? [],
      "customer_instructions": customerInstructions,
      "shipping_type": shippingType,
      "digital_source": digitalSource,
      "source": source,
    });

    print('Request Body: $ffApiRequestBody');
    print('Request Headers: ${{
      'Authorization': 'Bearer $token',
    }}');

    final response = await ApiManager.instance.makeApiCall(
      callName: 'AddOrder',
      apiUrl: '$hosturl/mobileapp/add-order',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    // Print the full response to inspect the structure
    print('Full Response: ${response.jsonBody}');

    // Debug the products field directly
    var productsField = getJsonField(response.jsonBody, r'''$.productdata''');
    print('Products Field: $productsField');
// Debug the products field directly

    // Safeguard for unexpected product formats
    var productsList = productsField is List
        ? productsField
        : (productsField != null ? [productsField] : []);
    print('Processed Products List: $productsList');

    return response;
  }

  static dynamic getData(dynamic response) =>
      getJsonField(response, r'''$.rezorpay_response''');
  static dynamic DataBody(dynamic response) =>
      getJsonField(response, r'''$.data''');

  static String? customerName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data.customer_name''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.email''',
  ));
  static int? phone(dynamic response) => castToType<int>(getJsonField(
    response,
    r'''$.data.mobilenumber''',
  ));
  static String? invoiceNo(dynamic response) => castToType<String>(getJsonField(
    response,
    r'''$.data.invoiceNumber''',
  ));
}

class FetchcheckoutDetailsCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? token = '',
    String? shippingCountry = '',
    String? shippingMethod = 'fedex',
    bool? rewardUsed = false,
    String? couponCode,
    List<Product>? products,
  }) async {
    final ffApiRequestBody = jsonEncode({
      "shipping_country": shippingCountry,
      "shipping_method": shippingMethod,
      "reward_used": rewardUsed,
      "coupon_code": couponCode,
      "product_list": products?.map((product) => product.toJson()).toList(),
    });

    print('Request Body: $ffApiRequestBody');
    print('Request Headers: ${{
      'Authorization': 'Bearer $token',
    }}');

    final response = await ApiManager.instance.makeApiCall(
      callName: 'AddOrder',
      apiUrl: '$hosturl/checkout/add-order',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );

    print('Response: ${response.jsonBody}');
    return response;
  }
}

class FetchShippingCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? token = '',
    String? shippingCountry = '',
    int? shippingWeight,
    int? totalPrice,
    int? orderTotal,
  }) async {
    final ffApiRequestBody = '''
{
  "shipping_country": "${shippingCountry}",
  "shipping_weight": "${shippingWeight}",
  "total_price": "${totalPrice}",
  "order_total": "${orderTotal}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'FetchShipping',
      apiUrl: '${hosturl}/ordermanagement/fetch-shipping',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
  static List<int>? giftsIds(dynamic response) => (getJsonField(
    response,
    r'''$.giftdata[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();

  static List<int>? couponsIds(dynamic response) => (getJsonField(
    response,
    r'''$.coupondata[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
}

class OrderPaymentStatusCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? token = '',
    String? invoiceNumber = '',
    int? amount,
    String? razorpayOrderId = '',
    String? razorpayPaymentId = '',
    String? razorpaySignature = '',
    String? paymentStatus = '',
  }) async {
    final ffApiRequestBody = '''
{
  "invoiceNumber": "${invoiceNumber}",
  "amount": ${amount},
  "razorpay_order_id": "${razorpayOrderId}",
  "razorpay_payment_id": "${razorpayPaymentId}",
  "razorpay_signature": "${razorpaySignature}",
  "paymentStatus": "${paymentStatus}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'OrderPaymentStatus',
      apiUrl: '$hosturl/checkout/order-payment-status',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AddToWishlistCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? token = '',
    int? productid ,
    int? productType ,
  }) async {
    final ffApiRequestBody = '''
{
  "productid": "${productid}",
  "productType": "${productType}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Add to Wishlist',
      apiUrl: '${hosturl}/wishlist/add-wishlist',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteToWishlistCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? token = '',
    int? productid ,
    int? productType ,
  }) async {
    final ffApiRequestBody = '''
{
  "productid": "${productid}",
  "productType": "${productType}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Delete to Wishlist',
      apiUrl: '${hosturl}/wishlist/remove-customer-wishlist',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class OtherSinglePriceAddToCartCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? token = '',
    String? productid = '',
    String? productType = '',
    bool? productvariationstatus,
    int? productvariationId,
    String? quantity = '1',
    int? energization = 2,
    String? certification = '2',
    int? design = 2,
    int? chain = 2,
    int? bundlekit = 2,
    String? ringSizeSystem = '',
    String? ringSize = '',
    String? wristSize = '',
    String? personName = '',
    String? sankalp = '',
    String? specialInstructions = '',
    String? dob = '',
    String? tob = '',
    String? pob = '',
    String? fatherName = '',
    String? motherName = '',
    String? gotra = '',
    String? photo = '',
  }) async {
    final ffApiRequestBody = '''
{
  "productid": "${productid}",
  "productType": "${productType}",
  "productvariation": null,
  "productvariationId": null,
  "quantity": "${quantity}",
  "energization":"${energization}",
  "certification": null,
  "design": null,
  "chain": null,
  "bundlekit": null,
  "ring_size_system": null,
  "ring_size": null,
  "wrist_size": null,
  "person_name": null,
  "sankalp": null,
  "special_instructions": null,
  "dob": null,
  "tob": null,
  "pob": null,
  "father_name": null,
  "mother_name": null,
  "gotra": null,
  "photo": null
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Other Single price Add To Cart',
      apiUrl: '${hosturl}/cart/add-to-cart',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CustomerOrderListCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'CustomerOrderList',
      apiUrl: '${hosturl}/checkout/customer-order-list',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? stateName(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class OrderDetailCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    int? orderId,
  }) async {
    final ffApiRequestBody = '''
{
  "orderId": "${orderId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'OrderDetail',
      apiUrl: '${hosturl}/ordermanagement/order-detail',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? id(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].id''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<int>(x))
      .withoutNulls
      .toList();
  static List<String>? name(dynamic response) => (getJsonField(
    response,
    r'''$.data[:].name''',
    true,
  ) as List?)
      ?.withoutNulls
      .map((x) => castToType<String>(x))
      .withoutNulls
      .toList();
}

class BuyNowCall {
  static Future<ApiCallResponse> call({
    String? hosturl = '',
    String? token = '',
    String? productid = '',
    String? productType = '',
    bool? productvariation,
    int? productvariationId = 2,
    String? quantity = '1',
    int? energization = 2,
    String? certification = '0',
    int? design ,
    int? chain = 2,
    int? bundlekit = 2,
    String? ringSizeSystem = '',
    String? ringSize = '',
    String? wristSize = '',
    String? personName = '',
    String? sankalp = '',
    String? specialInstructions = '',
    String? dob = '',
    String? tob = '',
    String? pob = '',
    String? fatherName = '',
    String? motherName = '',
    String? gotra = '',
    String? photo = '',
  }) async {
    final ffApiRequestBody = '''
{
  "productid": "${productid}",
  "productType": "${productType}",
  "productvariation": ${productvariation} ,
  "productvariationId": ${productvariationId},
  "quantity": "${quantity}",
  "energization": ${energization},
  "certification": " ${certification}",
  "design": ${design},
  "chain": ${chain},
  "bundlekit": ${bundlekit},
   "ring_size_system": null,
  "ring_size": null,
  "wrist_size": null,
  "person_name": null,
  "sankalp": null,
  "special_instructions": null,
  "dob": null,
  "tob": null,
  "pob": null,
  "father_name": null,
  "mother_name": null,
  "gotra": null,
  "photo": null
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Add To Cart',
      apiUrl: '${hosturl}/mobileapp/buy-now',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
