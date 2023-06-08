import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_task/ui/medical_report/medical_report_cubit.dart';
import 'package:ms_task/ui/medical_report/medical_report_state.dart';
import 'package:ms_task/ui/scroll_list_tab/scroll_list_tab.dart';
import 'package:ms_task/ui/widgets/youtube_player_widget.dart';

class MedicalReportPage extends StatefulWidget {
  const MedicalReportPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MedicalReportPage> createState() => _MedicalReportPagePageState();
}

class _MedicalReportPagePageState extends State<MedicalReportPage> {
  late MedicalReportCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<MedicalReportCubit>(context);
    cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          state as MedicalReportState;
          return ScrollableListTabView(
            tabHeight: 48,
            reportDetails: state.reportDetails,
            bodyAnimationDuration: const Duration(milliseconds: 150),
            tabAnimationCurve: Curves.easeOut,
            tabAnimationDuration: const Duration(milliseconds: 200),
            tabs: _generateScrollableListTabs(state.reportDetails.otherInfo),
          );
        });
  }

  List<ScrollableListTab> _generateScrollableListTabs(
      Map<String, String> data) {
    List<ScrollableListTab> list = [];
    data.forEach((key, value) {
      list.add(ScrollableListTab(
        tab: ListTab(
          label: key,
        ),
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(value),
            ),
            if (key == 'Causes')
              const Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
                child: YoutubePlayerWidget(
                    videoUrl: 'https://www.youtube.com/watch?v=HyKyfNkoBOo'),
              ),
          ],
        ),
      ));
    });
    return list;
  }
}
