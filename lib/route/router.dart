import 'package:resident_app/main.dart';
import 'package:resident_app/route/routing_constant.dart';
import 'package:resident_app/screens/auth/login.dart';
import 'package:resident_app/screens/errors/404.dart';
import 'package:resident_app/screens/user/complaint/index.dart';
import 'package:resident_app/screens/user/dashboard.dart';
import 'package:resident_app/screens/user/notification/index.dart';
import 'package:resident_app/screens/user/payment/index.dart';
import 'package:resident_app/screens/user/payment/outstanding.dart';
import 'package:resident_app/screens/user/profile.dart';
import 'package:resident_app/screens/user/token/create.dart';
import 'package:resident_app/screens/user/token/detail.dart';
import 'package:resident_app/screens/user/token/index.dart';
import 'package:resident_app/screens/user/token/preview.dart';
import 'package:resident_app/screens/user/vendor/index.dart';
import 'package:resident_app/test.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  //Navigator.pop();
  switch (settings.name) {
    case SplashScreenRoute:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case LoginScreenRoute:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case DashboardScreenRoute:
      return MaterialPageRoute(
        builder: (context) => DashboardScreen(
          title: "Magodo South East Zone",
        ),
      );
    case ProfileScreenRoute:
      return MaterialPageRoute(
        builder: (context) => ProfileScreen(
          title: "Profile",
        ),
      );
    case TokenScreenRoute:
      return MaterialPageRoute(
        builder: (context) => TokenScreen(
          title: "Tokens",
        ),
      );
    case TokenDetailScreenRoute:
      dynamic args = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => TokenDetailScreen(
          args: args,
        ),
        settings: settings,
      );
    case CreateTokenScreenRoute:
      return MaterialPageRoute(
        builder: (context) => CreateTokenScreen(
          title: "Generate Token",
        ),
      );
    case TokenPreviewScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const TokenPreviewScreen(),
      );
    case VendorScreenRoute:
      return MaterialPageRoute(
        builder: (context) => VendorScreen(title: "Vendors"),
      );
    case CreateComplaintScreenRoute:
      return MaterialPageRoute(
        builder: (context) => CreateComplaintScreen(
          title: "Complaint",
        ),
      );
    case NotificationScreenRoute:
      return MaterialPageRoute(builder: (context) => NotificationScreen());
    case PaymentHistoryScreenRoute:
      return MaterialPageRoute(
        builder: (context) => PaymentHistoryScreen(
          title: "Transactions",
        ),
      );
    case OutStandingPaymentScreenRoute:
      return MaterialPageRoute(
        builder: (context) => OutStandingPaymentScreen(
          title: "Outstandings",
        ),
      );
    case AppTestingScreenRoute:
      return MaterialPageRoute(builder: (context) => const AppTestingScreen());
    default:
      return MaterialPageRoute(
        builder: (context) => PageNotFoundScreen(
          name: settings.name,
        ),
      );
  }
}
