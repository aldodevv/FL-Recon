// // pages/home_screen.dart
// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:recon/presentation/bloc/transaction/balance/balance_bloc.dart';
// import 'package:recon/presentation/bloc/transaction/balance/balance_event.dart';
// import 'package:recon/presentation/widgets/home/SaldoCard.dart';

// @RoutePage()
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
//   Widget build(BuildContext contex) {
//     // return BlocBuilder(create: (_) => BalanceBloc(), child: const _HomePageState())
//   }
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();
//     _triggerBalance();
//   }

//   void _triggerBalance() async {
//     context.read<BalanceBloc>().add(
//       BalanceRequested(
//         accountList: ['ALL'],
//         accountType: ["CA", "TD", "SA"],
//         currency: "IDR",
//         lang: "ID",
//         year: "2025",
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Saldocard(
//             title: 'Total Saldo',
//             currency: 'IDR',
//             value: '12,345,678',
//             dateTime: '14 Feb 2023, 13:53',
//             isHidden: false,
//             selectedCurrency: 'IDR',
//             onToggleVisibility: () {
//               // logika untuk show/hide saldo
//             },
//             onTapDetail: () {
//               // navigasi ke detail
//             },
//             onCurrencyChange: (String newCurrency) {
//               // update state currency (IDR <-> USD)
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
