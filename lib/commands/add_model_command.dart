// lib/commands/add_model_command.dart
import 'dart:convert';
import 'dart:io';

import 'package:recase/recase.dart';

class AddModelCommand {
  Future<void> run(String name, String? jsonPath) async {
    final snake = ReCase(name).snakeCase;
    final pascal = ReCase(name).pascalCase;

    String fields = 'required String id,';
    if (jsonPath != null && File(jsonPath).existsSync()) {
      final jsonString = File(jsonPath).readAsStringSync();
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      fields = jsonMap.entries
          .map((e) => 'required ${_inferType(e.value)} ${e.key},')
          .join('\n    ');
    }

    File('lib/domain/models/$snake.dart')
      ..createSync(recursive: true)
      ..writeAsStringSync('''
import 'package:freezed_annotation/freezed_annotation.dart';
part '$snake.freezed.dart';
part '$snake.g.dart';

@freezed
class $pascal with _\$$pascal {
  const factory $pascal({
    $fields
  }) = _$pascal;

  factory $pascal.fromJson(Map<String, dynamic> json) => _\$${pascal}FromJson(json);
}''');

    File('lib/data/repositories/${snake}_repository.dart')
      ..createSync(recursive: true)
      ..writeAsStringSync('''
abstract class I${pascal}Repository {
  // TODO: Define repository interface
}

class ${pascal}Repository implements I${pascal}Repository {
  // TODO: Implement repository methods
}''');

    File('lib/data/services/${snake}_service.dart')
      ..createSync(recursive: true)
      ..writeAsStringSync('''
class ${pascal}Service {
  // TODO: Implement $pascal service methods
}''');

    print(
      '✅ Model, repository, and service for "$name" created. Run build_runner now.',
    );
  }

  String _inferType(dynamic value) {
    if (value is int) return 'int';
    if (value is double) return 'double';
    if (value is bool) return 'bool';
    return 'String';
  }
}
