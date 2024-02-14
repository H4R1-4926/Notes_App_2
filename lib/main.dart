import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:yt_dupe/Application/Home_Bloc/home_bloc.dart';
import 'package:yt_dupe/Domain/Core/Dependency_injection/injectable.dart';
import 'package:yt_dupe/Domain/Home/model/home_model.dart';
import 'package:yt_dupe/Presentation/HomeScreen/home.dart';

void main() async {
  await configureInjectable();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(NoteModelAdapter().typeId)) {
    Hive.registerAdapter(NoteModelAdapter());
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit<HomeBloc>(),
      child:
          const GetMaterialApp(debugShowCheckedModeBanner: false, home: Home()),
    );
  }
}
