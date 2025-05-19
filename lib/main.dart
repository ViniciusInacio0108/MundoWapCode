import 'package:flutter/material.dart';
import 'package:mundo_wap_teste/data/repositories/login/login_repository_remote.dart';
import 'package:mundo_wap_teste/data/repositories/task/task_repository_local.dart';
import 'package:mundo_wap_teste/data/services/api_client.service.dart';
import 'package:mundo_wap_teste/data/services/db.service.dart';
import 'package:mundo_wap_teste/ui/login/login.dart';
import 'package:mundo_wap_teste/ui/tasks/tasks.dart';
import 'package:mundo_wap_teste/ui/tasks/viewmodel/detail_task.viewmodel.dart';
import 'package:mundo_wap_teste/utils/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(
            loginRemoteRepo: LoginRespositoryRemote(
              remoteService: RemoteService(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => TasksViewModel(
            localTaskRepo: TaskLocalRepository(
              dbService: DBService(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailTaskViewModel(
            taskLocalRepo: TaskLocalRepository(
              dbService: DBService(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Mundo Wap',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: MyAppRoutes().routes,
      ),
    );
  }
}
