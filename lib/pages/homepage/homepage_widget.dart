import 'dart:convert';
import 'dart:developer';
import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart' as slider;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import '../../auth/custom_auth/auth_util.dart';
import '../../components/logout_confirmation_widget.dart';
import '../../custom_code/widgets/custom_dropdown_currency_flag.dart';
import '../../flutter_flow/custom_functions.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/components/shimmer_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:expandable/expandable.dart';
import 'homepage_model.dart';
export 'homepage_model.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class HomepageWidget extends StatefulWidget {
  // const HomepageWidget({super.key});

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget> {
  late HomepageModel _model;
  final authToken = currentAuthenticationToken;
  Position? _position;
  String? _countryCode;

  final homescaffoldKey = GlobalKey<ScaffoldState>();
  bool expandableListenerRegistered = false;
  ApiCallResponse? cachedCurrencyResponse;
  List<Map<String, dynamic>>? currencyData;
  double? currency_rate;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomepageModel());

    _model.expandableExpandableController =
        ExpandableController(initialExpanded: false);
    _model.consulatatoinexpandableExpandableController =
        ExpandableController(initialExpanded: false);
    _model.shopbycategoryController =
        ExpandableController(initialExpanded: false);
    _fetchCurrencyData();
    _getCurrentLocation();
    _determinePosition();
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    // Check if location services are enabled
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      print('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    // Check current permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Ensure we only request permission once
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permission denied.');
        return Future.error('Location permissions are denied');
      }
    }

    // If permission is permanently denied
    if (permission == LocationPermission.deniedForever) {
      print('Location permission permanently denied.');
      return Future.error('Location permissions are permanently denied.');
    }

    // Permissions granted, fetch the current position
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print('Current Position: Lat: ${position.latitude}, Long: ${position.longitude}');
      return position;
    } catch (e) {
      print('Error getting location: $e');
      return Future.error('Error occurred while fetching location.');
    }
  }

  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
    });

    print('Current Position: Lat: ${position.latitude}, Long: ${position.longitude}');
    // Use the coordinates to get the country code
    _getCountryCodeFromLocation(position);
  }

  Future<void> _getCountryCodeFromLocation(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      String? countryCode = placemarks.first.isoCountryCode;  // Get country code like 'IN' or 'US'
      print('Country Code: $countryCode');
      _setCurrencyForCountry(countryCode!);
    }
  }

  Future<void> _setCurrencyForCountry(String countryCode) async {
    // Map country codes to currency types
    Map<String, String> countryToCurrency = {
      'IN': 'INR',
      'US': 'USD',
      'GB': 'GBP',
      'CA': 'CAD',
      'AU': 'AUD',
      'SG': 'SGD',
      'HK': 'HKD',
      'MX': 'MXN',
      'CH': 'CHF',
      'LI': 'CHF',
      'CZ': 'CZK',
      'DK': 'DKK',
      'GL': 'DKK',
      'FO': 'DKK',
      'IL': 'ILS',
      'NO': 'NOK',
      'NZ': 'NZD',
      'PH': 'PHP',
      'SE': 'SEK',
      'TH': 'THB',
      'AE': 'AED',
    };

    // Find the currency for the current country
    String currency = countryToCurrency[countryCode] ?? 'INR'; // Default to INR

    // Fetch the currency conversion data from the API
    try {
      final currencyResponse = await CurrencyCall.call(sanityurl: FFAppConstants.sanityurl);

      // Check if the response is not null
      if (currencyResponse != null) {
        print('Currency API Response: ${currencyResponse.jsonBody}');

        // Extract the conversion rate using currency name
        final conversionRate = functions.currencyRateByName(
          getJsonField(currencyResponse.jsonBody, r'''$.currency_data''', true)!,
          currency,
        );

        // Ensure the conversion rate is not null before setting it
        if (conversionRate != null) {
          setState(() {
            FFAppState().currencyName = currency;
            FFAppState().currencyRate = conversionRate; // Set the currency rate
          });
        } else {
          print('Error: Conversion rate for $currency not found.');
        }
      } else {
        print('Error: Currency API response is null.');
      }
    } catch (e) {
      print('Error fetching currency conversion rate: $e');
    }
  }

  /*Future<void> _setCurrencyForCountry(String countryCode) async {
    // Map country codes to currency types
    Map<String, String> countryToCurrency = {
      'IN': 'INR',
      'US': 'USD',
    };

    // Find the currency for the current country
    String currency = countryToCurrency[countryCode] ?? 'INR';  // Default to INR

    setState(() {
      FFAppState().currencyName = currency;
    });
  }*/

  Future<void> _fetchCurrencyData() async {
    if (cachedCurrencyResponse == null) {
      cachedCurrencyResponse = await CurrencyCall.call(
        sanityurl: FFAppConstants.sanityurl,
      );
      if (cachedCurrencyResponse != null) {
        currencyData = (getJsonField(
          cachedCurrencyResponse!.jsonBody,
          r'''$.currency_data''',
          true,
        ) as List<dynamic>).map((item) {
          return {
            'currency_type': item['currency_type'],
            'image': item['image'],
          };
        }).toList();
      }
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: homescaffoldKey,
        backgroundColor: Colors.white,
        drawer: Drawer(
          elevation: 16.0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(24.0, 10.0, 24.0, 28.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/image_29_(1).png',
                                width: double.infinity,
                                height: 91.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.66,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (authToken != null)
                                  FutureBuilder<ApiCallResponse>(
                                    future: CustomerDetailsCall.call(
                                      token: currentAuthenticationToken,
                                      hosturl: FFAppConstants.hosturl,
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: CircularProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context).primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      final containerCustomerDetailsResponse = snapshot.data!;

                                      return Container(
                                        width: double.infinity,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                          border: Border.all(
                                            color: const Color(0xFFE7E7E8),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(17, 0, 18, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: const BorderRadius.only(
                                                      bottomLeft: Radius.circular(0),
                                                      bottomRight: Radius.circular(0),
                                                      topLeft: Radius.circular(0),
                                                      topRight: Radius.circular(0),
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/Star.png',
                                                      width: 24,
                                                      height: 24,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Text(
                                                    'My Rewards',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                      fontSize: 15,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ].divide(const SizedBox(width: 10)),
                                              ),
                                              //if(currentAuthenticationToken!.isEmpty)
                                              Text(
                                                /*'Bal: ${getJsonField(
                                                  containerCustomerDetailsResponse.jsonBody,
                                                  r'''$.data.reward_points''',
                                                ).toStringAsFixed(0)}',*/
                                                'Bal: ${formatNumber(currencyConversion(FFAppState().currencyRate,
                                                    getJsonField(
                                                      containerCustomerDetailsResponse.jsonBody,
                                                      r'''$.data.reward_points''',
                                                    ).toStringAsFixed(0)),
                                                  formatType: FormatType.decimal,
                                                  decimalType: DecimalType.automatic,
                                                )}',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: FlutterFlowTheme.of(context).primary,
                                                  fontSize: 15,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ].divide(const SizedBox(width: 10)),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                      border: Border.all(
                                        color: const Color(0xFFE7E7E8),
                                      ),
                                    ),
                                    child: Builder(builder: (_) {
                                      if (!expandableListenerRegistered) {
                                        expandableListenerRegistered = true;
                                        _model.shopbycategoryController.addListener(
                                          () async {
                                            _model.shopbycattextColor = !_model.shopbycattextColor;
                                            setState(() {});
                                          },
                                        );
                                      }
                                      return Container(
                                        width: double.infinity,
                                        color: Colors.white,
                                        child: ExpandableNotifier(
                                          controller: _model.shopbycategoryController,
                                          child: ExpandablePanel(
                                            header: Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: const BorderRadius.only(
                                                      bottomLeft: Radius.circular(0),
                                                      bottomRight: Radius.circular(0),
                                                      topLeft: Radius.circular(0),
                                                      topRight: Radius.circular(0),
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/Category.png',
                                                      width: 20,
                                                      height: 20,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Shop By Categories',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color: valueOrDefault<Color>(
                                                        _model.shopbycattextColor == true
                                                            ? FlutterFlowTheme.of(context).primaryText
                                                            : FlutterFlowTheme.of(context).primary,
                                                        FlutterFlowTheme.of(context).primaryText,
                                                      ),
                                                      fontSize: 15,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ].divide(const SizedBox(width: 10)),
                                              ),
                                            ),
                                            collapsed: Container(),
                                            expanded: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Container(
                                                width: 300,
                                                height: 210,
                                                decoration: BoxDecoration(
                                                  color: const Color(0x7FE7E7E8),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: GridView(
                                                    padding: EdgeInsets.zero,
                                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 4,
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10,
                                                      childAspectRatio: 0.65,
                                                    ),
                                                    scrollDirection: Axis.vertical,
                                                    children: [
                                                      InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            'CategoriesListViewChooseChip',
                                                            queryParameters: {
                                                              'isSelected': "false",
                                                              'defaultcategories': "Rudraksha",
                                                              'subproductslugvalue': "",
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: const Color(0x26E48D4A),
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.circular(8),
                                                                child: CachedNetworkImage(
                                                                  fadeInDuration: const Duration(milliseconds: 500),
                                                                  fadeOutDuration: const Duration(milliseconds: 500),
                                                                  imageUrl: 'https://s3.amazonaws.com/RudraCentre/CategoryThumbnail/Rudraksha/rudraksha-1-mukhi-21-mukhi-thumb.jpg',
                                                                  width: 50,
                                                                  height: 50,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Rudraksha',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  fontSize: 10,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            'CategoriesListViewChooseChip',
                                                            queryParameters: {
                                                              'isSelected': "false",
                                                              'defaultcategories': "Gemstone",
                                                              'subproductslugvalue': "",
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: const Color(0x26D96ABE),
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.circular(8),
                                                                child: CachedNetworkImage(
                                                                  fadeInDuration: const Duration(milliseconds: 500),
                                                                  fadeOutDuration: const Duration(milliseconds: 500),
                                                                  imageUrl: 'https://s3.amazonaws.com/RudraCentre/CategoryThumbnail/Gemstone/Natural-Loose-Gemstones-A.jpg',
                                                                  width: 50,
                                                                  height: 50,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Gemstones',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  fontSize: 10,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            'CategoriesListViewChooseChip',
                                                            queryParameters: {
                                                              'isSelected': "false",
                                                              'defaultcategories': "Yantras",
                                                              'subproductslugvalue': "",
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(0x26DBC93B),
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.circular(8),
                                                                child: CachedNetworkImage(
                                                                  fadeInDuration: const Duration(milliseconds: 500),
                                                                  fadeOutDuration: const Duration(milliseconds: 500),
                                                                  imageUrl: 'https://s3.amazonaws.com/RudraCentre/CategoryThumbnail/Yantra/yantras.jpg',
                                                                  width: 50,
                                                                  height: 50,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Yantras',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  fontSize: 10,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            'CategoriesListViewChooseChip',
                                                            queryParameters: {
                                                              'isSelected': "false",
                                                              'defaultcategories': "Idols",
                                                              'subproductslugvalue': "",
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: const Color(0x25755521),
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.circular(8),
                                                                child: CachedNetworkImage(
                                                                  fadeInDuration: const Duration(milliseconds: 500),
                                                                  fadeOutDuration: const Duration(milliseconds: 500),
                                                                  imageUrl: 'https://s3.amazonaws.com/RudraCentre/CategoryThumbnail/Other_Products/Brass-Idols_thumb.jpg',
                                                                  width: 50,
                                                                  height: 50,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Idols',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  fontSize: 10,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            'CategoriesListViewChooseChip',
                                                            queryParameters: {
                                                              'isSelected': "false",
                                                              'defaultcategories': "Vastu",
                                                              'subproductslugvalue': "",
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: const Color(0x266B6F8C),
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.circular(8),
                                                                child:  CachedNetworkImage(
                                                                  fadeInDuration: const Duration(milliseconds: 500),
                                                                  fadeOutDuration: const Duration(milliseconds: 500),
                                                                  imageUrl: 'https://s3.amazonaws.com/RudraCentre/CategoryThumbnail/Other_Products/Pyramid_thumb.jpg',
                                                                  width: 50,
                                                                  height: 50,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Vastu',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  fontSize: 10,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            'CategoriesListViewChooseChip',
                                                            queryParameters: {
                                                              'isSelected': "false",
                                                              'defaultcategories': "Jewellery",
                                                              'subproductslugvalue': "",
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: const Color(0x26DCC078),
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.circular(8),
                                                                child: CachedNetworkImage(
                                                                  fadeInDuration: const Duration(milliseconds: 500),
                                                                  fadeOutDuration: const Duration(milliseconds: 500),
                                                                  imageUrl: 'https://s3.amazonaws.com/RudraCentre/CategoryThumbnail/Other_Products/Mangalsutra_thumb.jpg',
                                                                  width: 50,
                                                                  height: 50,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Jewellery',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  fontSize: 10,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            'CategoriesListViewChooseChip',
                                                            queryParameters: {
                                                              'isSelected': "false",
                                                              'defaultcategories': "Puja",
                                                              'subproductslugvalue': "",
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: const Color(0x25B3342C),
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.circular(8),
                                                                child: CachedNetworkImage(
                                                                  fadeInDuration: const Duration(milliseconds: 500),
                                                                  fadeOutDuration: const Duration(milliseconds: 500),
                                                                  imageUrl: 'https://s3.amazonaws.com/RudraCentre/CategoryThumbnail/Puja/1---Maha-Pujas_88533.jpg',
                                                                  width: 50,
                                                                  height: 50,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Pujas',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  fontSize: 10,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            'CategoriesListViewChooseChip',
                                                            queryParameters: {
                                                              'isSelected': "false",
                                                              'defaultcategories': "Others",
                                                              'subproductslugvalue': "",
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: const Color(0x26366121),
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.circular(8),
                                                                child: CachedNetworkImage(
                                                                  fadeInDuration: const Duration(milliseconds: 500),
                                                                  fadeOutDuration: const Duration(milliseconds: 500),
                                                                  imageUrl:
                                                                  'https://s3.amazonaws.com/RudraCentre/Test/ProductImages/Other/fresh-puja-flowers-leaves-thumb.jpg',
                                                                  width: 50,
                                                                  height: 50,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                              Text(
                                                                'More',
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Montserrat',
                                                                  fontSize: 10,
                                                                  letterSpacing: 0,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            theme: const ExpandableThemeData(
                                              tapHeaderToExpand: true,
                                              tapBodyToExpand: false,
                                              tapBodyToCollapse: false,
                                              headerAlignment: ExpandablePanelHeaderAlignment.center,
                                              hasIcon: true,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 48.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                      border: Border.all(
                                        color: const Color(0xFFE7E7E8),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(15, 0.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(0.0),
                                              bottomRight: Radius.circular(0.0),
                                              topLeft: Radius.circular(0.0),
                                              topRight: Radius.circular(0.0),
                                            ),
                                            child: Image.asset(
                                              'assets/images/Paper.png',
                                              width: 24,
                                              height: 24,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              context.pushNamed(
                                                'ArticlesScreen',
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Articles',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    color: const Color(0xFF272728),
                                                    fontSize: 15.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ].divide(const SizedBox(width: 10.0)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                      border: Border.all(
                                        color: const Color(0xFFE7E7E8),
                                      ),
                                    ),
                                    child: Builder(builder: (_) {
                                      if (!expandableListenerRegistered) {
                                        expandableListenerRegistered = true;
                                        _model.consulatatoinexpandableExpandableController.addListener(
                                          () async {
                                            _model.textColor = !_model.textColor;
                                            setState(() {});
                                          },
                                        );
                                      }
                                      return Container(
                                        width: double.infinity,
                                        color: Colors.white,
                                        child: ExpandableNotifier(
                                          controller: _model.consulatatoinexpandableExpandableController,
                                          child: ExpandablePanel(
                                            header: Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.contacts,
                                                    color: valueOrDefault<Color>(
                                                      _model.textColor == true
                                                          ? FlutterFlowTheme.of(context).primaryText
                                                          : FlutterFlowTheme.of(context).primary,
                                                      FlutterFlowTheme.of(context).primaryText,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      context.pushNamed(
                                                        'Conslutation',
                                                        extra: <String, dynamic>{
                                                          kTransitionInfoKey: const TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType: PageTransitionType.leftToRight,
                                                            duration: Duration(milliseconds: 400),
                                                          ),
                                                        },
                                                      );
                                                    },
                                                    child: Text(
                                                      'Consultation',
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Montserrat',
                                                        color: valueOrDefault<Color>(
                                                          _model.textColor == true
                                                              ? FlutterFlowTheme.of(context).primaryText
                                                              : FlutterFlowTheme.of(context).primary,
                                                          FlutterFlowTheme.of(context).primaryText,
                                                        ),
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(const SizedBox(width: 10.0)),
                                              ),
                                            ),
                                            collapsed: Container(),
                                            expanded: Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(52.0, 5.0, 0.0, 10.0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        context.pushNamed(
                                                          'Consultationwithsakhashree',
                                                          extra: <String, dynamic>{
                                                            kTransitionInfoKey: const TransitionInfo(
                                                              hasTransition: true,
                                                              transitionType: PageTransitionType.leftToRight,
                                                              duration: Duration(milliseconds: 400),
                                                            ),
                                                          },
                                                        );
                                                      },
                                                      child: Text(
                                                        'Consultation with sakhashree',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          color: const Color(0xFF272728),
                                                          fontSize: 14.0,
                                                          letterSpacing:0.0,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        context.pushNamed(
                                                          'RudrakshaGemsRecommendationWidget',
                                                        );
                                                      },
                                                      child: Text(
                                                        'Rudraksha Gems Recommendation ',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          color: const Color(0xFF272728),
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        context.pushNamed(
                                                          'ChakraCleansingMeditationWithSakhashreeWidget',
                                                        );
                                                      },
                                                      child: Text(
                                                        'Chakra Cleansing Meditation With Sakhashree',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          color: const Color(0xFF272728),
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        context.pushNamed(
                                                          'PujaServicesRecommendationWidget',
                                                        );
                                                      },
                                                      child: Text(
                                                        'Puja Services Recommendation  ',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          color: const Color(0xFF272728),
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        context.pushNamed(
                                                          'ChakraVastuConsultationWidget',
                                                        );
                                                      },
                                                      child: Text(
                                                        'Chakra Vastu Consultation',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          color: const Color(0xFF272728),
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        context.pushNamed(
                                                          'AstrologyConsultationWidget',
                                                        );
                                                      },
                                                      child: Text(
                                                        'Astrology Consultation',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          color: const Color(0xFF272728),
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(const SizedBox(height: 16.0)),
                                                ),
                                              ),
                                            ),
                                            theme: const ExpandableThemeData(
                                              tapHeaderToExpand: true,
                                              tapBodyToExpand: false,
                                              tapBodyToCollapse: false,
                                              headerAlignment: ExpandablePanelHeaderAlignment.center,
                                              hasIcon: true,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                      border: Border.all(
                                        color: const Color(0xFFE7E7E8),
                                      ),
                                    ),
                                    child: Builder(builder: (_) {
                                      if (!expandableListenerRegistered) {
                                        expandableListenerRegistered = true;
                                        _model.expandableExpandableController.addListener(
                                          () async {
                                            _model.textColor = !_model.textColor;
                                            setState(() {});
                                          },
                                        );
                                      }
                                      return Container(
                                        width: double.infinity,
                                        color: Colors.white,
                                        child: ExpandableNotifier(
                                          controller: _model.expandableExpandableController,
                                          child: ExpandablePanel(
                                            header: Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.info_outline,
                                                    color: valueOrDefault<Color>(
                                                      _model.textColor == true
                                                          ? FlutterFlowTheme.of(context).primaryText
                                                          : FlutterFlowTheme.of(context).primary,
                                                      FlutterFlowTheme.of(context).primaryText,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Brand Info',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color: valueOrDefault<Color>(
                                                        _model.textColor == true
                                                            ? FlutterFlowTheme.of(context).primaryText
                                                            : FlutterFlowTheme.of(context).primary,
                                                        FlutterFlowTheme.of(context).primaryText,
                                                      ),
                                                      fontSize: 15.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ].divide(const SizedBox(width: 10.0)),
                                              ),
                                            ),
                                            collapsed: Container(),
                                            expanded: Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(52.0, 5.0, 0.0, 10.0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        context.pushNamed(
                                                          'TestimonialsWidget',
                                                        );
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Testimonials',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: const Color(0xFF272728),
                                                              fontSize: 14.0,
                                                              letterSpacing: 0.0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        context.pushNamed(
                                                          'CareersWidget',
                                                        );
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Careers',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: const Color(0xFF272728),
                                                              fontSize: 14.0,
                                                              letterSpacing: 0.0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        context.pushNamed('OurTeam');
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Our Team',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: const Color(0xFF272728),
                                                              fontSize: 14.0,
                                                              letterSpacing: 0.0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        context.pushNamed('ContactUsWidget');
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Contact Us',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: const Color(0xFF272728),
                                                              fontSize: 14.0,
                                                              letterSpacing: 0.0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        context.pushNamed('AboutusWidget');
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'About Us',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: const Color(0xFF272728),
                                                              fontSize: 14.0,
                                                              letterSpacing: 0.0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    InkWell(
                                                      splashColor: Colors.transparent,
                                                      focusColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      onTap: () async {
                                                        context.pushNamed(
                                                          'PolicyWidget',
                                                          extra: <String, dynamic>{
                                                            kTransitionInfoKey: const TransitionInfo(
                                                              hasTransition: true,
                                                              transitionType: PageTransitionType.rightToLeft,
                                                              duration: Duration(milliseconds: 400),
                                                            ),
                                                          },
                                                        );
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Policy',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: const Color(0xFF272728),
                                                              fontSize: 14.0,
                                                              letterSpacing: 0.0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    InkWell(
                                                      splashColor: Colors.transparent,
                                                      focusColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      onTap: () async {
                                                        context.pushNamed(
                                                          'DisclaimerWidget',
                                                          extra: <String, dynamic>{
                                                            kTransitionInfoKey: const TransitionInfo(
                                                              hasTransition: true,
                                                              transitionType: PageTransitionType.rightToLeft,
                                                              duration: Duration(milliseconds: 400),
                                                            ),
                                                          },
                                                        );
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Disclaimer',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: 'Montserrat',
                                                              color: const Color(0xFF272728),
                                                              fontSize: 14.0,
                                                              letterSpacing: 0.0,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ].divide(const SizedBox(height: 16.0)),
                                                ),
                                              ),
                                            ),
                                            theme: const ExpandableThemeData(
                                              tapHeaderToExpand: true,
                                              tapBodyToExpand: false,
                                              tapBodyToCollapse: false,
                                              headerAlignment: ExpandablePanelHeaderAlignment.center,
                                              hasIcon: true,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('App Version: 1.0.19',
                            style: TextStyle(color: FlutterFlowTheme.of(context).productName)),
                      ),
                      Builder(
                        builder: (context) {
                          if (currentAuthenticationToken != null && currentAuthenticationToken != '') {
                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () => _model.unfocusNode.canRequestFocus
                                          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                          : FocusScope.of(context).unfocus(),
                                      child: Padding(
                                        padding: MediaQuery.viewInsetsOf(context),
                                        child: const LogoutConfirmationWidget(),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.065,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                  border: Border.all(
                                    color: const Color(0xFFE7E7E8),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(18, 0, 20, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0),
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                            ),
                                            child: Image.asset(
                                              'assets/images/Logout.png',
                                              width: 19.04,
                                              height: 18.5,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Text(
                                            'Logout',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              color: const Color(0xFF272728),
                                              fontSize: 15,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ].divide(const SizedBox(width: 10)),
                                      ),
                                      FutureBuilder<ApiCallResponse>(
                                        future: CurrencyCall.call(sanityurl: FFAppConstants.sanityurl),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return const Center(
                                              child: SizedBox(
                                                width: 25,
                                                child: SizedBox(
                                                  height: 25.0,
                                                  child: ShimmerWidget(),
                                                ),
                                              ),
                                            );
                                          }

                                          /*final currencyDropDownCurrencyResponse = snapshot.data!;
                                          //currency_rate = getJsonField(currencyDropDownCurrencyResponse.jsonBody, r'''$.currency_data''', true);
                                          final currencyData = (getJsonField(
                                            currencyDropDownCurrencyResponse.jsonBody,
                                            r'''$.currency_data''',
                                            true,
                                          ) as List<dynamic>).map((item) {
                                            return {
                                              'currency_type': item['currency_type'],
                                              'image': item['image'],
                                            };
                                          }).toList();

                                          // Ensure that FFAppState().currencyName has the value or use default
                                          final selectedCurrency = FFAppState().currencyName ?? 'INR';*/

                                          final selectedCurrency = FFAppState().currencyName ?? 'INR';

                                          return CustomDropdown(
                                            items: currencyData!,
                                            initialValue: selectedCurrency,
                                            onChanged: (val) async {
                                              setState(() {
                                                _model.currencyDropDownValue = val;
                                              });
                                              FFAppState().currencyName = _model.currencyDropDownValue!;
                                              FFAppState().currencyRate = functions.currencyRateByName(
                                                  getJsonField(
                                                    cachedCurrencyResponse!.jsonBody,
                                                    r'''$.currency_data''',
                                                    true,
                                                  )!,
                                                  FFAppState().currencyName)!;
                                              setState(() {
                                                print('Selected Currency Name: ${FFAppState().currencyName}');
                                                print('Selected Currency Rate: ${FFAppState().currencyRate}');
                                              });
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  'LoginPage',
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: const TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.bottomToTop,
                                      duration: Duration(milliseconds: 400),
                                    ),
                                  },
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.052,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                  border: Border.all(
                                    color: const Color(0xFFE7E7E8),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(18, 0, 20, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.login_rounded,
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            size: 24,
                                          ),
                                          Text(
                                            'Login',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              color: const Color(0xFF272728),
                                              fontSize: 15,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ].divide(const SizedBox(width: 10)),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (currencyData == null)
                                            const Center(
                                              child: SizedBox(
                                                width: 25,
                                                child: SizedBox(
                                                  height: 25.0,
                                                  child: ShimmerWidget(),
                                                ),
                                              ),
                                            )
                                          else
                                            Builder(
                                              builder: (context) {
                                                final locale = Localizations.localeOf(context);
                                                final countryCode = locale.countryCode ?? 'IN'; // Default to 'IN' if countryCode is null

                                                // Determine initial currency based on country code
                                                String initialCurrency = currencyData!.firstWhere(
                                                      (item) => item['currency_type'].toString().contains(countryCode),
                                                  orElse: () => {'currency_type': 'INR'},
                                                )['currency_type'];

                                                // Ensure that FFAppState().currencyName has the value or use initialCurrency
                                                final selectedCurrency = FFAppState().currencyName ?? initialCurrency;

                                                return CustomDropdown(
                                                  items: currencyData!,
                                                  initialValue: selectedCurrency,
                                                  onChanged: (val) async {
                                                    setState(() {
                                                      _model.currencyDropDownValue = val;
                                                    });
                                                    FFAppState().currencyName = _model.currencyDropDownValue!;
                                                    FFAppState().currencyRate = functions.currencyRateByName(
                                                        getJsonField(
                                                          cachedCurrencyResponse!.jsonBody,
                                                          r'''$.currency_data''',
                                                          true,
                                                        )!,
                                                        FFAppState().currencyName)!;
                                                    setState(() {
                                                      print('Selected Currency Name: ${FFAppState().currencyName}');
                                                      print('Selected Currency Rate: ${FFAppState().currencyRate}');
                                                    });
                                                  },
                                                );
                                              },
                                            ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 90.0, 0.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 32.0,
                      decoration: const BoxDecoration(
                        color: Color(0x34740074),
                      ),
                      child: const SizedBox(
                        width: double.infinity,
                        height: 32.0,
                        child: custom_widgets.MarqueeText(
                          width: double.infinity,
                          height: 32.0,
                          text: 'Worldwide Fast & Safe Delivery | Oldest ISO 9001-2015 certified rudraksha organization in the world | Your Trusted Brand Since 1997.                                      ',
                          speed: 100,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 380,
                        height: 300,
                        decoration: const BoxDecoration(),
                        child: FutureBuilder<ApiCallResponse>(
                          future: EncryptedBannercall.call(
                            sanityurl: FFAppConstants.sanityurl,
                          ),
                          /*future: Bannercall.call(
                            sanityurl: FFAppConstants.sanityurl,
                          ),*/
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            final carouselExploreCategoryListResponse = snapshot.data!;
                            final encryptedApiResponse = carouselExploreCategoryListResponse.bodyText;
                            print("encryptedApiResponse errtr:$encryptedApiResponse");
                            print("carouselExploreCategoryListResponse errtr:$carouselExploreCategoryListResponse");

                            return Builder(
                              builder: (context) {
                                /*final Bannercall = getJsonField(
                                  carouselExploreCategoryListResponse.jsonBody,
                                  r'''$.data''',
                                ).toList();*/

                                final encryptedApiResponse = carouselExploreCategoryListResponse.jsonBody;

                                const farnetkey = 'D3KyP1sPstZZa4Yf2u0E0unfXgR9L5s2iIpoU-W5_Yc=';

                                const inputtext = 'gAAAAABm_9OP_V1QJjh3B5vjdBPvwvLcJT9gzGJ1i-Sa9rackEDGy8HiaSTpVgZOYx8zX7ykqPj7DXlbu3kNN4mIev6km-5SPKX87z9wE4tZJhN_YE9S2ksLpCpOM5OMofC1cq-CP2eX3pFw-m2lP82Nn-9Ut6q458vCgNRaeRnhQwr_T1TvJ2_WflDpDCRaCnO9DkFrUpOmWzgVuI4G5WIbMN4LejRqNApi01VH44paOEMwmkeuvHgqmCWlsRd6S1zzv06fOoilpl0pDot3DrR7LH-NJKED402xMt2EfGStNsY4SWlGVC30AbNqelv_Ag098wpTF93KvZNCzHyuW1McMlkWvTgTntocRsKMQGx9W0bkuT7X2dLkR3SmeRn_6M2vX79tLmKGBi1Gcoj0WX-sv_EDK-ufgM1SaAANXJYhYis1PcrurnZC8jIok8zjp4eEhU3WdVBGZtIFrFaEkeErfVVrJio-cvZKAyEZnnIT4ttCI0UmlJrpcYA4mv8_z1gVzpWANNVUkQTRevS_4-hXAyUfavLUvern0JEq4ufKcx8rOtPxLIP5vczUBIUS-RxWtW6Qe7Fv-vle7GkTE2zkPyfJImTV9ilLnATAeGRvxVF3xH5yjVO6VykH2oZ8wjXpM1Virwy4Zh3iiKArSvo6yIiS31Vqr56imGYeWYUgHBN8tc_OFuJqAjIG3klaBxxb1EpPZgALKRWFBKuOhfRoezTuEkhYlqlViT_dZ61k9EHVp31fIpRXOy1YV7zGIrutl_IaiRfZ-l8YZ9UYaMoN0q76TsFVs_x76k3LFF4g-0Z2ZGrsWyRb6O8bNQZybNWNwlAObwCnyYv3Ewoa5vGxckoFnN5A3oT2xrOcw9-nLmNWEtMVRnrctNNL53dw7g3MDzw9a_jXdmNXBL4X7AUQa_JdHZbdMDOQIpz5ynWKvYjsj3CiomZTa8ssMWXbf0V50PWR-c6xLSBv2c5mhilDqJE7pmWSNZlSK6Z15g_qOZppopp_a_d-e2689x4AguzL7tWAB1ZMQS41ZRKKP292eARgTWGE_CJrk1jhRma2bMBoqosuq801aWES5IKgbGoJOvc4sRe6-y6HtyV3Ttp8iPgCnyBk8Ep3ar5YMQzyQV6ZISNMoqZxW_hFzdIL5AmifisOYr5PAt9eKDOKKZnZoLskQ96-gPpMASFGhLlk7N-RQeChWjaSdKTlgU2G7Fic4oJXixBHsHSZAJCuTMF4li26rIsFq_y2iOLGUO7VDjoiZeAm3vTDAGBmcKGpBNc2wESmd6IyPHeGeASV57E34HRbss6QOSnbFWOupCyhVTxmPEJbZxJNOqnzinZUhKQvfmpDw4LuKAeXCF6eciZeXUlZIifaN7MVYEB86TmFV24kC0mBynv1EkjVns9yr3JAXFhCwDarO1cnGWfWcc6xTL5yI8kxj1sYnPiLZxaLJmJDhU52PrSI0CDuF4dBPxr9o4AAEV5SJdV9yeH-TZPm7e_xjhtzg1IwvYdaDCugS1zHDGb29X76PB_vhSpqm1JW0M8GbgQmabTdRbqwN0VwQacAXTKP6SnNJLKnmb-WdLIfUlzbUsEHUjmCz4NsCzSrRNIHSzq2v5cLeyDuaD-42Zxv1EEaF6NnqyV9BPxz8S0sLv5h4ABxNLBUR715qeTZw-Dqy5_Zr5h3ljVOE_ZMvr00kAVKfyiQppC74jhfjLtYwb4IuqiRqsujcVWVsgdGknjkWpwcROkTjO3VbTlk0TRa5vS5E-FkZ3bC5JM9Cl9Dg8lK0Tz_CRdIAJGTgTfOTexLiqGcy3FEVsTY70iRq267hIa7AnzdQkubpb9fF7VXmNdfUKkupQg6ILWFWBUrhTIsf7zN-TIliBf-s4CyIB8rmRz0vgeVdCPUgacdU2kDwINsvGe3e3jV6nkME6sRaNX3MBL6rR1OORRugF0qlJ8_CxAZwlm_v_10s7qjA3cm9q983BHqtsBLHiNFA8p_nk0v2kvlTwfzcmZ2ldAoz8W5iToUjpzW3HmXf4dx3HVGMU3g2j8M2aqVtcsdMhoE7Jub0HCzx8wgMjpt3VJ8TzxVT3EROzzNODe6lJdrDwtMYXM7eyukh0O_R7dnPpKBSc1CrXZe-_U_1VmoN-icgEDP-tlU-urnbZw4O6ikjFjmMCmIr6yjoFrcBe9dpgIZDAukz9fX2ttDpjvvDDANbGMZW-NQ4O7pUFBrh9acs3kb6hqF30cIO59NgHfwy8lvNLmnqfy8F94VJCKtvd-EMNmxd5QvCWB6FkmiZtI_J9moVVClM_1G9VgRIGzk1hCXvy1qnC56IYbgCmdu1uahAT0htWLESp9d7_pm55G4Xis4jsK0rOIeixbtOS6gejujP5xU1eV54v8VdxSIcE-CRyZAYbrSDBBNKL35Qxdv-_r3yePVkz5vlnGIblmf7Pz9UM7t-kv6G2EBquhdp6NhGxb_mS-ZCrXuN2G0sBZfapqkCkdta5Q0QglHe0eZAf_Fa3VGkps6nEwzZ4IZLG-eKiEm0ws3xf_bzshTLawZoaHz_T8NClskdrDRgv_3DRKufO1DGzeqt3HzGv914zTnUy__fwJj1qUauj2x6opCKlclEbcOm_i6u9EBe6aHWyOX5yCs5QgwZR2ii9nLWwFh5Tp3qChAJJmZ0_5sk4i3-UUadYRXt2Vg7qH0mGbOSDepeARYHpw7f8_gbVeNO3YtPUo-yGty9y0w-davJgfbwUBm-oFGEqIWgqQx4o6SCl14l9QVc1EKTJniu8KeIyZ3_d7zjSdvwVGUeLZWO8D1EflV3gAXLE-JG2QwVzA0Ylt_EUnoURzyovC15UKtSw0NDZhdv8HyTgs3BFAqCiSbpWV3H6aC_m3NWqS7LEHtBHuB1cwScqxwFMjWBU5sgpb2lqA-t8CC5DytFlac74iubc2r4ffdrsiGnO6ER3YhddeOZ2gIsUemFa4-4t4HyKGAOMhV1QSdCVqbgCrChIOyiAQZuwIEPh9hYcOm2zV9meFfPILpZ_EE0uqysPnYbVEQWu-LS0tCgPL6a9ELtlkqieu868gDGmSmiA9ANhpacKGCN6fAr58dWXGyBCrB6Bsz7q1wLZ4WOXiURvY7QTf-oiTB_0WFGw_5JxCQEnV8_vcyckcJHNsIrUV7fnYQQB5-RVGJXdKFzayy2VLwdcUl81cUC4u-9TrfoFibBcdRYQ8y2LWxqVlay_DDXyoWeWRbPBo7PriahdvfgZf6HkMyLVOlbmfFs_3QUhwJzntjcdAhurRfx-2N';

                                final key = encrypt.Key.fromBase64(farnetkey);

                                final b64key = encrypt.Key.fromBase64(base64Url.encode(key.bytes));

                                final fernet = encrypt.Fernet(b64key);

                                final encrypter = encrypt.Encrypter(fernet);

                                final Bannercalls = encrypter.decrypt64(encryptedApiResponse);

                                if (kDebugMode) {
                                  print("Bannercall errtr:${Bannercalls}");
                                }

                                String correctedBannercall = Bannercalls
                                    .replaceAll("'", '"')  // Replace single quotes with double quotes
                                    .replaceAll("False", "false")
                                    .replaceAll("True", "true");

                                // Parse the corrected JSON string into a Map
                                final Map<String, dynamic> bannerData = json.decode(correctedBannercall);
                                final List<dynamic> Bannercall = bannerData['data'];

                                return CarouselSlider.builder(
                                  itemCount: Bannercall.length,
                                  itemBuilder: (context, testimonialsIndex, _) {
                                    final BannerItem = Bannercall[testimonialsIndex];
                                    return Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                                      child: Material(
                                        color: Colors.transparent,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.slugvalue = getJsonField(
                                              BannerItem, r'''$.slug_value''',
                                            ).toString();
                                            setState(() {});
                                            _model.apiResulth6o = await SlugSearchCall.call(
                                              hosturl: FFAppConstants.hosturl,
                                              slugValue: getJsonField(
                                                BannerItem, r'''$.slug_value''',
                                              ).toString(),
                                            );
                                            _model.mainprodtype = SlugSearchCall.datamainprodtype(
                                              (_model.apiResulth6o?.jsonBody ?? ''),
                                            );
                                            _model.level = SlugSearchCall.datalevel(
                                              (_model.apiResulth6o?.jsonBody ?? ''),
                                            );
                                            _model.productlist = SlugSearchCall.dataproductlist(
                                              (_model.apiResulth6o?.jsonBody ?? ''),
                                            )!;
                                            setState(() {
                                              print("_model.mainprodtype${_model.mainprodtype}");
                                              print("_model.level${_model.level}");
                                              print("_model.productlist${_model.productlist}");
                                            });
                                            if (_model.mainprodtype == 5 &&
                                                _model.level == 1 && _model.slugvalue == "c/rudraksha") {
                                              context.pushNamed(
                                                'CategoriesListViewChooseChip',
                                                queryParameters: {
                                                  'isSelected': "false",
                                                  'defaultcategories': "Rudraksha",
                                                  'subproductslugvalue': "",
                                                },
                                              );
                                            } else if (_model.mainprodtype == 5 &&
                                                _model.level == 1 && _model.slugvalue == "c/chakra-vastu") {
                                              context.pushNamed(
                                                'CategoriesListViewChooseChip',
                                                queryParameters: {
                                                  'isSelected': "false",
                                                  'defaultcategories': "Vastu",
                                                  'subproductslugvalue': "",
                                                },
                                              );
                                            } else if (_model.mainprodtype == 5 &&
                                                _model.level == 1 && _model.slugvalue == "c/online-puja-services") {
                                              context.pushNamed(
                                                'CategoriesListViewChooseChip',
                                                queryParameters: {
                                                  'isSelected': "false",
                                                  'defaultcategories': "Puja",
                                                  'subproductslugvalue': "",
                                                },
                                              );
                                            } else if (_model.mainprodtype == 5 &&
                                                _model.level == 1 && _model.slugvalue == "c/yantras-and-mahayantras") {
                                              context.pushNamed(
                                                'CategoriesListViewChooseChip',
                                                queryParameters: {
                                                  'isSelected': "false",
                                                  'defaultcategories': "Yantras",
                                                  'subproductslugvalue': "",
                                                },
                                              );
                                            } else if (_model.mainprodtype == 5 &&
                                                _model.level == 1 && _model.slugvalue == "p/shaligram") {
                                              context.pushNamed(
                                                'CategoriesListViewChooseChip',
                                                queryParameters: {
                                                  'isSelected': "true",
                                                  'defaultcategories': "Others",
                                                  'subproductslugvalue': "p/shaligram",
                                                },
                                              );
                                            } else if (_model.mainprodtype == 2 &&
                                                _model.level == 2 &&
                                                _model.slugvalue == "p/natural-jyotish-gemstones") {
                                              context.pushNamed(
                                                'CategoriesListViewChooseChip',
                                                queryParameters: {
                                                  'isSelected': "true",
                                                  'defaultcategories': "Gemstone",
                                                  'subproductslugvalue': "p/natural-jyotish-gemstones",
                                                },
                                              );
                                            } else if (_model.mainprodtype == 1 &&
                                                _model.level == 4 && _model.slugvalue == "buy/maha-shivratri-mahapuja") {
                                              context.pushNamed(
                                                'PujaProductDetails',
                                                queryParameters: {
                                                  'productSlugValue': _model.slugvalue,
                                                  'producttype': FFAppConstants.PujaMasterProductDetailsApi,
                                                }.withoutNulls,
                                              );
                                            }
                                          },
                                          child: Align(
                                            alignment: const AlignmentDirectional(-1.98, 0.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(5.0),
                                              child: Image.network(
                                                //getJsonField(BannerItem, r'''$.mobileimage''').toString(),
                                                getJsonField(BannerItem, r'''$.mobileimage''').toString(),
                                                width: 720,
                                                height: 950,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  carouselController: _model.carouselController ??= slider.CarouselSliderController(),
                                  options: CarouselOptions(
                                    initialPage: max(0,
                                      min(valueOrDefault<int>(
                                          _model.countControllerValue, 0,
                                        ),
                                        Bannercall.length - 1,
                                      ),
                                    ),
                                    viewportFraction: 0.8,
                                    disableCenter: true,
                                    enlargeCenterPage: true,
                                    enlargeFactor: 0.15,
                                    enableInfiniteScroll: true,
                                    scrollDirection: Axis.horizontal,
                                    autoPlay: true,
                                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                    autoPlayInterval: const Duration(milliseconds: 4800),
                                    autoPlayCurve: Curves.linear,
                                    pauseAutoPlayInFiniteScroll: true,
                                    onPageChanged: (index, _) => _model.carouselCurrentIndex = index,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        //height: 380.0,
                        height: MediaQuery.of(context).size.height * 0.45,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Explore Products',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: const Color(0xFF740074),
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'CategoriesListViewChooseChip',
                                      queryParameters: {
                                        'isSelected': "false",
                                        'defaultcategories': "Rudraksha",
                                        'subproductslugvalue': "",
                                      },
                                    );
                                  },
                                  child: Text(
                                    'See all',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                    color: const Color(0xFF696969),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  ),
                                ),
                              ],
                            ),
                            /*FutureBuilder<ApiCallResponse>(
                              future: ExploreCategoryListCall.call(
                                sanityurl: FFAppConstants.sanityurl,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return const SizedBox(
                                    height: 25.0,
                                    child: ShimmerWidget(),
                                  );
                                }
                                final choiceChipsExploreCategoryListResponse = snapshot.data!;
                                return FlutterFlowChoiceChips(
                                  options: (getJsonField(
                                    choiceChipsExploreCategoryListResponse.jsonBody,
                                    r'''$.categorydata[:].category''', true,
                                  ) as List)
                                      .map<String>((s) => s.toString())
                                      .toList()
                                      .map((label) => ChipData(label))
                                      .toList(),
                                  onChanged: (val) async {
                                    setState(() => _model.choiceChipsValue = val?.firstOrNull);
                                    _model.iD = functions.chipsId(
                                        _model.choiceChipsValue!,
                                        getJsonField(
                                          choiceChipsExploreCategoryListResponse.jsonBody,
                                          r'''$.categorydata''', true,
                                        )!)!;
                                    setState(() {});
                                  },
                                  selectedChipStyle: ChipStyle(
                                    backgroundColor: Colors.white,
                                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).primary,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    iconColor: const Color(0x00000000),
                                    iconSize: 18.0,
                                    labelPadding: const EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                                    elevation: 0.0,
                                    borderColor: FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  unselectedChipStyle: ChipStyle(
                                    backgroundColor: Colors.white,
                                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: const Color(0xFF222222),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    iconColor: const Color(0x00000000),
                                    iconSize: 18.0,
                                    labelPadding: const EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                                    elevation: 0.0,
                                    borderColor: const Color(0xFF868687),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  chipSpacing: 12.0,
                                  rowSpacing: 12.0,
                                  multiselect: false,
                                  initialized: _model.choiceChipsValue != null,
                                  alignment: WrapAlignment.start,
                                  controller: _model.choiceChipsValueController ??= FormFieldController<List<String>>(['Rudraksha'],
                                  ),
                                  wrapped: false,
                                );
                              },
                            ),*/
                            FutureBuilder<ApiCallResponse>(
                              future: ExploreCategoryListCall.call(
                                sanityurl: FFAppConstants.sanityurl,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const SizedBox(
                                    height: 25.0,
                                    child: ShimmerWidget(),
                                  );
                                }

                                if (!snapshot.hasData) {
                                  log('No data received from API call');
                                  return const Text('No data available');
                                }

                                final choiceChipsExploreCategoryListResponse = snapshot.data!;
                                final jsonBody = choiceChipsExploreCategoryListResponse.jsonBody;

                                // Check if the API response indicates a failure
                                if (getJsonField(jsonBody, r'''$.status''') == 'failed') {
                                  final errorMsg = getJsonField(jsonBody, r'''$.msg''')?.toString() ?? 'Unknown error';
                                  log('API error: $errorMsg');
                                  return Text('Error: $errorMsg'); // Display error message
                                }

                                // Process the data if valid
                                return FlutterFlowChoiceChips(
                                  options: (getJsonField(
                                    jsonBody,
                                    r'''$.categorydata[:].category''',
                                    true,
                                  ) as List)
                                      .map<String>((s) => s.toString())
                                      .toList()
                                      .map((label) => ChipData(label))
                                      .toList(),
                                  onChanged: (val) async {
                                    setState(() => _model.choiceChipsValue = val?.firstOrNull);
                                    _model.iD = functions.chipsId(
                                      _model.choiceChipsValue!,
                                      getJsonField(
                                        jsonBody,
                                        r'''$.categorydata''',
                                        true,
                                      )!,
                                    )!;
                                    setState(() {});
                                  },
                                  selectedChipStyle: ChipStyle(
                                    backgroundColor: Colors.white,
                                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).primary,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    iconColor: const Color(0x00000000),
                                    iconSize: 18.0,
                                    labelPadding: const EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                                    elevation: 0.0,
                                    borderColor: FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  unselectedChipStyle: ChipStyle(
                                    backgroundColor: Colors.white,
                                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: const Color(0xFF222222),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    iconColor: const Color(0x00000000),
                                    iconSize: 18.0,
                                    labelPadding: const EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                                    elevation: 0.0,
                                    borderColor: const Color(0xFF868687),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  chipSpacing: 12.0,
                                  rowSpacing: 12.0,
                                  multiselect: false,
                                  initialized: _model.choiceChipsValue != null,
                                  alignment: WrapAlignment.start,
                                  controller: _model.choiceChipsValueController ??= FormFieldController<List<String>>(['Rudraksha']),
                                  wrapped: false,
                                );
                              },
                            ),

                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FutureBuilder<ApiCallResponse>(
                                        future: ExploreProductsCall.call(
                                          sanityurl: FFAppConstants.sanityurl,
                                          id: valueOrDefault<String>(_model.iD, '8',),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return const SizedBox(
                                              width: 160,
                                              //height: 292,
                                              child: ShimmerWidget(),
                                            );
                                          }
                                          final listViewExploreProductsResponse = snapshot.data!;

                                          return Builder(
                                            builder: (context) {
                                              final productsList = getJsonField(
                                                listViewExploreProductsResponse.jsonBody,
                                                r'''$.data''',
                                              ).toList();

                                              // Sort the list
                                              productsList.sort((a, b) {
                                                // Check for reserved field first
                                                if (getJsonField(a, r'''$.reserved''').toString() == 'true' &&
                                                    getJsonField(b, r'''$.reserved''').toString() == 'false') {
                                                  return -1;
                                                } else if (getJsonField(a, r'''$.reserved''').toString() == 'false' &&
                                                    getJsonField(b, r'''$.reserved''').toString() == 'true') {
                                                  return 1;
                                                }

                                                // If both have the same reserved status, check the out_of_stock field
                                                if (getJsonField(a, r'''$.out_of_stock''').toString() == 'true' &&
                                                    getJsonField(b, r'''$.out_of_stock''').toString() == 'false') {
                                                  return 1;
                                                } else if (getJsonField(a, r'''$.out_of_stock''').toString() == 'false' &&
                                                    getJsonField(b, r'''$.out_of_stock''').toString() == 'true') {
                                                  return -1;
                                                }

                                                // If neither condition above applies, maintain the original order
                                                return 0;
                                              });

                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                itemCount: productsList.length,
                                                separatorBuilder: (_, __) => const SizedBox(width: 10),
                                                itemBuilder: (context, productsListIndex) {
                                                  final productsListItem = productsList[productsListIndex];
                                                  return InkWell(
                                                    splashColor: Colors.transparent,
                                                    focusColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap: () async {
                                                      //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsWidget( productSlugValue: _model.productslugvalue,)));

                                                      _model.apiResulth6o = await SlugSearchCall.call(
                                                        hosturl: FFAppConstants.hosturl,
                                                        slugValue: getJsonField(
                                                          productsListItem,
                                                          r'''$.slug_value''',
                                                        ).toString(),
                                                      );
                                                      _model.mainprodtype = SlugSearchCall.datamainprodtype(
                                                        (_model.apiResulth6o?.jsonBody ?? ''),
                                                      );
                                                      _model.level = SlugSearchCall.datalevel(
                                                        (_model.apiResulth6o?.jsonBody ?? ''),
                                                      );
                                                      _model.productlist = SlugSearchCall.dataproductlist(
                                                        (_model.apiResulth6o?.jsonBody ?? ''),
                                                      )!;
                                                      setState(() {
                                                        print("_model.mainprodtype${_model.mainprodtype}");
                                                        print("_model.level${_model.level}");
                                                        print("_model.productlist${_model.productlist}");
                                                      });
                                                      if (_model.mainprodtype == 5) {
                                                        context.pushNamed(
                                                          'OtherProductDetails',
                                                          queryParameters: {
                                                            'productSlugValue': serializeParam(
                                                              getJsonField(
                                                                productsListItem,
                                                                r'''$.slug_value''',
                                                              ).toString(),
                                                              ParamType.String,
                                                            ),
                                                            'outofstockValue': serializeParam(
                                                              getJsonField(
                                                                productsListItem,
                                                                r'''$.out_of_stock''',
                                                              ).toString(),
                                                              ParamType.String,
                                                            ),
                                                          }.withoutNulls,
                                                          extra: <String, dynamic>{
                                                            kTransitionInfoKey: const TransitionInfo(
                                                              hasTransition: true,
                                                              transitionType: PageTransitionType.bottomToTop,
                                                            ),
                                                          },
                                                        );
                                                      } else if (_model.mainprodtype == 3) {
                                                        context.pushNamed(
                                                          'DiamondProductDetails',
                                                          queryParameters: {
                                                            'productSlugValue': serializeParam(
                                                              getJsonField(
                                                                productsListItem,
                                                                r'''$.slug_value''',
                                                              ).toString(),
                                                              ParamType.String,
                                                            ),
                                                            'producttype': FFAppConstants.RudrakshaMasterProductDetailsApi,
                                                          }.withoutNulls,
                                                          extra: <String, dynamic>{
                                                            kTransitionInfoKey: const TransitionInfo(
                                                              hasTransition: true,
                                                              transitionType: PageTransitionType.bottomToTop,
                                                              duration: Duration(milliseconds: 400),
                                                            ),
                                                          },
                                                        );
                                                      } else if (_model.mainprodtype == 4) {
                                                        context.pushNamed(
                                                          'YantraProductDetails',
                                                          queryParameters: {
                                                            'productSlugValue': serializeParam(
                                                              getJsonField(productsListItem,
                                                                r'''$.slug_value''',).toString(),
                                                              ParamType.String,
                                                            ),
                                                            'producttype': FFAppConstants.PujaMasterProductDetailsApi,
                                                          }.withoutNulls,
                                                        );
                                                      }else if (_model.mainprodtype == 1) {
                                                        context.pushNamed(
                                                          'PujaProductDetails',
                                                          queryParameters: {
                                                            'productSlugValue': serializeParam(
                                                              getJsonField(productsListItem,
                                                                r'''$.slug_value''',).toString(),
                                                              ParamType.String,
                                                            ),
                                                            'producttype': FFAppConstants.YantraMasterProductDetailsApi,
                                                          }.withoutNulls,
                                                        );
                                                      } else {
                                                        context.pushNamed(
                                                          'DiamondProductDetails',
                                                          queryParameters: {
                                                            'productSlugValue': serializeParam(
                                                              getJsonField(productsListItem,
                                                                r'''$.slug_value''',).toString(),
                                                              ParamType.String,
                                                            ),
                                                            'producttype': FFAppConstants.GemstoneMasterProductDetailsApi,
                                                          }.withoutNulls,
                                                          extra: <String, dynamic>{
                                                            kTransitionInfoKey: const TransitionInfo(
                                                              hasTransition: true,
                                                              transitionType: PageTransitionType.bottomToTop,
                                                              duration: Duration(milliseconds: 400),
                                                            ),
                                                          },
                                                        );
                                                      }
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          //height: 300,
                                                          width: 200,
                                                          decoration: BoxDecoration(
                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                            borderRadius: const BorderRadius.only(
                                                              bottomLeft: Radius.circular(0),
                                                              bottomRight: Radius.circular(0),
                                                              topLeft: Radius.circular(16),
                                                              topRight: Radius.circular(16),
                                                            ),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                                                                child: ClipRRect(
                                                                    borderRadius: const BorderRadius.only(
                                                                    bottomLeft: Radius.circular(16),
                                                                    bottomRight: Radius.circular(16),
                                                                    topLeft: Radius.circular(16),
                                                                    topRight: Radius.circular(16),
                                                                  ),
                                                                  child: Stack(
                                                                    children: [
                                                                      CachedNetworkImage(
                                                                        fadeInDuration: const Duration(milliseconds: 100),
                                                                        fadeOutDuration: const Duration(milliseconds: 100),
                                                                        imageUrl: getJsonField(productsListItem, r'''$.thumbnail''',).toString(),
                                                                        //height: 198,
                                                                        height: MediaQuery.of(context).size.height * 0.24,
                                                                        width: MediaQuery.of(context).size.width,
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                      if (getJsonField(productsListItem, r'''$.out_of_stock''').toString() == 'true')
                                                                        Align(
                                                                          alignment: const AlignmentDirectional(-1, -1),
                                                                          child: Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                                                                            child: Container(
                                                                              decoration: const BoxDecoration(
                                                                                color: Colors.red,
                                                                                borderRadius: BorderRadius.only(
                                                                                  topRight: Radius.circular(12),
                                                                                  bottomRight: Radius.circular(12),
                                                                                ),
                                                                              ),
                                                                              child: const Padding(
                                                                                padding: EdgeInsets.all(5.0),
                                                                                child: Text(
                                                                                  "OUT OF STOCK",
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      if (getJsonField(productsListItem, r'''$.reserved''').toString() == 'true')
                                                                        Align(
                                                                          alignment: const AlignmentDirectional(-1, -1),
                                                                          child: Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                                                                            child: Container(
                                                                              decoration: const BoxDecoration(
                                                                                color: Colors.green,
                                                                                borderRadius: BorderRadius.only(
                                                                                  topRight: Radius.circular(12),
                                                                                  bottomRight: Radius.circular(12),
                                                                                ),
                                                                              ),
                                                                              child: const Padding(
                                                                                padding: EdgeInsets.all(5.0),
                                                                                child: Text(
                                                                                  "RESERVED",
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisSize: MainAxisSize.max,
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  Align(
                                                                    alignment: const AlignmentDirectional(-1, 0),
                                                                    child: Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                                                      child: Text(
                                                                        getJsonField(productsListItem,
                                                                          r'''$.productname''').toString(),
                                                                        maxLines: 2,
                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                          fontFamily: 'Montserrat',
                                                                          color: FlutterFlowTheme.of(context).Productnamecolor,
                                                                          fontSize: 15,
                                                                          letterSpacing: 0,
                                                                          lineHeight: 1.5,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment: const AlignmentDirectional(-1, 0),
                                                                    child: Container(
                                                                      //height: 32,
                                                                      child: Text('${valueOrDefault<String>(FFAppState().currencyName, 'INR')} ${formatPriceRange(
                                                                          getJsonField(productsListItem, r'''$.selling_price''').toString(),
                                                                          FFAppState().currencyRate,
                                                                        )}',
                                                                        // maxLines: 2,
                                                                        textAlign: TextAlign.start,
                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                          fontFamily: 'Montserrat',
                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                          fontSize: 15,
                                                                          letterSpacing: 0,
                                                                          fontWeight: FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                        child: InkWell(
                                          onTap: () {
                                            if (_model.choiceChipsValue == 'Rudraksha') {
                                              context.pushNamed(
                                                'CategoriesListViewChooseChip',
                                                queryParameters: {
                                                  'isSelected': "false",
                                                  'defaultcategories': "Rudraksha",
                                                  'subproductslugvalue': "",
                                                },
                                              );
                                            } else if (_model.choiceChipsValue == 'Gemstone') {
                                              context.pushNamed(
                                                'CategoriesListViewChooseChip',
                                                queryParameters: {
                                                  'isSelected': "false",
                                                  'defaultcategories': "Gemstone",
                                                  'subproductslugvalue': "",
                                                },
                                              );
                                            } else if (_model.choiceChipsValue == 'Kanthas & Malas') {
                                              context.pushNamed(
                                                'CategoriesListViewChooseChip',
                                                queryParameters: {
                                                  'isSelected': "true",
                                                  'defaultcategories': "Rudraksha",
                                                  'subproductslugvalue': "p/rudraksha-kantha-rudraksha-mala",
                                                },
                                              );
                                            } else if (_model.choiceChipsValue == 'Yantra') {
                                              context.pushNamed(
                                                'CategoriesListViewChooseChip',
                                                queryParameters: {
                                                  'isSelected': "false",
                                                  'defaultcategories': "Yantras",
                                                  'subproductslugvalue': "",
                                                },
                                              );
                                            } else if (_model.choiceChipsValue == 'Idols') {
                                              context.pushNamed(
                                                'CategoriesListViewChooseChip',
                                                queryParameters: {
                                                  'isSelected': "false",
                                                  'defaultcategories': "Idols",
                                                  'subproductslugvalue': "",
                                                },
                                              );
                                            } else if (_model.choiceChipsValue == 'Gold & Silver products') {
                                              context.pushNamed(
                                                'CategoriesListViewChooseChip',
                                                queryParameters: {
                                                  'isSelected': "true",
                                                  'defaultcategories': "Jewellery",
                                                  'subproductslugvalue': "p/god-pendants-in-gold-and-silver",
                                                },
                                              );
                                            } else if (_model.choiceChipsValue == 'Parad') {
                                              context.pushNamed(
                                                'CategoriesListViewChooseChip',
                                                queryParameters: {
                                                  'isSelected': "true",
                                                  'defaultcategories': "Others",
                                                  'subproductslugvalue': "p/parad",
                                                },
                                              );
                                            } else if (_model.choiceChipsValue == 'Shivling') {
                                              context.pushNamed(
                                                'CategoriesListViewChooseChip',
                                                queryParameters: {
                                                  'isSelected': "true",
                                                  'defaultcategories': "Others",
                                                  'subproductslugvalue': "p/shivling",
                                                },
                                              );
                                            } else if (_model.choiceChipsValue == 'Abhishek Products') {
                                              context.pushNamed(
                                                'CategoriesListViewChooseChip',
                                                queryParameters: {
                                                  'isSelected': "true",
                                                  'defaultcategories': "Others",
                                                  'subproductslugvalue': "p/puja-articles",
                                                },
                                              );
                                            } else if (_model.choiceChipsValue == 'Fresh Items') {
                                              context.pushNamed(
                                                'MainProducts',
                                                queryParameters: {
                                                  'productType': "OthersMainCategory",
                                                  'productslugvalue': "p/fresh-herbs-leaves-flowers-seeds",
                                                  'producttitle': "Fresh Puja Flowers, Leaves",
                                                }.withoutNulls,
                                              );
                                            }
                                          },
                                          child: Visibility(
                                            visible: _model.choiceChipsValue != 'Navratri Special Products' && _model.choiceChipsValue != 'Durga Idols',
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 0.45,
                                              //height: MediaQuery.of(context).size.height * 0.24,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                borderRadius: BorderRadius.circular(16),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(context).primary,
                                                  width: 2,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'View all',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      fontSize: 16,
                                                      letterSpacing: 0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_circle_right_outlined,
                                                    color: FlutterFlowTheme.of(context).primary,
                                                    size: 30,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ].divide(const SizedBox(height: 12)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                      child: InkWell(
                        onTap: () {
                          context.pushNamed(
                            'Consultationwithsakhashree',
                            queryParameters: {
                              'consultationtype': serializeParam(
                                'home',
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 189.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.asset(
                              'assets/images/Group_1872.png',
                              width: 300.0,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 10.0),
                      child: Container(
                        width: double.infinity,
                        //height: 440.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                              child: Text(
                                'Product Categories',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: const Color(0xFF740074),
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'MainProducts',
                                      queryParameters: {
                                        'productType': "OthersMainCategory",
                                        'productslugvalue':
                                            "p/silver-idols-gods-goddesses",
                                        'producttitle': "Silver Idols",
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.asset(
                                          'assets/images/image_24.png',
                                          width: MediaQuery.sizeOf(context).width * 0.44,
                                          height: MediaQuery.sizeOf(context).height * 0.20,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        'Silver Idols',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 16,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ].divide(const SizedBox(height: 8)),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'CategoriesListViewChooseChip',
                                      queryParameters: {
                                        'isSelected': "true",
                                        'defaultcategories': "Vastu",
                                        'subproductslugvalue': "p/chakra-vastu-pyramids",
                                      },
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.asset(
                                          'assets/images/image_24_(1).png',
                                          width: MediaQuery.sizeOf(context).width * 0.44,
                                          height: MediaQuery.sizeOf(context).height * 0.20,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        'Pyramids',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 16,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ].divide(const SizedBox(height: 8)),
                                  ),
                                ),
                              ].divide(const SizedBox(width: 8)),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        'CategoriesListViewChooseChip',
                                        queryParameters: {
                                          'isSelected': "false",
                                          'defaultcategories': "Jewellery",
                                          'subproductslugvalue': "p/chakra-vastu-pyramids",
                                        },
                                      );
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(16.0),
                                          child: Image.asset(
                                            'assets/images/image_24_(2).png',
                                            width: MediaQuery.sizeOf(context).width * 0.44,
                                            height: MediaQuery.sizeOf(context).height * 0.20,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          'Spiritual Jewellery',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ].divide(const SizedBox(height: 8.0)),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        'MainProducts',
                                        queryParameters: {
                                          'productType': "OthersSubCategory",
                                          'productslugvalue': "k/shree-yantra-in-sphatik",
                                          'producttitle': "Sphatik Crystal Quartz Shree Yantra",
                                        }.withoutNulls,
                                      );
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(16.0),
                                          child: Image.asset(
                                            'assets/images/image_24_(3).png',
                                            width: MediaQuery.sizeOf(context).width * 0.44,
                                            height: MediaQuery.sizeOf(context).height * 0.20,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          'Shree Yantras',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ].divide(const SizedBox(height: 8.0)),
                                    ),
                                  ),
                                ].divide(const SizedBox(width: 8.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 24),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Blogs & Events',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: const Color(0xFF740074),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      print("tokenartical $currentAuthenticationToken");
                                      context.pushNamed(
                                        'ArticlesScreen',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: const TransitionInfo(
                                            hasTransition: true,
                                            transitionType: PageTransitionType.rightToLeft,
                                            duration: Duration(milliseconds: 400),
                                          ),
                                        },
                                      );
                                    },
                                    child: Text(
                                      'See all',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: const Color(0xFF696969),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FutureBuilder<ApiCallResponse>(
                              future: HomeBlogCall.call(
                                sanityurl: FFAppConstants.sanityurl,
                              ),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final rowHomeBlogResponse = snapshot.data!;
                                final blogs = getJsonField(
                                  rowHomeBlogResponse.jsonBody,
                                  r'''$.data''').toList();

                                return CarouselSlider.builder(
                                  itemCount: blogs.length,
                                  itemBuilder: (context, index, realIndex) {
                                    final blogsItem = blogs[index];
                                    final slugUrl = getJsonField(blogsItem, r'''$.slug_url''').toString();

                                    return Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.network(
                                                getJsonField(blogsItem, r'''$.image''').toString(),
                                                width: MediaQuery.of(context).size.width - 48,
                                                height: 200,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width - 48,
                                            child: Align(
                                              alignment: const AlignmentDirectional(-1, 0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                child: Text(
                                                  getJsonField(blogsItem, r'''$.blog_title''').toString(),
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width - 48,
                                            child: Align(
                                              alignment: const AlignmentDirectional(-1, 0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: getJsonField(blogsItem, r'''$.small_description''').toString(),
                                                      ),
                                                      TextSpan(
                                                        text: ' Read more',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Montserrat',
                                                          color: FlutterFlowTheme.of(context).primary,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                        recognizer: TapGestureRecognizer()
                                                          ..onTap = () {
                                                            context.pushNamed(
                                                              'ArticleDetail',
                                                              queryParameters: {
                                                                'slugValue': serializeParam(
                                                                  slugUrl,
                                                                  ParamType.String,
                                                                ),
                                                              }.withoutNulls,
                                                              extra: <String, dynamic>{
                                                                kTransitionInfoKey: const TransitionInfo(
                                                                  hasTransition: true,
                                                                  transitionType: PageTransitionType.rightToLeft,
                                                                  duration: Duration(milliseconds: 400),
                                                                ),
                                                              },
                                                            );
                                                          },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    height: MediaQuery.sizeOf(context).height * 0.5,
                                    enlargeCenterPage: true,
                                    autoPlay: true,
                                    aspectRatio: 16 / 9,
                                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                    autoPlayInterval: const Duration(milliseconds: 4800),
                                    autoPlayCurve: Curves.linear,
                                    //autoPlayInterval: const Duration(seconds: 3),
                                    viewportFraction: 0.8,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.0, -0.91),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 52.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            homescaffoldKey.currentState!.openDrawer();
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0),
                              topLeft: Radius.circular(0.0),
                              topRight: Radius.circular(0.0),
                            ),
                            child: Image.asset(
                              'assets/images/hamburger_1.png',
                              width: 24.0,
                              height: 24.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(35, 0.0, 0, 0.0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0),
                              topLeft: Radius.circular(0.0),
                              topRight: Radius.circular(0.0),
                            ),
                            child: Image.asset(
                              'assets/images/image_29.png',
                              width: 102.0,
                              height: 46.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            FutureBuilder<ApiCallResponse>(
                              future: NotificationsListCall.call(
                                token: currentAuthenticationToken,
                                sanityurl: FFAppConstants.sanityurl,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: ShimmerWidget(),
                                    ),
                                  );
                                }
                                final badgeNotificationsListResponse = snapshot.data!;
                                final notifications = getJsonField(
                                  badgeNotificationsListResponse.jsonBody,
                                  r'''$.data''',
                                );
                                final notificationsList = notifications is List ? notifications : [];
                                final notificationsCount = notificationsList.length;

                                return badges.Badge(
                                  badgeContent: Text(
                                    notificationsCount.toString(),
                                    style: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Montserrat',
                                      //fontSize: 12,
                                      color: Colors.white,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                  showBadge: notificationsCount > 0,
                                  //position: badges.BadgePosition.topEnd(),
                                  position: badges.BadgePosition.custom(bottom: 12, start: 8),
                                  badgeAnimation: const badges.BadgeAnimation.scale(),
                                  badgeStyle: badges.BadgeStyle(
                                    badgeColor: FlutterFlowTheme.of(context).primary,
                                    elevation: 4,
                                    padding: const EdgeInsetsDirectional.fromSTEB(10, 2, 10, 2),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      context.pushNamed(
                                        'NotificationsWidget',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: const TransitionInfo(
                                            hasTransition: true,
                                            transitionType: PageTransitionType.rightToLeft,
                                            duration: Duration(milliseconds: 400),
                                          ),
                                        },
                                      );
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/Notification.svg',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 10),
                            FutureBuilder<ApiCallResponse>(
                              future: CartCall.call(
                                hosturl: FFAppConstants.hosturl,
                                token: currentAuthenticationToken,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: ShimmerWidget(),
                                    ),
                                  );
                                }
                                final badgeCartResponse = snapshot.data!;
                                // Get the cart count
                                final cartCount = functions.cartBadgeCount(badgeCartResponse.jsonBody);

                                // Check if the cart count is null or 0
                                if (cartCount == null || cartCount == '0') {
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        'Cart',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: const TransitionInfo(
                                            hasTransition: true,
                                            transitionType: PageTransitionType.rightToLeft,
                                            duration: Duration(milliseconds: 400),
                                          ),
                                        },
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/images/Buy.svg',
                                        width: 25,
                                        height: 25,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }

                                return badges.Badge(
                                  badgeContent: Text(
                                    cartCount,
                                    style: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      // fontSize: 12,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                  showBadge: true,
                                  position: badges.BadgePosition.topEnd(),
                                  //position: badges.BadgePosition.custom(bottom: 12, start: 16),
                                  badgeAnimation: const badges.BadgeAnimation.scale(),
                                  badgeStyle: badges.BadgeStyle(
                                    badgeColor: FlutterFlowTheme.of(context).primary,
                                    elevation: 4,
                                    padding: const EdgeInsetsDirectional.fromSTEB(10, 2, 10, 2),
                                  ),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        'Cart',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: const TransitionInfo(
                                            hasTransition: true,
                                            transitionType: PageTransitionType.rightToLeft,
                                            duration: Duration(milliseconds: 400),
                                          ),
                                        },
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                      ),
                                      child: Image.asset(
                                        'assets/images/Buy.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomNavBarWidget(),
      ),
    );
  }
}
