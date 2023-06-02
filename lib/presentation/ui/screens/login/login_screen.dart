import 'package:flutter/material.dart';
import 'package:flutter_learning_english/presentation/ui/widgets/text_field_widget/text_field_widget.dart';

import '../../widgets/scaffold_wdiget/scaffold_widget.dart';
import 'login_contants.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            TextFieldWidget(
              controller: controller,
              hintText: LoginContant.hintEmail,
            ),
            TextFieldWidget(
              controller: controller,
              hintText: LoginContant.hintPass,
            ),
          ],
        ),
      ),
    );
  }
}
