// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:recon/pages/auth/login_page.dart' as _i5;
import 'package:recon/pages/auth/onboard_page.dart' as _i6;
import 'package:recon/pages/home/home_page.dart' as _i4;
import 'package:recon/pages/tools/base32_page.dart' as _i1;
import 'package:recon/pages/tools/datepicker_page.dart' as _i2;
import 'package:recon/pages/tools/flushbar_page.dart' as _i3;
import 'package:recon/pages/tools/settings_page.dart' as _i7;
import 'package:recon/pages/tools/transformer_bloc_page.dart' as _i8;

/// generated route for
/// [_i1.Base32Page]
class Base32Route extends _i9.PageRouteInfo<void> {
  const Base32Route({List<_i9.PageRouteInfo>? children})
    : super(Base32Route.name, initialChildren: children);

  static const String name = 'Base32Route';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.Base32Page();
    },
  );
}

/// generated route for
/// [_i2.DatePickerPage]
class DatePickerRoute extends _i9.PageRouteInfo<void> {
  const DatePickerRoute({List<_i9.PageRouteInfo>? children})
    : super(DatePickerRoute.name, initialChildren: children);

  static const String name = 'DatePickerRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.DatePickerPage();
    },
  );
}

/// generated route for
/// [_i3.FlushbarPage]
class FlushbarRoute extends _i9.PageRouteInfo<void> {
  const FlushbarRoute({List<_i9.PageRouteInfo>? children})
    : super(FlushbarRoute.name, initialChildren: children);

  static const String name = 'FlushbarRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.FlushbarPage();
    },
  );
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i9.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i10.Key? key,
    required String username,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         HomeRoute.name,
         args: HomeRouteArgs(key: key, username: username),
         initialChildren: children,
       );

  static const String name = 'HomeRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>();
      return _i4.HomePage(key: args.key, username: args.username);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key, required this.username});

  final _i10.Key? key;

  final String username;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [_i5.LoginPage]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute({List<_i9.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i5.LoginPage();
    },
  );
}

/// generated route for
/// [_i6.OnboardPage]
class OnboardRoute extends _i9.PageRouteInfo<void> {
  const OnboardRoute({List<_i9.PageRouteInfo>? children})
    : super(OnboardRoute.name, initialChildren: children);

  static const String name = 'OnboardRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.OnboardPage();
    },
  );
}

/// generated route for
/// [_i7.SettingPage]
class SettingRoute extends _i9.PageRouteInfo<void> {
  const SettingRoute({List<_i9.PageRouteInfo>? children})
    : super(SettingRoute.name, initialChildren: children);

  static const String name = 'SettingRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.SettingPage();
    },
  );
}

/// generated route for
/// [_i8.TransformerBlocPage]
class TransformerBlocRoute extends _i9.PageRouteInfo<void> {
  const TransformerBlocRoute({List<_i9.PageRouteInfo>? children})
    : super(TransformerBlocRoute.name, initialChildren: children);

  static const String name = 'TransformerBlocRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.TransformerBlocPage();
    },
  );
}
