// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:recon/presentation/pages/auth/forgetpassword_page.dart' as _i4;
import 'package:recon/presentation/pages/auth/login_page.dart' as _i6;
import 'package:recon/presentation/pages/auth/onboard_page.dart' as _i8;
import 'package:recon/presentation/pages/auth/signin_page.dart' as _i10;
import 'package:recon/presentation/pages/auth/termscondition_page.dart' as _i11;
import 'package:recon/presentation/pages/home/home_page.dart' as _i5;
import 'package:recon/presentation/pages/tools/base32_page.dart' as _i1;
import 'package:recon/presentation/pages/tools/datepicker_page.dart' as _i2;
import 'package:recon/presentation/pages/tools/flushbar_page.dart' as _i3;
import 'package:recon/presentation/pages/tools/maintool_page.dart' as _i7;
import 'package:recon/presentation/pages/tools/settings_page.dart' as _i9;

/// generated route for
/// [_i1.Base32Page]
class Base32Route extends _i12.PageRouteInfo<void> {
  const Base32Route({List<_i12.PageRouteInfo>? children})
    : super(Base32Route.name, initialChildren: children);

  static const String name = 'Base32Route';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i1.Base32Page();
    },
  );
}

/// generated route for
/// [_i2.DatePickerPage]
class DatePickerRoute extends _i12.PageRouteInfo<void> {
  const DatePickerRoute({List<_i12.PageRouteInfo>? children})
    : super(DatePickerRoute.name, initialChildren: children);

  static const String name = 'DatePickerRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i2.DatePickerPage();
    },
  );
}

/// generated route for
/// [_i3.FlushbarPage]
class FlushbarRoute extends _i12.PageRouteInfo<void> {
  const FlushbarRoute({List<_i12.PageRouteInfo>? children})
    : super(FlushbarRoute.name, initialChildren: children);

  static const String name = 'FlushbarRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i3.FlushbarPage();
    },
  );
}

/// generated route for
/// [_i4.ForgetpasswordPage]
class ForgetpasswordRoute extends _i12.PageRouteInfo<void> {
  const ForgetpasswordRoute({List<_i12.PageRouteInfo>? children})
    : super(ForgetpasswordRoute.name, initialChildren: children);

  static const String name = 'ForgetpasswordRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.ForgetpasswordPage();
    },
  );
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i12.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i13.Key? key,
    required String username,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         HomeRoute.name,
         args: HomeRouteArgs(key: key, username: username),
         initialChildren: children,
       );

  static const String name = 'HomeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>();
      return _i5.HomePage(key: args.key, username: args.username);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key, required this.username});

  final _i13.Key? key;

  final String username;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i12.PageRouteInfo<void> {
  const LoginRoute({List<_i12.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i6.LoginPage();
    },
  );
}

/// generated route for
/// [_i7.MaintoolPage]
class MaintoolRoute extends _i12.PageRouteInfo<MaintoolRouteArgs> {
  MaintoolRoute({
    _i13.Key? key,
    required String username,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         MaintoolRoute.name,
         args: MaintoolRouteArgs(key: key, username: username),
         initialChildren: children,
       );

  static const String name = 'MaintoolRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MaintoolRouteArgs>();
      return _i7.MaintoolPage(key: args.key, username: args.username);
    },
  );
}

class MaintoolRouteArgs {
  const MaintoolRouteArgs({this.key, required this.username});

  final _i13.Key? key;

  final String username;

  @override
  String toString() {
    return 'MaintoolRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [_i8.OnboardPage]
class OnboardRoute extends _i12.PageRouteInfo<void> {
  const OnboardRoute({List<_i12.PageRouteInfo>? children})
    : super(OnboardRoute.name, initialChildren: children);

  static const String name = 'OnboardRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i8.OnboardPage();
    },
  );
}

/// generated route for
/// [_i9.SettingPage]
class SettingRoute extends _i12.PageRouteInfo<void> {
  const SettingRoute({List<_i12.PageRouteInfo>? children})
    : super(SettingRoute.name, initialChildren: children);

  static const String name = 'SettingRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i9.SettingPage();
    },
  );
}

/// generated route for
/// [_i10.SigninPage]
class SigninRoute extends _i12.PageRouteInfo<void> {
  const SigninRoute({List<_i12.PageRouteInfo>? children})
    : super(SigninRoute.name, initialChildren: children);

  static const String name = 'SigninRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i10.SigninPage();
    },
  );
}

/// generated route for
/// [_i11.TermsconditionPage]
class TermsconditionRoute extends _i12.PageRouteInfo<void> {
  const TermsconditionRoute({List<_i12.PageRouteInfo>? children})
    : super(TermsconditionRoute.name, initialChildren: children);

  static const String name = 'TermsconditionRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.TermsconditionPage();
    },
  );
}
