import 'package:shared_preferences/shared_preferences.dart';

import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'sort_by_widget.dart' show SortByWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SortByModel extends FlutterFlowModel<SortByWidget> {
  ///  Local state fields for this component.

  String? radioButtonValue;
  String? sortby;

  Future<void> saveSortByValue(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sortByValue', value);
  }

  Future<void> loadSortByValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    radioButtonValue = prefs.getString('sortByValue');
    print("radioButtonValue : ${radioButtonValue}");
  }

  ///  State fields for stateful widgets in this component.

  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  //String? get radioButtonValue => radioButtonValueController?.value;
}
