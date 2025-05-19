import 'package:flutter/material.dart';
import 'package:mundo_wap_teste/domain/user.dart';
import 'package:mundo_wap_teste/ui/components/custom_button.components.dart';
import 'package:mundo_wap_teste/ui/components/custom_text_form.components.dart';
import 'package:mundo_wap_teste/ui/login/login.dart';
import 'package:mundo_wap_teste/ui/tasks/tasks.dart';
import 'package:mundo_wap_teste/utils/text_styles.dart';
import 'package:mundo_wap_teste/utils/utils.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _form = GlobalKey();

  Future<void> login(BuildContext context) async {
    if (_form.currentState?.validate() == true) {
      final result = await context.read<LoginViewModel>().login(
            _usernameController.text,
            _passwordController.text,
          );

      switch (result) {
        case Ok<User>():
          await context.read<TasksViewModel>().setTasks(result.value.tasks);
          Navigator.pushReplacementNamed(context, MyAppRoutes.TASKS_PAGE);
          break;
        case Error<User>():
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.read<LoginViewModel>().loginErrorMessage),
            ),
          );
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(36),
        child: Center(
          child: Form(
            key: _form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Bem-vindo!',
                  maxLines: 1,
                  style: MyAppTextStyle.headerStyleBold,
                ),
                const Text(
                  'Realize seu login',
                  maxLines: 1,
                  style: MyAppTextStyle.titleStyleNormal,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextFormField(
                  controller: _usernameController,
                  label: 'Username',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextFormField(
                  controller: _passwordController,
                  label: 'Password',
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomElevatedTextButton(
                  onPressed: () async => login(context),
                  title: 'Entrar',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
