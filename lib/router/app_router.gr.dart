// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:recon/pages/auth/login_page.dart' as _i5;
import 'package:recon/pages/auth/onboard_page.dart' as _i7;
import 'package:recon/pages/home/home_page.dart' as _i4;
import 'package:recon/pages/tools/base32_page.dart' as _i1;
import 'package:recon/pages/tools/datepicker_page.dart' as _i2;
import 'package:recon/pages/tools/flushbar_page.dart' as _i3;
import 'package:recon/pages/tools/maintool_page.dart' as _i6;
import 'package:recon/pages/tools/settings_page.dart' as _i8;

/// generated route for
/// [_i1.Base32Page]
class Base32Route extends _i10.PageRouteInfo<void> {
  const Base32Route({List<_i10.PageRouteInfo>? children})
    : super(Base32Route.name, initialChildren: children);

  static const String name = 'Base32Route';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i1.Base32Page();
    },
  );
}

/// generated route for
/// [_i2.DatePickerPage]
class DatePickerRoute extends _i10.PageRouteInfo<void> {
  const DatePickerRoute({List<_i10.PageRouteInfo>? children})
    : super(DatePickerRoute.name, initialChildren: children);

  static const String name = 'DatePickerRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i2.DatePickerPage();
    },
  );
}

/// generated route for
/// [_i3.FlushbarPage]
class FlushbarRoute extends _i10.PageRouteInfo<void> {
  const FlushbarRoute({List<_i10.PageRouteInfo>? children})
    : super(FlushbarRoute.name, initialChildren: children);

  static const String name = 'FlushbarRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i3.FlushbarPage();
    },
  );
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i10.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i11.Key? key,
    required String username,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         HomeRoute.name,
         args: HomeRouteArgs(key: key, username: username),
         initialChildren: children,
       );

  static const String name = 'HomeRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>();
      return _i4.HomePage(key: args.key, username: args.username);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key, required this.username});

  final _i11.Key? key;

  final String username;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [_i5.LoginPage]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute({List<_i10.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i5.LoginPage();
    },
  );
}

/// generated route for
/// [_i6.MaintoolPage]
class MaintoolRoute extends _i10.PageRouteInfo<MaintoolRouteArgs> {
  MaintoolRoute({
    _i11.Key? key,
    required String username,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         MaintoolRoute.name,
         args: MaintoolRouteArgs(key: key, username: username),
         initialChildren: children,
       );

  static const String name = 'MaintoolRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MaintoolRouteArgs>();
      return _i6.MaintoolPage(key: args.key, username: args.username);
    },
  );
}

class MaintoolRouteArgs {
  const MaintoolRouteArgs({this.key, required this.username});

  final _i11.Key? key;

  final String username;

  @override
  String toString() {
    return 'MaintoolRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [_i7.OnboardPage]
class OnboardRoute extends _i9.PageRouteInfo<void> {
  const OnboardRoute({List<_i9.PageRouteInfo>? children})
    : super(OnboardRoute.name, initialChildren: children);

  static const String name = 'OnboardRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.OnboardPage();
    },
  );
}

/// generated route for
/// [_i8.SettingPage]
class SettingRoute extends _i9.PageRouteInfo<void> {
  const SettingRoute({List<_i9.PageRouteInfo>? children})
    : super(SettingRoute.name, initialChildren: children);

  static const String name = 'SettingRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.SettingPage();
    },
  );
}
