import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_task/domain/repositories/report_details_repo.dart';
import 'package:ms_task/ui/medical_report/medical_report_state.dart';

class MedicalReportCubit extends Cubit<MedicalReportState> {
  final ReportDetailsRepository reportDetailsRepository;
  MedicalReportCubit(this.reportDetailsRepository)
      : super(MedicalReportState.initial());

  void onInit() {
    getReportDetails();
  }

  void getReportDetails() {
    final resonse = reportDetailsRepository.getReportDetails();
    emit(state.copyWith(reportDetails: resonse));
  }
}
