import 'package:firebase_demo3/core/models/user_model.dart';
import 'package:firebase_demo3/core/routing/routes.dart';
import 'package:firebase_demo3/ui/views/login_view.dart';
import 'package:firebase_demo3/ui/views/sign_out_view.dart';
import 'package:firebase_demo3/ui/views/sign_up_view.dart';
import 'package:firebase_demo3/ui/views/update_profile_view.dart';
import 'package:flutter/material.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.updateProfileRoute:
        UserModel userModel = settings.arguments as UserModel;

        return pageRoute(
            UpdateProfileView(
              usersData: userModel,
            ),
            settings);
      case Routes.sighOutRoute:
        return pageRoute( SignOutView(), settings);
      case Routes.loginRoute:
        return pageRoute(LoginView(), settings);
      case Routes.signUpRoute:
        return pageRoute(SignInView(), settings);
      default:
        return MaterialPageRoute(
            builder: (BuildContext conktext) => const Scaffold(
                  body: Text('This Page does not Exist'),
                ));
    }
  }

  static pageRoute(Widget child, RouteSettings settings) {
    return FadeRoute(
      child: child,
      routeName: settings.name,
      arguments: settings.arguments,
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget? child;
  final String? routeName;
  final Object? arguments;

  FadeRoute({
    this.child,
    this.routeName,
    this.arguments,
  }) : super(
          settings: RouteSettings(name: routeName, arguments: arguments),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
