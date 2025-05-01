// lib/commands/add_model_command.dart
import 'dart:io';

import 'package:recase/recase.dart';

class AddModelCommand {
  Future<void> run(String name) async {
    final snake = ReCase(name).snakeCase;
    final pascal = ReCase(name).pascalCase;

    File('lib/domain/models/$snake.dart')
      ..createSync(recursive: true)
      ..writeAsStringSync('''
import 'package:freezed_annotation/freezed_annotation.dart';
part '$snake.freezed.dart';
part '$snake.g.dart';

@freezed
class $pascal with _\$$pascal {
  const factory $pascal({
    required String id,
  }) = _$pascal;

  factory $pascal.fromJson(Map<String, dynamic> json) => _\$${pascal}FromJson(json);
}''');

    File('lib/data/model/${snake}_api_model.dart')
      ..createSync(recursive: true)
      ..writeAsStringSync('// TODO: Define $pascal API model');

    print('Model "$name" created in domain and data layers.');
  }
}
