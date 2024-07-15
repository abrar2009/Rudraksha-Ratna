import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../pages/OrderTracking/order_tracking_widget.dart';
import '../../pages/diamond_product_details/diamond_product_details_widget.dart';
import '../../pages/main_products/main_products_widget.dart';
import '../../pages/other_product_details/other_product_details_widget.dart';
import '../../pages/product_image/product_image_widget.dart';
import '../../register/register_widget.dart';
import '../../sign_up_o_t_p/sign_up_o_t_p_widget.dart';
import '../../update_address/update_address_widget.dart';
import '/backend/schema/structs/index.dart';

import '/auth/custom_auth/custom_auth_user_provider.dart';

import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  RudrakshaCartAuthUser? initialUser;
  RudrakshaCartAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(RudrakshaCartAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? HomepageWidget() : LoginPageWidget(),
      routes: [
        /*FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? HomepageWidget() : LoginPageWidget(),
        ),*/
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => HomepageWidget(), // This should be your homepage widget
        ),
        FFRoute(
          name: 'Homepage',
          path: '/homepage',
          builder: (context, params) => HomepageWidget(),
        ),
        /*FFRoute(
          name: 'Cart',
          path: '/cart',
          builder: (context, params) => CartWidget(),
        ),
        FFRoute(
          name: 'Wishlist',
          path: '/wishlist',
          builder: (context, params) => WishlistWidget(),
        ),*/
        FFRoute(
          name: 'Cart',
          path: '/cart',
          builder: (context, params) =>
          appStateNotifier.loggedIn ? CartWidget() : LoginPageWidget(),
        ),
        FFRoute(
          name: 'Wishlist',
          path: '/wishlist',
          builder: (context, params) =>
          appStateNotifier.loggedIn ? WishlistWidget() : LoginPageWidget(),
        ),
        /*FFRoute(
          name: 'Profile',
          path: '/profile',
          builder: (context, params) => ProfileWidget(),
        ),*/
        FFRoute(
          name: 'Profile',
          path: '/profile',
          builder: (context, params) =>
          appStateNotifier.loggedIn ? ProfileWidget() : LoginPageWidget(),
        ),
        FFRoute(
          name: 'SelectPaymentMethod',
          path: '/selectPaymentMethod',
          builder: (context, params) => SelectPaymentMethodWidget(
            address1: params.getParam(
              'address1',
              ParamType.String,
            ),
            address2: params.getParam(
              'address2',
              ParamType.String,
            ),
            city: params.getParam(
              'city',
              ParamType.String,
            ),
            state: params.getParam(
              'state',
              ParamType.String,
            ),
            pinCode: params.getParam(
              'pinCode',
              ParamType.String,
            ),
            addressId: params.getParam(
              'addressId',
              ParamType.int,
            ),
            name: params.getParam(
              'name',
              ParamType.String,
            ),
            email: params.getParam(
              'email',
              ParamType.String,
            ),
            contact: params.getParam(
              'contact',
              ParamType.String,
            ),
            country: params.getParam(
              'country',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'PaymentSuccessful',
          path: '/paymentSuccessful',
          builder: (context, params) => PaymentSuccessfulWidget(),
        ),
        FFRoute(
          name: 'EditProfile',
          path: '/editProfile',
          builder: (context, params) => EditProfileWidget(),
        ),
        FFRoute(
          name: 'MyOrders',
          path: '/myOrders',
          builder: (context, params) => MyOrdersWidget(),
        ),
        FFRoute(
          name: 'SearchScreen',
          path: '/searchScreen',
          builder: (context, params) => SearchScreenWidget(),
        ),
        FFRoute(
          name: 'SelectPaymentMethod2',
          path: '/selectPaymentMethod2',
          builder: (context, params) => SelectPaymentMethod2Widget(
            totalAmount: params.getParam(
              'totalAmount',
              ParamType.String,
            ),
            orderTotalAmount: params.getParam(
              'orderTotalAmount',
              ParamType.int,
            ),
            currencyName: params.getParam(
              'currencyName',
              ParamType.String,
            ),
            invoiceNumber: params.getParam(
              'invoiceNumber',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'CouponsScreen',
          path: '/couponsScreen',
          builder: (context, params) => CouponsScreenWidget(),
        ),
        FFRoute(
          name: 'ProductDetails',
          path: '/productDetails',
          builder: (context, params) => ProductDetailsWidget(
            productSlugValue: params.getParam(
              'productslugvalue',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'OtherProductDetails',
          path: '/otherProductDetails',
          builder: (context, params) => OtherProductDetailsWidget(
            productSlugValue: params.getParam(
              'productSlugValue',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'MainProducts',
          path: '/mainProducts',
          builder: (context, params) => MainProductsWidget(
            productType: params.getParam(
              'productType',
              ParamType.String,
            ),
            productslugvalue: params.getParam(
              'productslugvalue',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'ProductImage',
          path: '/productImage',
          builder: (context, params) => ProductImageWidget(productimage: '',),
        ),
        FFRoute(
          name: 'DiamondProductDetails',
          path: '/diamondProductDetails',
          builder: (context, params) => DiamondProductDetailsWidget(
            productSlugValue: params.getParam(
              'productSlugValue',
              ParamType.String,
            ),
            producttype: params.getParam(
            'producttype',
            ParamType.String,
          ),
          ),
        ),
        FFRoute(
          name: 'ProfileMyAddress',
          path: '/profileMyAddress',
          builder: (context, params) => ProfileMyAddressWidget(),
        ),
        FFRoute(
          name: 'OrderTracking',
          path: '/OrderTracking',
          builder: (context, params) => OrderTrackingWidget(
            orderId: params.getParam(
              'orderId',
              ParamType.int,
            ),
            productIndex: params.getParam(
              'productIndex',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: 'DeliveryAddress',
          path: '/deliveryAddress',
          builder: (context, params) => DeliveryAddressWidget(),
        ),
        FFRoute(
          name: 'CategoriesGridView',
          path: '/categoriesGridView',
          builder: (context, params) => CategoriesGridViewWidget(),
        ),
        FFRoute(
          name: 'CategoriesListViewChooseChip',
          path: '/categoriesListViewChooseChip',
          builder: (context, params) => CategoriesListViewChooseChipWidget(),
        ),
        FFRoute(
          name: 'MyAddresses',
          path: '/myAddresses',
          builder: (context, params) => MyAddressesWidget(),
        ),
        FFRoute(
          name: 'AddNewAddress',
          path: '/addNewAddress',
          builder: (context, params) => AddNewAddressWidget(),
        ),
        FFRoute(
          name: 'RegisterPage',
          path: '/registerPage',
          builder: (context, params) => RegisterWidget(),
        ),
        FFRoute(
          name: 'test',
          path: '/test',
          builder: (context, params) => TestWidget(),
        ),
        FFRoute(
          name: 'SigninOTP',
          path: '/signinOTP',
          builder: (context, params) => SigninOTPWidget(
            emailAddress: params.getParam(
              'emailAddress',
              ParamType.String,
            ),
            phoneNumber: params.getParam(
              'phoneNumber',
              ParamType.String,
            ),
            countryCode: params.getParam(
              'countryCode',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'LoginPage',
          path: '/loginPage',
          builder: (context, params) => LoginPageWidget(),
        ),
        FFRoute(
          name: 'UpdateAddress',
          path: '/updateAddress',
          builder: (context, params) => UpdateAddressWidget(
            addressId: params.getParam(
              'addressId',
              ParamType.int,
            ),
            editCountryId: params.getParam(
              'editCountryId',
              ParamType.String,
            ),
            editStateId: params.getParam(
              'editStateId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'SignUpOTP',
          path: '/signUpOTP',
          builder: (context, params) => SignUpOTPWidget(
            emailAddress: params.getParam(
              'emailAddress',
              ParamType.String,
            ),
            phoneNumber: params.getParam(
              'phoneNumber',
              ParamType.String,
            ),
            countryCode: params.getParam(
              'countryCode',
              ParamType.String,
            ),
            customerName: params.getParam(
              'customerName',
              ParamType.String,
            ),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/loginPage';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
