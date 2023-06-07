import 'package:ms_task/domain/entities/report_details.dart';

class MedicalReportState {
  final ReportDetails reportDetails;

  const MedicalReportState({required this.reportDetails});

  factory MedicalReportState.initial() =>
      MedicalReportState(reportDetails: ReportDetails.empty());

  MedicalReportState copyWith({ReportDetails? reportDetails}) =>
      MedicalReportState(reportDetails: reportDetails ?? this.reportDetails);
}
