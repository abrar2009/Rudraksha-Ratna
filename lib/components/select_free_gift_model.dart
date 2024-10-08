import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'select_free_gift_widget.dart' show SelectFreeGiftWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectFreeGiftModel extends FlutterFlowModel<SelectFreeGiftWidget> {
  ///  Local state fields for this component.

  bool selected = true;

  int? giftDataIndex;

  int? selectedGiftId;

  String? selectedGiftName;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
