// TODO Implement this library.
// lib/commands/add_feature_command.dart
import 'dart:io';

import 'package:recase/recase.dart';

class AddFeatureCommand {
  Future<void> run(String name) async {
    final featureName = ReCase(name).snakeCase;
    final pascal = ReCase(name).pascalCase;
    final featurePath = 'lib/ui/$featureName';
    final widgetsPath = '$featurePath/widgets';
    final viewModelPath = '$featurePath/view_model';

    Directory(widgetsPath).createSync(recursive: true);
    Directory(viewModelPath).createSync(recursive: true);

    File('$widgetsPath/${featureName}_screen.dart')
      ..createSync()
      ..writeAsStringSync('''
import 'package:flutter/material.dart';

class ${pascal}Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('$pascal Screen')),
    );
  }
}''');

    File('$viewModelPath/${featureName}_view_model.dart')
      ..createSync()
      ..writeAsStringSync('class ${pascal}ViewModel {}');

    print('Feature "$name" added successfully.');
  }
}
