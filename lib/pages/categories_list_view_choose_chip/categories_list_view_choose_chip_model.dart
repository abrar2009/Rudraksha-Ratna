import 'package:rudraksha_cart/components/custom_nav_bar_model.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/free_gift_component/free_gift_component_widget.dart';
import 'categories_list_view_choose_chip_widget.dart'
    show CategoriesListViewChooseChipWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoriesListViewChooseChipModel
    extends FlutterFlowModel<CategoriesListViewChooseChipWidget> {
  ///  Local state fields for this page.

  bool selectedproduct = true;
  int? mainprodtype;
  String? producttype;
  int? level;
  String? apicall;
  String? slectedmenu="Rudraksha";

  String? producttitle;
  bool productlist = true;
  String? selectedproductslugvale;
  ApiCallResponse? apiResulth6o;
  String refername = 'Rudraksha';
  ///  State fields for stateful widgets in this page.

  late CustomNavBarModel customNavBarModel;
  final unfocusNode = FocusNode();
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  ApiCallResponse? slugSearchSubProduct;
  @override
  void initState(BuildContext context) {
    customNavBarModel = createModel(context, () => CustomNavBarModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
