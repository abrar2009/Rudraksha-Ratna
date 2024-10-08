import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/components/delete_dialog_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'my_addresses_widget.dart' show MyAddressesWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyAddressesModel extends FlutterFlowModel<MyAddressesWidget> {
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

  bool selectedContainer = true;

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
