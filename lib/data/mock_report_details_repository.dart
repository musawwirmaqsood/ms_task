import 'package:ms_task/domain/entities/report_details.dart';
import 'package:ms_task/domain/repositories/report_details_repo.dart';
import 'package:ms_task/util/constants.dart';

class MockReportDetailsRepository implements ReportDetailsRepository {
  @override
  ReportDetails getReportDetails() {
    return ReportDetails(
        diseaseName: 'Diabetes\n(Gestational)',
        reviewedBy: 'Dr Sadia Khan(PhD)',
        writtenBy: 'Dr. Nimrah H.Sattar',
        updatedOn: 'October 20, 2022',
        otherInfo: {
          'Overview': Constants.gestationalDiabetesOverview,
          'Signs And Symptoms': Constants.gestationalDiabetesSignsAndSymptoms,
          'Causes': Constants.gestationalDiabetesCauses,
          'Effects': Constants.gestationalDiabetesEffects,
          'Diagnosis': Constants.gestationalDiabetesDiagnosis,
          'Treatment': Constants.gestationalDiabetesTreatment,
        });
  }
}
