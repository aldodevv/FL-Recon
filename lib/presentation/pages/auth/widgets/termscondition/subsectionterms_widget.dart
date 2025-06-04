import 'package:flutter/material.dart';
import 'package:recon/presentation/pages/auth/widgets/termscondition/dataterms_data.dart';
import 'package:recon/presentation/pages/auth/widgets/termscondition/itemterms_widget.dart';

class SubsectiontermsWidget extends StatelessWidget {
  final TStepData data;

  const SubsectiontermsWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${data.key}. ', style: const TextStyle(fontSize: 14)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.text,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 14),
              ),
              if (data.subData != null)
                ...data.subData!
                    .map((e) => ItemtermsWidget(alfabet: e.key, title: e.text))
                    .toList(),
            ],
          ),
        ),
      ],
    );
  }
}