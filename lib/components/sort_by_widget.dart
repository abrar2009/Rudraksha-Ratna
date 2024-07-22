import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'sort_by_model.dart';
export 'sort_by_model.dart';

class SortByWidget extends StatefulWidget {
  final VoidCallback onSortChanged; // Callback function to notify when sort changes

  const SortByWidget({super.key, required this.onSortChanged});

  @override
  State<SortByWidget> createState() => _SortByWidgetState();
}

class _SortByWidgetState extends State<SortByWidget> {
  late SortByModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SortByModel());
  }


  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24, 32, 0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: Text(
                'Sort By',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF272728),
                  fontSize: 18,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            FlutterFlowRadioButton(
              options: [
                'New              ',
                'Best Seller   ',
                'Low to High',
                'High to Low'
              ].toList(),
              onChanged: (val) async {
                setState(() {});
                if (_model.radioButtonValue == 'New              ') {
                //  _model.sortby = 'new_arrival';
                  _model.sortby = '';
                  setState(() {});
                //  context.safePop();
                } else if (_model.radioButtonValue == 'Best Seller   ') {
                 // _model.sortby = 'best_seller';
                  _model.sortby = '';
                  setState(() {});
                 // context.safePop();
                } else if (_model.radioButtonValue == 'Low to High') {
                  _model.sortby = 'low_to_high';
                  setState(() {});
                //  context.safePop();
                } else if (_model.radioButtonValue == 'High to Low') {
                  _model.sortby = 'high_to_low';
                  setState(() {});
                  //context.safePop();
                } else {
                  _model.sortby = "";
                  setState(() {});
                }
                FFAppState().update(() {
                  FFAppState().sortby= _model.sortby!;
                  print("_model.FFAppState().sortby:${FFAppState().sortby}");
                });
                print("_model.sortby:${_model.sortby}");
                Navigator.of(context).pop();
                widget.onSortChanged();
              },

              controller: _model.radioButtonValueController ??=
                  FormFieldController<String>(null),
              optionHeight: 60,

              textStyle: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'Montserrat',
                color: Color(0xFF272728),
                fontSize: 16,
                letterSpacing: 0,
              ),
              textPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 200, 0),
              buttonPosition: RadioButtonPosition.right,
              direction: Axis.vertical,

              radioButtonColor: FlutterFlowTheme.of(context).primary,
              inactiveRadioButtonColor:
              FlutterFlowTheme.of(context).secondaryText,
              toggleable: false,
              horizontalAlignment: WrapAlignment.start,
              verticalAlignment: WrapCrossAlignment.start,
            ),
          ],
        ),
      ),
    );
  }
}
