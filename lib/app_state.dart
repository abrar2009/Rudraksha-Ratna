import 'package:flutter/material.dart';
import 'package:rudraksha_cart/pages/notifications/notifications_widget.dart';
import '/backend/schema/structs/index.dart';
import 'backend/api_requests/api_calls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  // Notification list
  List<NotificationItem> notifications = [];

  void addNotification(NotificationItem notification) {
    notifications.add(notification);
    notifyListeners();
  }

  List<Map<String, dynamic>>? _currencyData;

  List<Map<String, dynamic>>? get currencyData => _currencyData;

  set currencyData(List<Map<String, dynamic>>? value) {
    _currencyData = value;
    notifyListeners();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _token = prefs.getString('ff_token') ?? _token;
      _imagePath = prefs.getString('ff_imagePath') ?? _imagePath;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<ProductDetailsStruct> _RudrakshaInfo = [
    ProductDetailsStruct.fromSerializableMap(jsonDecode(
        '{\"ProductImage\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/rudraksha-ratna-kjh2wo/assets/3kj7daavi39l/placeholder-3.png\",\"ProductName\":\"Nepal Rudraksha\"}')),
    ProductDetailsStruct.fromSerializableMap(jsonDecode(
        '{\"ProductImage\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/rudraksha-ratna-kjh2wo/assets/v7w27qrt5acr/Ellipse_37-1.png\",\"ProductName\":\"Java,Rudrakash\"}'))
  ];
  List<ProductDetailsStruct> get RudrakshaInfo => _RudrakshaInfo;
  set RudrakshaInfo(List<ProductDetailsStruct> value) {
    _RudrakshaInfo = value;
  }

  void addToRudrakshaInfo(ProductDetailsStruct value) {
    RudrakshaInfo.add(value);
  }

  void removeFromRudrakshaInfo(ProductDetailsStruct value) {
    RudrakshaInfo.remove(value);
  }

  void removeAtIndexFromRudrakshaInfo(int index) {
    RudrakshaInfo.removeAt(index);
  }

  void updateRudrakshaInfoAtIndex(
      int index,
      ProductDetailsStruct Function(ProductDetailsStruct) updateFn,
      ) {
    RudrakshaInfo[index] = updateFn(_RudrakshaInfo[index]);
  }

  void insertAtIndexInRudrakshaInfo(int index, ProductDetailsStruct value) {
    RudrakshaInfo.insert(index, value);
  }

  List<ProductDetailsStruct> _Gemstone = [
    ProductDetailsStruct.fromSerializableMap(jsonDecode(
        '{\"ProductImage\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/rudraksha-ratna-kjh2wo/assets/dgm4p44i4w2o/placeholder.png\",\"ProductName\":\"Natural Loose Gemstones\"}')),
    ProductDetailsStruct.fromSerializableMap(jsonDecode(
        '{\"ProductImage\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/rudraksha-ratna-kjh2wo/assets/11ua8veky6u8/placeholder-1.png\",\"ProductName\":\"Natural Loose Gemstones\"}')),
    ProductDetailsStruct.fromSerializableMap(jsonDecode(
        '{\"ProductImage\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/rudraksha-ratna-kjh2wo/assets/zkut37ydz1nl/placeholder-2.png\",\"ProductName\":\"Natural Gemstone Bracelets\"}')),
    ProductDetailsStruct.fromSerializableMap(jsonDecode(
        '{\"ProductImage\":\"https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/rudraksha-ratna-kjh2wo/assets/zfh0bmdbd93n/placeholder-3.png\",\"ProductName\":\"Gemstone Earrings\"}'))
  ];
  List<ProductDetailsStruct> get Gemstone => _Gemstone;
  set Gemstone(List<ProductDetailsStruct> value) {
    _Gemstone = value;
  }

  void addToGemstone(ProductDetailsStruct value) {
    Gemstone.add(value);
  }

  void removeFromGemstone(ProductDetailsStruct value) {
    Gemstone.remove(value);
  }

  void removeAtIndexFromGemstone(int index) {
    Gemstone.removeAt(index);
  }

  void updateGemstoneAtIndex(
      int index,
      ProductDetailsStruct Function(ProductDetailsStruct) updateFn,
      ) {
    Gemstone[index] = updateFn(_Gemstone[index]);
  }

  void insertAtIndexInGemstone(int index, ProductDetailsStruct value) {
    Gemstone.insert(index, value);
  }

  String _pagename = 'Homepage';
  String get pagename => _pagename;
  set pagename(String value) {
    _pagename = value;
  }

  List<AddressDatatypeStruct> _AddressList = [
    AddressDatatypeStruct.fromSerializableMap(jsonDecode(
        '{\"Firstname\":\"Kaustubh Chalke\",\"lastname\":\"Hello World\",\"phonenumber\":\"0\",\"emailaddress\":\"Hello World\",\"addressline1\":\"3910 Crim Lane, Greendale County, Colorado. Zip Code 410348\",\"landmark\":\"Hello World\",\"country\":\"Hello World\",\"state\":\"Hello World\",\"city\":\"Hello World\",\"pincode\":\"0\"}')),
    AddressDatatypeStruct.fromSerializableMap(jsonDecode(
        '{\"Firstname\":\"Sagar Caudhari\",\"lastname\":\"Hello World\",\"phonenumber\":\"0\",\"emailaddress\":\"Hello World\",\"addressline1\":\"21 Yellow Av, Greendale County, Colorado. Zip Code 410236\",\"landmark\":\"Hello World\",\"country\":\"Hello World\",\"state\":\"Hello World\",\"city\":\"Hello World\",\"pincode\":\"0\"}'))
  ];
  List<AddressDatatypeStruct> get AddressList => _AddressList;
  set AddressList(List<AddressDatatypeStruct> value) {
    _AddressList = value;
  }

  void addToAddressList(AddressDatatypeStruct value) {
    AddressList.add(value);
  }

  void removeFromAddressList(AddressDatatypeStruct value) {
    AddressList.remove(value);
  }

  void removeAtIndexFromAddressList(int index) {
    AddressList.removeAt(index);
  }

  void updateAddressListAtIndex(
      int index,
      AddressDatatypeStruct Function(AddressDatatypeStruct) updateFn,
      ) {
    AddressList[index] = updateFn(_AddressList[index]);
  }

  void insertAtIndexInAddressList(int index, AddressDatatypeStruct value) {
    AddressList.insert(index, value);
  }

  String _category = 'Rudraksha';
  String get category => _category;
  set category(String value) {
    _category = value;
  }

  String _categoryId = '';
  String get categoryId => _categoryId;
  set categoryId(String value) {
    _categoryId = value;
  }

  String _countrycode = '';
  String get countrycode => _countrycode;
  set countrycode(String value) {
    _countrycode = value;
  }

  String _imagePath = '';
  String get imagePath => _imagePath;
  set imagePath(String value) {
    _imagePath = value;
    prefs.setString('ff_imagePath', value);
  }

  String _firebaseToken = '';
  String get firebaseToken => _firebaseToken;
  set firebaseToken(String value) {
    _firebaseToken = value;
  }

  String _statusSuccess = 'success';
  String get statusSuccess => _statusSuccess;
  set statusSuccess(String value) {
    _statusSuccess = value;
  }

  String _statusFailed = 'failed';
  String get statusFailed => _statusFailed;
  set statusFailed(String value) {
    _statusFailed = value;
  }

  DateTime? _expiryToken;
  DateTime? get expiryToken => _expiryToken;
  set expiryToken(DateTime? value) {
    _expiryToken = value;
  }

  String _token = '';
  String get token => _token;
  set token(String value) {
    _token = value;
    prefs.setString('ff_token', value);
  }

  String _countryCode4Payment = '';
  String get countryCode4Payment => _countryCode4Payment;
  set countryCode4Payment(String value) {
    _countryCode4Payment = value;
  }

  String _currencyName = 'INR';
  String get currencyName => _currencyName;
  set currencyName(String value) {
    _currencyName = value;
  }

  double _currencyRate = 1.0;
  double get currencyRate => _currencyRate;
  set currencyRate(double value) {
    _currencyRate = value;
  }

  double _cartAmount = 1.0;
  double get cartAmount => _cartAmount;
  set cartAmount(double value) {
    _cartAmount = value;
  }

  double _finalAmount = 0.0;
  double get finalAmount => _finalAmount;
  set finalAmount(double value) {
    _finalAmount = value;
  }

  int? _checkBoxFinalAmount;
  int? get checkBoxFinalAmount => _checkBoxFinalAmount;
  set checkBoxFinalAmount(int? value) {
    _checkBoxFinalAmount = value;
  }

  double _updatedCartTotal = 0.0;
  double get updatedCartTotal => _updatedCartTotal;
  set updatedCartTotal(double value) {
    updatedCartTotal = value;
  }

  String _countryName = 'India';
  String get countryName => _countryName;
  set countryName(String value) {
    _countryName = value;
  }

  String? _selectedGiftName = '';
  String? get selectedGiftName => _selectedGiftName;
  set selectedGiftName(String? value) {
    _selectedGiftName = value;
  }

  String? _selectedSize = '';
  String? get selectedSize => _selectedSize;
  set selectedSize(String? value) {
    _selectedSize = value;
  }

  String? _selectedSizeSystem = '';
  String? get selectedSizeSystem => _selectedSizeSystem;
  set selectedSizeSystem(String? value) {
    _selectedSizeSystem = value;
  }

  String? _selectedRingSize = '';
  String? get selectedRingSize => _selectedRingSize;
  set selectedRingSize(String? value) {
    _selectedRingSize = value;
  }

  String? _billingAddress1 = '';
  String? get billingAddress1 => _billingAddress1;
  set billingAddress1(String? value) {
    _billingAddress1 = value;
  }

  String? _billingAddress2 = '';
  String? get billingAddress2 => _billingAddress2;
  set billingAddress2(String? value) {
    _billingAddress2 = value;
  }

  String? _billingCity = '';
  String? get billingCity => _billingCity;
  set billingCity(String? value) {
    _billingCity = value;
  }

  String? _billingState = '';
  String? get billingState => _billingState;
  set billingState(String? value) {
    _billingState = value;
  }

  String? _billingPincode = '';
  String? get billingPincode => _billingPincode;
  set billingPincode(String? value) {
    _billingPincode = value;
  }

  String? _shippingAddress1 = '';
  String? get shippingAddress1 => _shippingAddress1;
  set shippingAddress1(String? value) {
    _shippingAddress1 = value;
  }

  String? _selectedMetal = '';
  String? get selectedMetal => _selectedMetal;
  set selectedMetal(String? value) {
    _selectedMetal = value;
  }

  String? _shippingAddress2 = '';
  String? get shippingAddress2 => _shippingAddress2;
  set shippingAddress2(String? value) {
    _shippingAddress2 = value;
  }

  String? _shippingCity = '';
  String? get shippingCity => _shippingCity;
  set shippingCity(String? value) {
    _shippingCity = value;
  }

  String? _shippingState = '';
  String? get shippingState => _shippingState;
  set shippingState(String? value) {
    _shippingState = value;
  }

  String? _shippingPincode = '';
  String? get shippingPincode => _shippingPincode;
  set shippingPincode(String? value) {
    _shippingPincode = value;
  }

  int? _billingAddressID;
  int? get billingAddressID => _billingAddressID;
  set billingAddressID(int? value) {
    _billingAddressID = value;
  }

  int? _wishlistItemId;
  int? get wishlistItemId => _wishlistItemId;
  set wishlistItemId(int? value) {
    _wishlistItemId = value;
  }

  int? _wishlistProductType;
  int? get wishlistProductType => _wishlistProductType;
  set wishlistProductType(int? value) {
    _wishlistProductType = value;
  }

  int? _shippingAddressID;
  int? get shippingAddressID => _shippingAddressID;
  set shippingAddressID(int? value) {
    _shippingAddressID = value;
  }

  int? _courierTotal;
  int? get courierTotal => _courierTotal;
  set courierTotal(int? value) {
    _courierTotal = value;
  }

  int? _cartTotal;
  int? get cartTotal => _cartTotal;
  set cartTotal(int? value) {
    _cartTotal = value;
  }

  String _personName = '';
  String get personName => _personName;
  set personName(String value) {
    _personName = value;
  }
  String _sankalp = '';
  String get sankalp => _sankalp;
  set sankalp(String value) {
    _sankalp = value;
  }
  String _specialInstructions = '';
  String get specialInstructions => _specialInstructions;
  set specialInstructions(String value) {
    _specialInstructions = value;
  }
  String _fatherName = '';
  String get fatherName => _fatherName;
  set fatherName(String value) {
    _fatherName = value;
  }
  String _motherName = '';
  String get motherName => _motherName;
  set motherName(String value) {
    _motherName = value;
  }

  String _Stringproductvariation = '';
  String get productvariationString => _Stringproductvariation;
  set  productvariationString(String value) {
    _Stringproductvariation = value;
  }

  int? _orderTotal;
  int? get orderTotal => _orderTotal;
  set orderTotal(int? value) {
    _orderTotal = value;
  }

  int? _shippingAmount = 20;
  int? get shippingAmount => _shippingAmount;
  set shippingAmount(int? value) {
    _shippingAmount = value;
  }

  int? _rewardPoints;
  int? get rewardPoints => _rewardPoints;
  set rewardPoints(int? value) {
    _rewardPoints = value;
  }
 int? _rewardPointsprofile;
  int? get rewardPointsprofile => _rewardPointsprofile;
  set rewardPointsprofile(int? value) {
    _rewardPointsprofile = value;
  }

  String _couponCode = '';
  String get couponCode => _couponCode;
  set couponCode(String value) {
    _couponCode = value;
  }

  double? _finalDiscount;
  double? get finalDiscount => _finalDiscount;
  set finalDiscount(double? value) {
    _finalDiscount = value;
  }

  double? _rewardPointsPayment;
  double? get rewardPointsPayment => _rewardPointsPayment;
  set rewardPointsPayment(double? value) {
    _rewardPointsPayment = value;
  }

  double _couponValue = 0.0;
  double get couponValue => _couponValue;
  set couponValue(double value) {
    _couponValue = value;
  }

  int? _selectedGiftId;
  int? get selectedGiftId => _selectedGiftId;
  set selectedGiftId(int? value) {
    _selectedGiftId = value;
  }

  String _invoiceNumber = '';
  String get invoiceNumber => _invoiceNumber;
  set invoiceNumber(String value) {
    _invoiceNumber = value;
  }

 int? _intinvoiceNumber;
  int? get intinvoiceNumber => _intinvoiceNumber;
  set intinvoiceNumber(int? value) {
    _intinvoiceNumber = value;
  }

  String _Selectedsortby = '';
  String get sortby => _Selectedsortby;
  set sortby(String value) {
    _Selectedsortby = value;
  }

  String _productid = '';
  String get productid => _productid;
  set productid(String value) {
    _productid = value;
  }

  String _productType = '';
  String get productType => _productType;
  set productType(String value) {
    _productType = value;
  }

/*  bool _productvariation;
  bool get productvariation => _productvariation;
  set productvariation(bool value) {
    _productvariation = value;
  }*/

  String _quantity= '';
  String get quantity => _quantity;
  set quantity(String value) {
    _quantity = value;
  }

  List<String> _freeGiftsList = [];
  List<String> get freeGiftsList => _freeGiftsList;
  set freeGiftsList(List<String> values) {
    _freeGiftsList = values;
  }

  List<String> _couponCodeList = [];
  List<String> get couponCodeList => _couponCodeList;
  set couponCodeList(List<String> values) {
    _couponCodeList = values;
  }


  /*List<Product> _products = [];
  List<Product> get products => _products;
  set products(List<Product> values) {
    _products = values;
  }*/
  List<Product> _products = [];
  String? _productsJson;

  // Getter and setter for products
  List<Product> get products => _products;
  set products(List<Product> values) {
    _products = values;
    _productsJson = jsonEncode(_products.map((p) => p.toJson()).toList());
  }

  // Getter for JSON string
  String? get productsJson => _productsJson;


  int? _productvariationId;
  int? get productvariationId => _productvariationId;
  set productvariationId(int? value) {
    _productvariationId = value;
  }

  int? _desingId;
  int? get desingId => _desingId;
  set desingId(int? value) {
    _desingId = value;
  }

  int? _energizationId;
  int? get energizationId => _energizationId;
  set energizationId(int? value) {
    _energizationId = value;
  }
  int? _selectedCertificationId=0;
  int? get selectedCertificationId => _selectedCertificationId;
  set selectedCertificationId(int? value) {
    _selectedCertificationId = value;
  }

  bool? _buynow;
  bool? get buynow => _buynow;
  set buynow(bool? value) {
    _buynow = value;
  }

  bool _hasAppliedRewardPoints = false;

  bool get hasAppliedRewardPoints => _hasAppliedRewardPoints;

  set hasAppliedRewardPoints(bool value) {
    _hasAppliedRewardPoints = value;
  }


  bool _isDeliveryAddress = false;
  bool get isDeliveryAddress => _isDeliveryAddress;
  set isDeliveryAddress(bool value) {
    _isDeliveryAddress = value;
  }

  bool? _productvariation;
  bool? get productvariation => _productvariation;
  set productvariation(bool? value) {
    _productvariation = value;
  }

  String _rangestartString = '';
  String get rangestartString => _rangestartString;
  set rangestartString(String value) {
    _rangestartString = value;
  }

  String _rangeendString = '';
  String get rangeendString => _rangeendString;
  set rangeendString(String value) {
    _rangeendString = value;
  }

  String _BeadSizeMin = '';
  String get BeadSizeMin => _BeadSizeMin;
  set BeadSizeMin(String value) {
    _BeadSizeMin = value;
  }

  String _BeadSizeMax = '';
  String get BeadSizeMax => _BeadSizeMax;
  set BeadSizeMax(String value) {
    _BeadSizeMax = value;
  }

  String _SelectedSizeGrade='';

  String get SelectedSizeGrade => _SelectedSizeGrade;

  set SelectedSizeGrade(String value) {
    if (_SelectedSizeGrade != value) {
      _SelectedSizeGrade = value;
      notifyListeners();
    }
  }

  String _maxcaratweightString = '';
  String get maxcaratweightString => _maxcaratweightString;
  set maxcaratweightString(String value) {
    _maxcaratweightString = value;
  }

  String _mincaratweightString = '';
  String get mincaratweightString => _mincaratweightString;
  set mincaratweightString(String value) {
    _mincaratweightString = value;
  }

  String _maxrattiweightString = '';
  String get maxrattiweightString => _maxrattiweightString;
  set maxrattiweightString(String value) {
    _maxrattiweightString = value;
  }

  String _minrattiweightString = '';
  String get minrattiweightString => _minrattiweightString;
  set minrattiweightString(String value) {
    _minrattiweightString = value;
  }

  String _YantraMaxPrice = '';
  String get YantraMaxPrice => _YantraMaxPrice;
  set YantraMaxPrice(String value) {
    _YantraMaxPrice = value;
  }

  String _YantraMinPrice = '';
  String get YantraMinPrice => _YantraMinPrice;
  set YantraMinPrice(String value) {
    _YantraMinPrice = value;
  }

  String _YantrasDeityPurpose = '';
  String get YantrasDeityPurpose => _YantrasDeityPurpose;
  set YantrasDeityPurpose(String value) {
    _YantrasDeityPurpose = value;
  }

  String _maxpricepercaratString = '';
  String get maxpricepercaratString => _maxpricepercaratString;
  set maxpricepercaratString(String value) {
    _maxpricepercaratString = value;
  }

  String _minpricepercaratString = '';
  String get minpricepercaratString => _minpricepercaratString;
  set minpricepercaratString(String value) {
    _minpricepercaratString = value;
  }

  String _originlist = '';
  String get originlist => _originlist;
  set originlist(String value) {
    _originlist = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
