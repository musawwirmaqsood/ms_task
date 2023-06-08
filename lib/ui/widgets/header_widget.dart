import 'package:flutter/material.dart';
import 'package:ms_task/domain/entities/report_details.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({required this.report, super.key});

  final ReportDetails report;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/medicine_background.jpg',
                  fit: BoxFit.fitWidth,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: size.width - 40,
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        color: Colors.grey[300]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Medically reviewd by',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          report.reviewedBy,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 40,
                  bottom: 24,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      'assets/female_doctor.jpg',
                      height: 60,
                      width: 60,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Text(
            report.diseaseName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Written by',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    report.writtenBy,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Updated on',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    report.updatedOn,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Divider(
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
