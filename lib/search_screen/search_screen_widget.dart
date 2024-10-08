import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'search_screen_model.dart';
export 'search_screen_model.dart';

class SearchScreenWidget extends StatefulWidget {
  const SearchScreenWidget({super.key});

  @override
  State<SearchScreenWidget> createState() => _SearchScreenWidgetState();
}

class _SearchScreenWidgetState extends State<SearchScreenWidget> {
  late SearchScreenModel _model;
  bool _isLoading = false; // Loading state variable

  final SearchScreenWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchScreenModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    _model.textController!.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _model.textController!.removeListener(_onSearchChanged);
    _model.textController!.dispose();
    _model.textFieldFocusNode!.dispose();
    _model.dispose();

    super.dispose();
  }

  void _onSearchChanged() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    if (_model.textController.text.isNotEmpty) {
      _model.apiResultjwj = await GlobalSearchCall.call(
        hosturl: FFAppConstants.hosturl,
        search: _model.textController.text,
      );

      if (!(_model.apiResultjwj?.succeeded ?? true)) {
       /* ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Search failed',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );*/
      }

      setState(() {
        _isLoading = false; // End loading
      });
    } else {
      setState(() {
        _isLoading = false; // End loading if text is empty
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: SearchScreenWidgetscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).info,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 24, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 20,
                              borderWidth: 1,
                              buttonSize: 40,
                              icon: Icon(
                                Icons.arrow_back,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24,
                              ),
                              onPressed: () async {
                                context.safePop();
                              },
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF3F3F3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextFormField(
                                  controller: _model.textController,
                                  focusNode: _model.textFieldFocusNode,
                                  onFieldSubmitted: (_) async {
                                    // Triggered when the search field is submitted
                                  },
                                  onChanged: (text) async {
                                    _onSearchChanged();
                                  },
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0,
                                    ),
                                    hintText: 'Search products by category',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFFB7B7B8),
                                      fontSize: 16,
                                      letterSpacing: 0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    letterSpacing: 0,
                                  ),
                                  validator: _model.textControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(width: 8)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          if (_isLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                color:FlutterFlowTheme.of(context)
                                    .primary ,
                              ),
                            );
                          } else if (_model.apiResultjwj?.jsonBody != null) {
                            final searchapi = getJsonField(
                              (_model.apiResultjwj?.jsonBody ?? ''),
                              r'''$.data''',
                            ).toList();

                            if (searchapi.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'No results found!',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context)
                                            .productName,
                                        fontSize: 16,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                    Text(
                                      '  Please try searching for a different keyword',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context)
                                            .productName,
                                        fontSize: 16,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: List.generate(searchapi.length,
                                        (searchapiIndex) {
                                      final searchapiItem = searchapi[searchapiIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 10, 20, 10),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.slugvalue = getJsonField(
                                              searchapiItem,
                                              r'''$.slug_value''',
                                            ).toString();
                                            setState(() {});
                                            _model.apiResulth6o =
                                            await SlugSearchCall.call(
                                              hosturl: FFAppConstants.hosturl,
                                              slugValue: getJsonField(
                                                searchapiItem,
                                                r'''$.slug_value''',
                                              ).toString(),
                                            );
                                            _model.mainprodtype =
                                                SlugSearchCall.datamainprodtype(
                                                  (_model.apiResulth6o?.jsonBody ?? ''),
                                                );
                                            _model.level =
                                                SlugSearchCall.datalevel(
                                                  (_model.apiResulth6o?.jsonBody ?? ''),
                                                );
                                            _model.productlist =
                                            SlugSearchCall.dataproductlist(
                                              (_model.apiResulth6o?.jsonBody ?? ''),
                                            )!;
                                            setState(() {
                                              print(
                                                  "_model.mainprodtype${_model.mainprodtype}");
                                              print("_model.level${_model.level}");
                                              print(
                                                  "_model.productlist${_model.productlist}");
                                            });

                                            if (_model.mainprodtype == 5) {
                                              context.pushNamed(
                                                'OtherProductDetails',
                                                queryParameters: {
                                                  'productSlugValue': serializeParam(
                                                    getJsonField(
                                                      searchapiItem,
                                                      r'''$.slug_value''',
                                                    ).toString(),
                                                    ParamType.String,
                                                  ),
                                                  'producttype': FFAppConstants
                                                      .RudrakshaMasterProductDetailsApi,
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                  TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                    PageTransitionType
                                                        .bottomToTop,
                                                    duration: Duration(
                                                        milliseconds: 400),
                                                  ),
                                                },
                                              );
                                            } else if (_model.mainprodtype == 3) {
                                              context.pushNamed(
                                                'DiamondProductDetails',
                                                queryParameters: {
                                                  'productSlugValue': serializeParam(
                                                    getJsonField(
                                                      searchapiItem,
                                                      r'''$.slug_value''',
                                                    ).toString(),
                                                    ParamType.String,
                                                  ),
                                                  'producttype': FFAppConstants
                                                      .RudrakshaMasterProductDetailsApi,
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                  TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                    PageTransitionType
                                                        .bottomToTop,
                                                    duration: Duration(
                                                        milliseconds: 400),
                                                  ),
                                                },
                                              );
                                            } else if (_model.mainprodtype == 1) {
                                              context.pushNamed(
                                                'PujaProductDetails',
                                                queryParameters: {
                                                  'productSlugValue': serializeParam(
                                                    getJsonField(
                                                      searchapiItem,
                                                      r'''$.slug_value''',
                                                    ).toString(),
                                                    ParamType.String,
                                                  ),
                                                  'producttype': FFAppConstants
                                                      .PujaMasterProductDetailsApi,
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                  TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                    PageTransitionType
                                                        .bottomToTop,
                                                    duration: Duration(
                                                        milliseconds: 400),
                                                  ),
                                                },
                                              );
                                            } else if (_model.mainprodtype == 4) {
                                              context.pushNamed(
                                                'YantraProductDetails',
                                                queryParameters: {
                                                  'productSlugValue': serializeParam(
                                                    getJsonField(
                                                      searchapiItem,
                                                      r'''$.slug_value''',
                                                    ).toString(),
                                                    ParamType.String,
                                                  ),
                                                  'producttype': FFAppConstants
                                                      .YantraMasterProductDetailsApi,
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                  TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                    PageTransitionType
                                                        .bottomToTop,
                                                    duration: Duration(
                                                        milliseconds: 400),
                                                  ),
                                                },
                                              );
                                            } else {
                                              context.pushNamed(
                                                'DiamondProductDetails',
                                                queryParameters: {
                                                  'productSlugValue': serializeParam(
                                                    getJsonField(
                                                      searchapiItem,
                                                      r'''$.slug_value''',
                                                    ).toString(),
                                                    ParamType.String,
                                                  ),
                                                  'producttype': FFAppConstants
                                                      .GemstoneMasterProductDetailsApi,
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                  TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                    PageTransitionType
                                                        .bottomToTop,
                                                    duration: Duration(
                                                        milliseconds: 400),
                                                  ),
                                                },
                                              );
                                            }
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(8),
                                                child: Image.network(
                                                  getJsonField(
                                                    searchapiItem,
                                                    r'''$.thumbnail''',
                                                  ).toString(),
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.sizeOf(context)
                                                    .width *
                                                    0.65,
                                                decoration: BoxDecoration(),
                                                child: Text(
                                                  getJsonField(
                                                    searchapiItem,
                                                    r'''$.name''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .primaryText,
                                                    fontSize: 16,
                                                    letterSpacing: 0,
                                                  ),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 10)),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            );
                          } else {
                            return Center(
                              child: Text(
                                ' ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryText,
                                  fontSize: 16,
                                  letterSpacing: 0,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: wrapWithModel(
                  model: _model.customNavBarModel,
                  updateCallback: () => setState(() {}),
                  child: CustomNavBarWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
