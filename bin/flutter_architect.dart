// bin/flutter_architect.dart
import 'dart:io';

import 'package:flutter_architect/commands/add_feature_command.dart';
import 'package:flutter_architect/commands/add_model_command.dart';
import 'package:flutter_architect/commands/add_repo_command.dart';
import 'package:flutter_architect/commands/add_service_command.dart';
import 'package:flutter_architect/commands/create_command.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print(
      "No command provided. Use: create | add-feature | add-model | add-service | add-repo",
    );
    exit(1);
  }

  final command = arguments[0];
  final name = arguments.length > 1 ? arguments[1] : null;

  switch (command) {
    case 'create':
      await CreateCommand().run();
      break;
    case 'add-feature':
      if (name == null) {
        print("Please provide a feature name.");
        exit(1);
      }
      await AddFeatureCommand().run(name);
      break;
    case 'add-model':
      if (name == null) {
        print("Please provide a model name.");
        exit(1);
      }
      await AddModelCommand().run(name);
      break;
    case 'add-service':
      if (name == null) {
        print("Please provide a service name.");
        exit(1);
      }
      await AddServiceCommand().run(name);
      break;
    case 'add-repo':
      if (name == null) {
        print("Please provide a repository name.");
        exit(1);
      }
      await AddRepoCommand().run(name);
      break;
    default:
      print("Unknown command: \$command");
  }
}
