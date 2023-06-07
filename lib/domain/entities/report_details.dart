class ReportDetails {
  final String diseaseName;
  final String reviewedBy;
  final String writtenBy;
  final String updatedOn;
  final Map<String, String> otherInfo;

  const ReportDetails({
    required this.diseaseName,
    required this.reviewedBy,
    required this.writtenBy,
    required this.updatedOn,
    required this.otherInfo,
  });

  ReportDetails.empty()
      : diseaseName = '',
        reviewedBy = '',
        writtenBy = '',
        updatedOn = '',
        otherInfo = {};
}
