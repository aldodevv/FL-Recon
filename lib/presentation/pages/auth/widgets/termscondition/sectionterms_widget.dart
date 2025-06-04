import 'package:flutter/material.dart';
import 'package:recon/presentation/pages/auth/widgets/termscondition/dataterms_data.dart';
import 'package:recon/presentation/pages/auth/widgets/termscondition/subsectionterms_widget.dart';

class SectiontermsWidget extends StatelessWidget {
  final TSectionData section;

  const SectiontermsWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${section.key}. ${section.title}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        if (section.data != null)
          ...section.data!.map((e) => SubsectiontermsWidget(data: e)),
        if (section.text != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              section.text!,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}