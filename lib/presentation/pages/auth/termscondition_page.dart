import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recon/presentation/pages/auth/widgets/termscondition/agreementerms_widget.dart';
import 'package:recon/presentation/pages/auth/widgets/termscondition/dataterms_data.dart';
import 'package:recon/presentation/pages/auth/widgets/termscondition/sectionterms_widget.dart';

@RoutePage()
class TermsconditionPage extends StatefulWidget {
  const TermsconditionPage({super.key});

  @override
  State<TermsconditionPage> createState() => _TermsconditionPageState();
}

class _TermsconditionPageState extends State<TermsconditionPage> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dataRender.length,
        itemBuilder: (context, index) {
          final section = dataRender[index];
          return SectiontermsWidget(section: section);
        },
      ),
      bottomNavigationBar: AgreementermsWidget(
        checked: isChecked,
        onCheck: () => setState(() => isChecked = !isChecked),
        onLogin: () {
          // proses login
        },
        loading: false,
        disableCheckbox: false,
        disableButton: !isChecked,
      ),
    );
  }
}
