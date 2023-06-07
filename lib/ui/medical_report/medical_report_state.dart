import 'package:ms_task/domain/entities/report_details.dart';

class MedicalReportState {
  final ReportDetails reportDetails;
  final bool showHeader;

  const MedicalReportState({
    required this.reportDetails,
    required this.showHeader,
  });

  factory MedicalReportState.initial() => MedicalReportState(
      reportDetails: ReportDetails.empty(), showHeader: true);

  MedicalReportState copyWith(
          {ReportDetails? reportDetails, bool? showHeader}) =>
      MedicalReportState(
        reportDetails: reportDetails ?? this.reportDetails,
        showHeader: showHeader ?? this.showHeader,
      );
}
