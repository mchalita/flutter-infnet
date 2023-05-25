import 'package:flutter/material.dart';
import 'package:projeto_disciplina/routes/route_paths.dart';
import 'package:projeto_disciplina/screens/tarefa_show_screen.dart';

import 'screens/tarefa_insert_screen.dart';
import 'screens/tarefa_list_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          RoutePaths.HOME: (context) => TarefaListScreen(),
          RoutePaths.TAREFA_SHOW_SCREEN: (context) => TarefaShowScreen(),
          RoutePaths.TAREFA_INSERT_SCREEN: (context) => TarefaInsertScreen(),
        }
    );
  }
}
