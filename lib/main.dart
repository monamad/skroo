import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skroo/logics/players_provider.dart';
import 'package:skroo/presentation/views/Home_view.dart';
import 'package:skroo/presentation/views/dash_board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlayersProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: HomeView.routeName,
        routes: {
          HomeView.routeName: (context) => const HomeView(),
          Dashboard.routeName: (context) => const Dashboard(),
        },
      ),
    );
  }
}
