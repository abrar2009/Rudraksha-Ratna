import '/components/custom_nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'billing_address_widget.dart' show BillingAddressWidget;
import 'package:flutter/material.dart';

class BillingAddressModel extends FlutterFlowModel<BillingAddressWidget> {
  ///  Local state fields for this page.

  //bool selectedvariable = true;

  List<int> selectedAddress = [];
  void addToSelectedAddress(int item) => selectedAddress.add(item);
  void removeFromSelectedAddress(int item) => selectedAddress.remove(item);
  void removeAtIndexFromSelectedAddress(int index) =>
      selectedAddress.removeAt(index);
  void insertAtIndexInSelectedAddress(int index, int item) =>
      selectedAddress.insert(index, item);
  void updateSelectedAddressAtIndex(int index, Function(int) updateFn) =>
      selectedAddress[index] = updateFn(selectedAddress[index]);

  //bool selectedContainer = true;

  bool selectedBillingContainer = true;

  bool selectedBillingVariable = true;

  String? billingAddress1;

  String? billingAddress2;

  String? billingCity;

  String? billingState;

  String? billingZipCode;

  int? billingId;

  String? nameFL;

  String? emailAddress;

  String? contactNo;

  String? countryName;

  //bool selectedBillingVariable = true;

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
