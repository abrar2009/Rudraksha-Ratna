import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../pages/About Us/AboutusWidget.dart';
import '../../pages/All Review/AllReviews_Widget.dart';
import '../../pages/AstrologyConsultation/astrology_consultation_widget.dart';
import '../../pages/BankInfoScreen/PaymentBankInfoWidget.dart';
import '../../pages/Careers/CareersWidget.dart';
import '../../pages/ChakraCleansingMeditationWithSakhashree/ChakraCleansingMeditationWithSakhashreeWidget.dart';
import '../../pages/ChakraVastuConsultation/chakra_vastu_consultation_widget.dart';
import '../../pages/ConsultationScreen/consultation_widget.dart';
import '../../pages/Consultationwithsakhashree/Consultationwithsakhashree_widget.dart';
import '../../pages/Disclaimer/Disclaimer_Widget.dart';
import '../../pages/OrderTracking/order_tracking_widget.dart';
import '../../pages/PujaServicesRecommendation/PujaServicesRecommendationWidget.dart';
import '../../pages/Puja_product_details/puja_product_details_widget.dart';
import '../../pages/RudrakshaGemsRecommendationConsultation/RudrakshaGemsRecommendationWidget.dart';
import '../../pages/Testimonials/testimonial_widget.dart';
import '../../pages/Yantra_product_details/yantra_product_details_widget.dart';
import '../../pages/add_review/add_review_widget.dart';
import '../../pages/article_detail/article_detail_widget.dart';
import '../../pages/article_screen/article_screen_widget.dart';
import '../../pages/billing_address/billing_address_widget.dart';
import '../../pages/contact_us/contact_us_widget.dart';
import '../../pages/diamond_product_details/diamond_product_details_widget.dart';
import '../../pages/main_products/main_products_widget.dart';
import '../../pages/notifications/notifications_widget.dart';
import '../../pages/other_product_details/other_product_details_widget.dart';
import '../../pages/our_team/OurTeamWidget.dart';
import '../../pages/policy/policy_widget.dart';
import '../../pages/product_image/product_image_widget.dart';
import '../../pages/splash_screen.dart';
import '../../register/register_widget.dart';
import '../../sign_up_o_t_p/sign_up_o_t_p_widget.dart';
import '../../update_address/update_address_widget.dart';
import '/backend/schema/structs/index.dart';
import '/auth/custom_auth/custom_auth_user_provider.dart';
import '/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
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
      /*errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? HomepageWidget() : LoginPageWidget(),*/
      errorBuilder: (context, state) {
        if (appStateNotifier.showSplashImage) {
          return Builder(
            builder: (context) => Container(
              color: Colors.black,
              child: Image.asset(
                'assets/images/splash_screen.gif',
                fit: BoxFit.contain,
              ),
            ),
          );
        } else {
          return appStateNotifier.loggedIn
              ? HomepageWidget()
              : LoginPageWidget();
        }
      },
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
          builder: (context, _) => SplashScreen(),
        ),
        /*FFRoute(
          name: '_initialize',
          path: '/',
          *//*builder: (context, _) =>
              HomepageWidget(),*//* // This should be your homepage widget
          builder: (context, _) => appStateNotifier.showSplashImage
              ? Builder(
            builder: (context) => Container(
              color: Colors.black,
              child: Image.asset(
                'assets/images/splash_screen.gif',
                fit: BoxFit.contain,
              ),
            ),
          ) : HomepageWidget(),
        ),*/
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
            /*billingAddress1: params.getParam(
              'billingAddress1',
              ParamType.String,
            ),
            billingAddress2: params.getParam(
              'billingAddress2',
              ParamType.String,
            ),
            billingCity: params.getParam(
              'billingCity',
              ParamType.String,
            ),
            billingState: params.getParam(
              'billingState',
              ParamType.String,
            ),
            billingPincode: params.getParam(
              'billingPincode',
              ParamType.String,
            ),
            billingAddressId: params.getParam(
              'billingAddressId',
              ParamType.String,
            ),*/
            initialRewardPoints: params.getParam(
              'initialRewardPoints',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: 'PaymentSuccessful',
          path: '/paymentSuccessful',
          builder: (context, params) => PaymentSuccessfulWidget(),
        ),
        FFRoute(
          name: 'NotificationsWidget',
          path: '/notificationsWidget',
          builder: (context, params) => NotificationScreen(),
        ),
        FFRoute(
          name: 'PaymentBankInfoWidget',
          path: '/paymentbankinfowidget',
          builder: (context, params) => PaymentBankInfoWidget(),
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
              ParamType.double,
            ),
            orderTotalAmount: params.getParam(
              'orderTotalAmount',
              ParamType.int,
            ),
            productlist: params.getParam<List<Product>>(
              'productlist',
              ParamType.List,
            ),
            currencyName: params.getParam(
              'currencyName',
              ParamType.String,
            ),
            invoiceNumber: params.getParam(
              'invoiceNumber',
              ParamType.String,
            ),

            checkbox1: params.getParam(
              'checkbox1',
              ParamType.bool,
            ),
            checkbox2: params.getParam(
              'checkbox2',
              ParamType.bool,
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
            outofstockValue: params.getParam(
              'outofstockValue',
              ParamType.bool,
            ),
            isFromPaymentScreen: params.getParam(
              'isFromPaymentScreen',
              ParamType.bool,
            ) ?? false,
            cartId: params.getParam(
              'cartId',
              ParamType.int,
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
            producttitle: params.getParam(
              'producttitle',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'ProductImage',
          path: '/productImage',
          builder: (context, params) => ProductImageWidget(
            productimage: '',
          ),
        ),
        FFRoute(
          name: 'DiamondProductDetails',
          path: '/diamondProductDetails',
          builder: (context, params) => DiamondProductDetailsWidget(
            productSlugValue: params.getParam(
              'productSlugValue',
              ParamType.String,
            ),
            firstLevelName: params.getParam(
              'firstLevelName',
              ParamType.String,
            ),
            producttype: params.getParam(
              'producttype',
              ParamType.String,
            ),
            isFromPaymentScreen: params.getParam(
              'isFromPaymentScreen',
              ParamType.bool,
            ) ?? false,
            cartId: params.getParam(
              'cartId',
              ParamType.int,
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
            invoiceNo: params.getParam(
              'invoiceNo',
              ParamType.String,
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
          name: 'BillingAddress',
          path: '/BillingAddress',
          builder: (context, params) => BillingAddressWidget(),
        ),
        FFRoute(
          name: 'CategoriesGridView',
          path: '/categoriesGridView',
          builder: (context, params) => CategoriesGridViewWidget(),
        ),
        FFRoute(
          name: 'CategoriesListViewChooseChip',
          path: '/categoriesListViewChooseChip',
          builder: (context, params) => CategoriesListViewChooseChipWidget(
            isSelected: params.getParam(
              'isSelected',
              ParamType.bool,
            ),
            defaultcategories: params.getParam(
              'defaultcategories',
              ParamType.String,
            ),
            subproductslugvalue: params.getParam(
              'subproductslugvalue',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'MyAddresses',
          path: '/myAddresses',
          builder: (context, params) => MyAddressesWidget(),
        ),

        /*     FFRoute(
          name: 'ArticleDetail',
          path: '/articleDetail',
          builder: (context, params) => ArticleDetailWidget(
            slugValue: params.getParam(
              'slugValue',
              ParamType.String,
            ),
          ),
        ),*/

        FFRoute(
          name: 'ContactUsWidget',
          path: '/contactUsWidget',
          builder: (context, params) => ContactUsWidget(),
        ),
        FFRoute(
          name: 'PolicyWidget',
          path: '/policyWidget',
          builder: (context, params) => PolicyWidget(),
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
          name: 'YantraProductDetails',
          path: '/yantraProductDetails',
          builder: (context, params) => YantraProductDetailsWidget(
            productSlugValue: params.getParam(
              'productSlugValue',
              ParamType.String,
            ),
            producttype: params.getParam(
              'producttype',
              ParamType.String,
            ),
            isFromPaymentScreen: params.getParam(
              'isFromPaymentScreen',
              ParamType.bool,
            ) ?? false,
            cartId: params.getParam(
              'cartId',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: 'AboutusWidget',
          path: '/aboutuswidget',
          builder: (context, params) => AboutusWidget(),
        ),
        FFRoute(
          name: 'DisclaimerWidget',
          path: '/disclaimerwidget',
          builder: (context, params) => DisclaimerWidget(),
        ),
        FFRoute(
          name: 'CareersWidget',
          path: '/careerswidget',
          builder: (context, params) => CareersWidget(),
        ),
        FFRoute(
          name: 'ChakraCleansingMeditationWithSakhashreeWidget',
          path: '/cakracleansingmeditationwithsakhashreewidget',
          builder: (context, params) =>
              ChakraCleansingMeditationWithSakhashreeWidget(),
        ),
        FFRoute(
          name: 'ChakraVastuConsultationWidget',
          path: '/chakravastuconsultationwidget',
          builder: (context, params) => ChakraVastuConsultationWidget(),
        ),
        FFRoute(
          name: 'AstrologyConsultationWidget',
          path: '/astrologyconsultationwidget',
          builder: (context, params) => AstrologyConsultationWidget(),
        ),
        FFRoute(
          name: 'AllReviewsWidget',
          path: '/allreviewswidget',
          builder: (context, params) => AllReviewWidget(
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
          name: 'PujaProductDetails',
          path: '/pujaProductDetails',
          builder: (context, params) => PujaProductDetailsWidget(
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
          name: 'AddRatingDetails',
          path: '/AddRatingDetails',
          builder: (context, params) => AddRatingWidget(
            mainproducttype: params.getParam(
              'mainproducttype',
              ParamType.String,
            ),
            productid: params.getParam(
              'productid',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'TestimonialsWidget',
          path: '/testimonialswidget',
          builder: (context, params) => TestimonialsWidget(),
        ),
        FFRoute(
          name: 'ArticleDetail',
          path: '/articleDetail',
          builder: (context, params) => ArticleDetailWidget(
            slugValue: params.getParam(
              'slugValue',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'ArticlesScreen',
          path: '/articlesScreen',
          builder: (context, params) => ArticlesScreenWidget(),
        ),
        FFRoute(
          name: 'OurTeam',
          path: '/ourTeam',
          builder: (context, params) => OurTeamWidget(),
        ),
        FFRoute(
          name: 'RudrakshaGemsRecommendationWidget',
          path: '/rudrakshagemsrecommendationwidget',
          builder: (context, params) => RudrakshaGemsRecommendationWidget(),
        ),
        FFRoute(
          name: 'PujaServicesRecommendationWidget',
          path: '/pujaservicesrecommendationwidget',
          builder: (context, params) => PujaServicesRecommendationWidget(),
        ),
        FFRoute(
          name: 'Conslutation',
          path: '/conslutation',
          builder: (context, params) => ConsultationScreenWidget(),
        ),
        FFRoute(
          name: 'Consultationwithsakhashree',
          path: '/consultationwithsakhashree',
          builder: (context, params) => ConsultationwithsakhashreeWidget(
            consultationtype: params.getParam(
              'consultationtype',
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
            firstName: params.getParam(
              'firstName',
              ParamType.String,
            ),
            lastName: params.getParam(
              'lastName',
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

      if (appStateNotifier.showSplashImage) {
        return MaterialPage(
          key: state.pageKey,
          child: SplashScreen(),
        );
      }

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

/*class FFRoute {
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
                ) : page;

          if (appStateNotifier.showSplashImage) {
            return MaterialPage(
              key: state.pageKey,
              child: Container(
                color: Colors.black,
                child: Image.asset(
                  'assets/images/splash_screen.gif',
                  fit: BoxFit.contain,
                ),
              ),
            );
          }

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
}*/

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
