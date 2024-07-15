// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AddressDatatypeStruct extends BaseStruct {
  AddressDatatypeStruct({
    String? firstname,
    String? lastname,
    int? phonenumber,
    String? emailaddress,
    String? addressline1,
    String? landmark,
    String? country,
    String? state,
    String? city,
    int? pincode,
  })  : _firstname = firstname,
        _lastname = lastname,
        _phonenumber = phonenumber,
        _emailaddress = emailaddress,
        _addressline1 = addressline1,
        _landmark = landmark,
        _country = country,
        _state = state,
        _city = city,
        _pincode = pincode;

  // "Firstname" field.
  String? _firstname;
  String get firstname => _firstname ?? '';
  set firstname(String? val) => _firstname = val;
  bool hasFirstname() => _firstname != null;

  // "lastname" field.
  String? _lastname;
  String get lastname => _lastname ?? '';
  set lastname(String? val) => _lastname = val;
  bool hasLastname() => _lastname != null;

  // "phonenumber" field.
  int? _phonenumber;
  int get phonenumber => _phonenumber ?? 0;
  set phonenumber(int? val) => _phonenumber = val;
  void incrementPhonenumber(int amount) => _phonenumber = phonenumber + amount;
  bool hasPhonenumber() => _phonenumber != null;

  // "emailaddress" field.
  String? _emailaddress;
  String get emailaddress => _emailaddress ?? '';
  set emailaddress(String? val) => _emailaddress = val;
  bool hasEmailaddress() => _emailaddress != null;

  // "addressline1" field.
  String? _addressline1;
  String get addressline1 => _addressline1 ?? '';
  set addressline1(String? val) => _addressline1 = val;
  bool hasAddressline1() => _addressline1 != null;

  // "landmark" field.
  String? _landmark;
  String get landmark => _landmark ?? '';
  set landmark(String? val) => _landmark = val;
  bool hasLandmark() => _landmark != null;

  // "country" field.
  String? _country;
  String get country => _country ?? '';
  set country(String? val) => _country = val;
  bool hasCountry() => _country != null;

  // "state" field.
  String? _state;
  String get state => _state ?? '';
  set state(String? val) => _state = val;
  bool hasState() => _state != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  set city(String? val) => _city = val;
  bool hasCity() => _city != null;

  // "pincode" field.
  int? _pincode;
  int get pincode => _pincode ?? 0;
  set pincode(int? val) => _pincode = val;
  void incrementPincode(int amount) => _pincode = pincode + amount;
  bool hasPincode() => _pincode != null;

  static AddressDatatypeStruct fromMap(Map<String, dynamic> data) =>
      AddressDatatypeStruct(
        firstname: data['Firstname'] as String?,
        lastname: data['lastname'] as String?,
        phonenumber: castToType<int>(data['phonenumber']),
        emailaddress: data['emailaddress'] as String?,
        addressline1: data['addressline1'] as String?,
        landmark: data['landmark'] as String?,
        country: data['country'] as String?,
        state: data['state'] as String?,
        city: data['city'] as String?,
        pincode: castToType<int>(data['pincode']),
      );

  static AddressDatatypeStruct? maybeFromMap(dynamic data) => data is Map
      ? AddressDatatypeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Firstname': _firstname,
        'lastname': _lastname,
        'phonenumber': _phonenumber,
        'emailaddress': _emailaddress,
        'addressline1': _addressline1,
        'landmark': _landmark,
        'country': _country,
        'state': _state,
        'city': _city,
        'pincode': _pincode,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Firstname': serializeParam(
          _firstname,
          ParamType.String,
        ),
        'lastname': serializeParam(
          _lastname,
          ParamType.String,
        ),
        'phonenumber': serializeParam(
          _phonenumber,
          ParamType.int,
        ),
        'emailaddress': serializeParam(
          _emailaddress,
          ParamType.String,
        ),
        'addressline1': serializeParam(
          _addressline1,
          ParamType.String,
        ),
        'landmark': serializeParam(
          _landmark,
          ParamType.String,
        ),
        'country': serializeParam(
          _country,
          ParamType.String,
        ),
        'state': serializeParam(
          _state,
          ParamType.String,
        ),
        'city': serializeParam(
          _city,
          ParamType.String,
        ),
        'pincode': serializeParam(
          _pincode,
          ParamType.int,
        ),
      }.withoutNulls;

  static AddressDatatypeStruct fromSerializableMap(Map<String, dynamic> data) =>
      AddressDatatypeStruct(
        firstname: deserializeParam(
          data['Firstname'],
          ParamType.String,
          false,
        ),
        lastname: deserializeParam(
          data['lastname'],
          ParamType.String,
          false,
        ),
        phonenumber: deserializeParam(
          data['phonenumber'],
          ParamType.int,
          false,
        ),
        emailaddress: deserializeParam(
          data['emailaddress'],
          ParamType.String,
          false,
        ),
        addressline1: deserializeParam(
          data['addressline1'],
          ParamType.String,
          false,
        ),
        landmark: deserializeParam(
          data['landmark'],
          ParamType.String,
          false,
        ),
        country: deserializeParam(
          data['country'],
          ParamType.String,
          false,
        ),
        state: deserializeParam(
          data['state'],
          ParamType.String,
          false,
        ),
        city: deserializeParam(
          data['city'],
          ParamType.String,
          false,
        ),
        pincode: deserializeParam(
          data['pincode'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'AddressDatatypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AddressDatatypeStruct &&
        firstname == other.firstname &&
        lastname == other.lastname &&
        phonenumber == other.phonenumber &&
        emailaddress == other.emailaddress &&
        addressline1 == other.addressline1 &&
        landmark == other.landmark &&
        country == other.country &&
        state == other.state &&
        city == other.city &&
        pincode == other.pincode;
  }

  @override
  int get hashCode => const ListEquality().hash([
        firstname,
        lastname,
        phonenumber,
        emailaddress,
        addressline1,
        landmark,
        country,
        state,
        city,
        pincode
      ]);
}

AddressDatatypeStruct createAddressDatatypeStruct({
  String? firstname,
  String? lastname,
  int? phonenumber,
  String? emailaddress,
  String? addressline1,
  String? landmark,
  String? country,
  String? state,
  String? city,
  int? pincode,
}) =>
    AddressDatatypeStruct(
      firstname: firstname,
      lastname: lastname,
      phonenumber: phonenumber,
      emailaddress: emailaddress,
      addressline1: addressline1,
      landmark: landmark,
      country: country,
      state: state,
      city: city,
      pincode: pincode,
    );
