import '../custom_code/widgets/filter_for_gemstone.dart';
import '../custom_code/widgets/filter_for_gemstone_carat_weight.dart';
import '../custom_code/widgets/filter_for_gemstone_price_per_carat.dart';
import '../custom_code/widgets/filter_for_gemstone_ratti_weight.dart';
import '../custom_code/widgets/filter_for_rudraksha_bead_size.dart';
import '../custom_code/widgets/filter_for_rudraksha_price.dart';
import '../custom_code/widgets/filter_for_yantras_price.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'filter_component_model.dart';
export 'filter_component_model.dart';

class FilterComponentWidget extends StatefulWidget {
  const FilterComponentWidget({
    super.key,
    String? productFilterbytype,
    this.maxprice,
    this.minprice,
    this.maxcaratweight,
    this.mincaratweight,
    this.maxbeadsize,
    this.minbeadsize,
    this.maxrattiweight,
    this.minrattiweight,
    this.maxpricepercarat,
    this.minpricepercarat,
    this.originlist,
    this.sizegrade,
    this.deityPurpose,
  }) : this.productFilterbytype = productFilterbytype ?? 'xxxx';

  final String productFilterbytype;
  final double? maxprice;
  final double? minprice;
  final double? maxcaratweight;
  final double? mincaratweight;
  final double? maxbeadsize;
  final double? minbeadsize;
  final double? maxrattiweight;
  final double? minrattiweight;
  final double? maxpricepercarat;
  final double? minpricepercarat;
  final List<String>? originlist;
  final String? sizegrade;
  final List<String>? deityPurpose;

  @override
  State<FilterComponentWidget> createState() => _FilterComponentWidgetState();
}

class _FilterComponentWidgetState extends State<FilterComponentWidget> {
  late FilterComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilterComponentModel());
    print("widget.productFilterbytype : ${widget.productFilterbytype}");
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      /*height: () {
        if (widget.productFilterbytype == 'Yantras') {
          return 355.0;
        } else if (widget.productFilterbytype == 'Gemstone') {
          return 650.0;
        }else if (widget.productFilterbytype == 'Others') {
          return 282.0;
        }else if (widget.productFilterbytype == 'Puja') {
          return 282.0;
        } else {
          return 500.0;
        }
      }(),*/
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.safePop();
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/hint.png',
                  width: 72,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 16),
                    child: Text(
                      'Filter',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF272728),
                        fontSize: 18,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      print("widget.productFilterbytype : ${widget.productFilterbytype}");
                      if (widget.productFilterbytype == 'Gemstone') {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 110,
                              child: FilterForRudrakshaPrice(
                                width: double.infinity,
                                height: 110,
                                rangestart:
                                FFAppState().rangestartString == null ||
                                    FFAppState().rangestartString == ''
                                    ? widget.minprice?.toString()
                                    : FFAppState().rangestartString,
                                rangeend: FFAppState().rangeendString == null ||
                                    FFAppState().rangeendString == ''
                                    ? widget.maxprice?.toString()
                                    : FFAppState().rangeendString,
                                minValue: widget.minprice,
                                maxValue: widget.maxprice,
                                divisions: 10,
                                labelStart: 'mm',
                                labelEnd: 'mm',
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(0xFFE7E7E8),
                            ),
                            Container(
                              width: double.infinity,
                              height: 110,
                              child: FilterForRudrakshaBeadSize(
                                width: double.infinity,
                                height: 110,
                                rangestart:
                                FFAppState().BeadSizeMin == null ||
                                    FFAppState().BeadSizeMin == ''
                                    ? widget.minbeadsize?.toString()
                                    : FFAppState().BeadSizeMin,
                                rangeend: FFAppState().BeadSizeMax == null ||
                                    FFAppState().BeadSizeMax == ''
                                    ? widget.maxbeadsize?.toString()
                                    : FFAppState().BeadSizeMax,

                                minValue: widget.minbeadsize,
                                maxValue: widget.maxbeadsize,
                                divisions: 10,
                                labelStart: 'mm',
                                labelEnd: 'mm',
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(0xFFE7E7E8),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(24, 10, 24, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Size Grade',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 16,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 420,
                                        child: custom_widgets.CustomRadioButton(
                                          width: double.infinity,
                                          height: 340,
                                          selectedSizeGrade: FFAppState().SelectedSizeGrade,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (widget.productFilterbytype == 'Rurakasha') {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 110,
                                  child: FilterForGemstone(
                                    width: double.infinity,
                                    height: 100,
                                    rangestart:
                                    FFAppState().rangestartString == null ||
                                        FFAppState().rangestartString == ''
                                        ? widget.minprice?.toString()
                                        : FFAppState().rangestartString,
                                    rangeend: FFAppState().rangeendString == null ||
                                        FFAppState().rangeendString == ''
                                        ? widget.maxprice?.toString()
                                        : FFAppState().rangeendString,
                                    minValue: widget.minprice,
                                    maxValue: widget.maxprice,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(0xFFE7E7E8),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 110,
                              child: FilterForGemstoneCaratWeight(
                                width: double.infinity,
                                height: 100,
                                rangestart: FFAppState().rangestartString == null ||
                                    FFAppState().rangestartString == ''
                                    ? widget.mincaratweight?.toString()
                                    : FFAppState().rangestartString,
                                rangeend: FFAppState().rangeendString == null ||
                                    FFAppState().rangeendString == ''
                                    ? widget.maxcaratweight?.toString()
                                    : FFAppState().rangeendString,
                                minValue: widget.mincaratweight,
                                maxValue: widget.maxcaratweight,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(0xFFE7E7E8),
                            ),
                            Container(
                              width: double.infinity,
                              height: 110,
                              child: FilterForGemstoneRattiWeight(
                                width: double.infinity,
                                height: 100,
                                rangestart: FFAppState().rangestartString == null ||
                                    FFAppState().rangestartString == ''
                                    ? widget.minrattiweight?.toString()
                                    : FFAppState().rangestartString,
                                rangeend: FFAppState().rangeendString == null ||
                                    FFAppState().rangeendString == ''
                                    ? widget.maxrattiweight?.toString()
                                    : FFAppState().rangeendString,
                                minValue: widget.minrattiweight,
                                maxValue: widget.maxrattiweight,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(0xFFE7E7E8),
                            ),
                            Container(
                              width: double.infinity,
                              height: 110,
                              child: FilterForGemstonePricePerCarat(
                                width: double.infinity,
                                height: 100,
                                rangestart: FFAppState().rangestartString == null ||
                                    FFAppState().rangestartString == ''
                                    ? widget.minpricepercarat?.toString()
                                    : FFAppState().rangestartString,
                                rangeend: FFAppState().rangeendString == null ||
                                    FFAppState().rangeendString == ''
                                    ? widget.maxpricepercarat?.toString()
                                    : FFAppState().rangeendString,
                                minValue: widget.minpricepercarat,
                                maxValue: widget.maxpricepercarat,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(0xFFE7E7E8),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child: FlutterFlowDropDown<String>(
                                controller: _model.dropDownValueController1 ??= FormFieldController<String>(null),
                                options: widget.originlist!,
                                onChanged: (val) => setState(() => _model.dropDownValue1 = val),
                                width: 300,
                                height: 56,
                                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                                hintText: 'Origin',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  size: 24,
                                ),
                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                elevation: 2,
                                borderColor: Colors.transparent,
                                borderWidth: 2,
                                borderRadius: 8,
                                margin: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                hidesUnderline: true,
                                isOverButton: true,
                                isSearchable: false,
                                isMultiSelect: false,
                              ),
                            ),
                          ],
                        );
                      } else if (widget.productFilterbytype == 'Yantras') {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 110,
                                  child: FilterForYantrasPrice(
                                    width: double.infinity,
                                    height: 110,
                                    rangestart: FFAppState().YantraMinPrice == null ||
                                        FFAppState().YantraMinPrice == ''
                                        ? widget.minprice?.toString()
                                        : FFAppState().YantraMinPrice,
                                    rangeend: FFAppState().YantraMaxPrice == null ||
                                        FFAppState().YantraMaxPrice == ''
                                        ? widget.maxprice?.toString()
                                        : FFAppState().YantraMaxPrice,
                                    minValue: widget.minprice,
                                    maxValue: widget.maxprice,
                                    divisions: 10,
                                    labelStart: 'mm',
                                    labelEnd: 'mm',
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Color(0xFFE7E7E8),
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(),
                                  child: FlutterFlowDropDown<String>(
                                    controller:
                                    _model.yantraDropDownValueController ??=
                                        FormFieldController<String>(
                                          _model.yantraDropDownValue ??= FFAppState().YantrasDeityPurpose != null &&
                                              FFAppState().YantrasDeityPurpose != ''
                                              ? FFAppState().YantrasDeityPurpose
                                              : ' ',
                                        ),
                                    options: widget.deityPurpose!,
                                    onChanged: (val) async {
                                      setState(() =>
                                      _model.yantraDropDownValue = val);
                                      FFAppState().YantrasDeityPurpose =
                                      _model.yantraDropDownValue!;
                                      setState(() {});
                                    },
                                    width: 300,
                                    height: 56,
                                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    hintText: 'Deity/Purpose',
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                      size: 24,
                                    ),
                                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                    elevation: 2,
                                    borderColor: Colors.transparent,
                                    borderWidth: 2,
                                    borderRadius: 8,
                                    margin: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                    hidesUnderline: true,
                                    isOverButton: true,
                                    isSearchable: false,
                                    isMultiSelect: false,
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Color(0xFFE7E7E8),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      else {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                // Generated code for this FilterForGemstone Widget...
                                Container(
                                  width: double.infinity,
                                  height: 110,
                                  child: FilterForGemstone(
                                    width: double.infinity,
                                    height: 100,
                                    rangestart: FFAppState().rangestartString == null ||
                                        FFAppState().rangestartString == ''
                                        ? widget.minprice?.toString()
                                        : FFAppState().rangestartString,
                                    rangeend: FFAppState().rangeendString == null ||
                                        FFAppState().rangeendString == ''
                                        ? widget.maxprice?.toString()
                                        : FFAppState().rangeendString,
                                    minValue: widget.minprice,
                                    maxValue: widget.maxprice,
                                    divisions: 10,
                                    labelStart: 'mm',
                                    labelEnd: 'mm',
                                  ),

                                ),

                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(0xFFE7E7E8),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 64,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.safePop();
                          FFAppState().SelectedSizeGrade = "";
                          print("Reset FFAppState().SelectedSizeGrade : ${FFAppState().SelectedSizeGrade}");
                          FFAppState().BeadSizeMax = '';
                          FFAppState().BeadSizeMin = '';
                          FFAppState().YantraMaxPrice = '';
                          FFAppState().YantraMinPrice = '';
                          FFAppState().YantrasDeityPurpose = '';
                          FFAppState().minpricepercaratString = '';
                          FFAppState().maxpricepercaratString = '';
                          FFAppState().minrattiweightString = '';
                          FFAppState().maxrattiweightString = '';
                          FFAppState().mincaratweightString = '';
                          FFAppState().maxcaratweightString = '';
                          FFAppState().rangeendString = '';
                          FFAppState().rangestartString = '';
                          setState(() {});
                        },
                        text: 'Reset',
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 0.45,
                          height: 48,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: Colors.white,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF3E3E40),
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                          elevation: 0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).borderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.safePop();
                          FFAppState().rangestartString = FFAppState().rangestartString;
                          FFAppState().rangeendString = FFAppState().rangeendString;
                          FFAppState().update(() {});
                        },
                        text: 'Apply',
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 0.45,
                          height: 48,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                          elevation: 0,
                          borderSide: BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: 7)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
