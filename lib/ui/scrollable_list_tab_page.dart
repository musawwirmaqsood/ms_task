import 'package:flutter/material.dart';
import 'package:ms_task/ui/scroll_list_tab/scroll_list_tab.dart';
import 'package:ms_task/util/constants.dart';
import 'package:ms_task/ui/widgets/header_widget.dart';
import 'package:ms_task/ui/widgets/youtube_player_widget.dart';

class ScrollableListTabPage extends StatefulWidget {
  @override
  _ScrollableListTabPageState createState() => _ScrollableListTabPageState();
}

class _ScrollableListTabPageState extends State<ScrollableListTabPage> {
  final Map<String, String> gestationalDiabetesData = {
    'Overview': Constants.gestationalDiabetesOverview,
    'Signs And Symptoms': Constants.gestationalDiabetesSignsAndSymptoms,
    'Causes': Constants.gestationalDiabetesCauses,
    'Effects': Constants.gestationalDiabetesEffects,
    'Diagnosis': Constants.gestationalDiabetesDiagnosis,
    'Treatment': Constants.gestationalDiabetesTreatment,
  };

  @override
  Widget build(BuildContext context) {
    return ScrollableListTabView(
      
      tabHeight: 48,
      bodyAnimationDuration: const Duration(milliseconds: 150),
      tabAnimationCurve: Curves.easeOut,
      tabAnimationDuration: const Duration(milliseconds: 200),
      tabs: _generateScrollableListTabs(gestationalDiabetesData),
    );
    // return Scaffold(
    //   body: CustomScrollView(
    //     slivers: <Widget>[
    //           const SliverAppBar(
    //               actions: <Widget>[
    //                 Icon(
    //                   Icons.person,
    //                   size: 40,
    //                 )
    //               ],
    //               title: Text("SliverAppBar Example"),
    //               leading: Icon(Icons.menu),
    //               backgroundColor: Colors.green,
    //               expandedHeight: 100.0,
    //               floating: false,
    //               pinned: false),

    //           // SliverList(
    //           //     delegate: SliverChildListDelegate([
    //           //   Container(
    //           //     height: 600,
    //           //     color: Colors.red,
    //           //     child: ScrollableListTabView(
    //           //       tabHeight: 48,
    //           //       bodyAnimationDuration: const Duration(milliseconds: 150),
    //           //       tabAnimationCurve: Curves.easeOut,
    //           //       tabAnimationDuration: const Duration(milliseconds: 200),
    //           //       tabs: _generateScrollableListTabs(gestationalDiabetesData),
    //           //     ),
    //           //   ),
    //           //   Container(
    //           //     height: 600,
    //           //     color: Colors.pink,
    //           //   ),
    //           // ]
    //           // ))
    //         ] +
    //         [
    //           ScrollableListTabView(
    //             tabHeight: 48,
    //             bodyAnimationDuration: const Duration(milliseconds: 150),
    //             tabAnimationCurve: Curves.easeOut,
    //             tabAnimationDuration: const Duration(milliseconds: 200),
    //             tabs: _generateScrollableListTabs(gestationalDiabetesData),
    //           ),
    //         ],
    //   ),

    //   // appBar: const PreferredSize(
    //   //     preferredSize: Size.fromHeight(300), child: HeaderWidget()),
    //   // body: ScrollableListTabView(
    //   //   tabHeight: 48,
    //   //   bodyAnimationDuration: const Duration(milliseconds: 150),
    //   //   tabAnimationCurve: Curves.easeOut,
    //   //   tabAnimationDuration: const Duration(milliseconds: 200),
    //   //   tabs: _generateScrollableListTabs(gestationalDiabetesData),
    //   // ),
    // );
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
