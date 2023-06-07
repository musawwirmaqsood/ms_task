import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ms_task/data/mock_report_details_repository.dart';
import 'package:ms_task/domain/repositories/report_details_repo.dart';
import 'package:ms_task/ui/medical_report/medical_report_cubit.dart';
import 'package:ms_task/ui/medical_report/medical_report_page.dart';

final getIt = GetIt.instance;
void main() {
  getIt.registerSingleton<ReportDetailsRepository>(
      MockReportDetailsRepository());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MedicalReportCubit(
            getIt()..getReportDetails(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        textTheme: GoogleFonts.latoTextTheme(),
        useMaterial3: true,
      ),
      home: const MedicalReportPage(),
    );
  }
}
