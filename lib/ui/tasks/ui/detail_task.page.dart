import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:mundo_wap_teste/domain/task.dart';
import 'package:mundo_wap_teste/domain/task_field.dart';
import 'package:mundo_wap_teste/ui/components/custom_appbar.components.dart';
import 'package:mundo_wap_teste/ui/components/custom_button.components.dart';
import 'package:mundo_wap_teste/ui/components/custom_text_form.components.dart';
import 'package:mundo_wap_teste/ui/tasks/viewmodel/detail_task.viewmodel.dart';
import 'package:mundo_wap_teste/ui/tasks/viewmodel/tasks.viewmodel.dart';
import 'package:mundo_wap_teste/utils/response_result.dart';
import 'package:provider/provider.dart';

class DetailTaskPage extends StatefulWidget {
  final Task task;
  const DetailTaskPage({super.key, required this.task});

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> with WidgetsBindingObserver {
  final Map<int, TextEditingController> _controllers = {};
  final GlobalKey<FormState> _formKey = GlobalKey();

  List<TextInputFormatter>? _inputFormatForField(TaskField field) {
    switch (field.fieldType) {
      case EFieldTaskType.mask_price:
        return [
          MoneyInputFormatter(
            leadingSymbol: 'R\$',
            thousandSeparator: ThousandSeparator.Period,
            useSymbolPadding: true,
          )
        ];
      case EFieldTaskType.mask_date:
        return [
          MaskedInputFormatter(
            '##-##-####',
            allowedCharMatcher: RegExp(r'[0-9]'),
          )
        ];
      default:
        return null;
    }
  }

  TextInputType? _inputType(TaskField field) {
    switch (field.fieldType) {
      case EFieldTaskType.mask_price:
        return TextInputType.number;
      case EFieldTaskType.mask_date:
        return TextInputType.number;
      default:
        return null;
    }
  }

  String _onlyDigits(String input) {
    return input.replaceAll(RegExp(r'\D'), '');
  }

  Future<void> _register(bool wasClickedOnButton) async {
    if (_formKey.currentState?.validate() == true) {
      final updatedTask = Task(
        id: widget.task.id,
        name: widget.task.name,
        description: widget.task.description,
        fields: widget.task.fields
            .map(
              (e) => TaskField(
                id: e.id,
                label: e.label,
                required: e.required,
                fieldType: e.fieldType,
                value: (e.fieldType == EFieldTaskType.text)
                    ? _controllers[e.id]?.text ?? e.value
                    : _onlyDigits(_controllers[e.id]?.text ?? e.value),
              ),
            )
            .toList(),
        done: wasClickedOnButton,
      );

      final result = await context.read<DetailTaskViewModel>().registerTask(updatedTask);

      switch (result) {
        case Ok<Task>():
          await context.read<TasksViewModel>().setTasks([]);
          Navigator.pop(context);
          return;
        case Error<Task>():
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.error.toString()),
            ),
          );
          return;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    for (final field in widget.task.fields) {
      _controllers.putIfAbsent(field.id, () => TextEditingController(text: field.value));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addObserver(this);
    _controllers.forEach(
      (key, value) => value.dispose(),
    );
    _controllers.clear();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _register(widget.task.done);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(widget.task.name),
      body: Padding(
        padding: const EdgeInsets.all(36),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CustomTextFormField(
                      controller: _controllers[widget.task.fields[index].id] ?? TextEditingController(),
                      inputFormat: _inputFormatForField(widget.task.fields[index]),
                      textInputType: _inputType(widget.task.fields[index]),
                      label: widget.task.fields[index].label,
                      textInputAction:
                          (index == widget.task.fields.length - 1) ? TextInputAction.done : TextInputAction.next,
                      validator: (value) {
                        if (value?.isEmpty == true || value == null) {
                          return 'Não pode ser vazio.';
                        } else {
                          return null;
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 24),
                  itemCount: widget.task.fields.length,
                ),
              ),
              CustomElevatedTextButton(
                onPressed: () async => _register(true),
                title: 'Marcar como concluída',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
