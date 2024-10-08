import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'delivery_address_widget.dart' show DeliveryAddressWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DeliveryAddressModel extends FlutterFlowModel<DeliveryAddressWidget> {
  ///  Local state fields for this page.

  bool selectedvariable = true;

  List<int> selectedAddress = [];
  void addToSelectedAddress(int item) => selectedAddress.add(item);
  void removeFromSelectedAddress(int item) => selectedAddress.remove(item);
  void removeAtIndexFromSelectedAddress(int index) =>
      selectedAddress.removeAt(index);
  void insertAtIndexInSelectedAddress(int index, int item) =>
      selectedAddress.insert(index, item);
  void updateSelectedAddressAtIndex(int index, Function(int) updateFn) =>
      selectedAddress[index] = updateFn(selectedAddress[index]);

  // Stores action output result for [Backend Call - API (FetchShipping)] action in Button widget.
  ApiCallResponse? fetchShippingOutput;
  // Stores action output result for [Backend Call - API (Cart)] action in Button widget.
  ApiCallResponse? fetchCartforShipping;

  bool selectedContainer = true;
  ApiCallResponse? apiResultrqe;

  String? address1;

  String? address2;

  String? city;

  String? state;

  String? zipCode;

  int? id;

  int? initialRewardPoints;

  String? nameFL;

  String? emailAddress;

  String? contactNo;

  String? countryName;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for CustomNavBar component.
  late CustomNavBarModel customNavBarModel;

  @override
  void initState(BuildContext context) {
    customNavBarModel = createModel(context, () => CustomNavBarModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    customNavBarModel.dispose();
  }
}
