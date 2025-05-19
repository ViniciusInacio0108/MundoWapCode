import 'package:flutter/material.dart';
import 'package:mundo_wap_teste/ui/components/custom_appbar.components.dart';
import 'package:mundo_wap_teste/ui/features.dart';
import 'package:mundo_wap_teste/ui/tasks/ui/widget/task_card.dart';
import 'package:mundo_wap_teste/utils/routes.dart';
import 'package:mundo_wap_teste/utils/text_styles.dart';
import 'package:provider/provider.dart';

class ListTasksPage extends StatelessWidget {
  const ListTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TasksViewModel>().tasks;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.build('Olá, ${context.read<LoginViewModel>().firstName}!'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Suas tarefas',
              style: MyAppTextStyle.header2StyleBold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 12,
            ),
            (tasks.isEmpty)
                ? const Center(
                    child: Text('Sem tarefas disponíveis.'),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) => TaskCard(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          MyAppRoutes.DETAIL_TASK_PAGE,
                          arguments: tasks[index],
                        );
                      },
                      task: tasks[index],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
