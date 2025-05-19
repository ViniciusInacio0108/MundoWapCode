import 'package:flutter/material.dart';
import 'package:mundo_wap_teste/domain/task.dart';
import 'package:mundo_wap_teste/utils/text_styles.dart';

class TaskCard extends StatelessWidget {
  final void Function() onTap;
  final Task task;
  const TaskCard({super.key, required this.onTap, required this.task});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.075),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.name,
                        style: MyAppTextStyle.titleStyleNormal,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        task.description,
                        style: MyAppTextStyle.bodyStyleNormal,
                        maxLines: 3,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (task.done) ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      (task.done) ? 'Realizada' : 'Pendente',
                      style: MyAppTextStyle.bodyStyleBold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_circle_right,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
