import 'package:args/args.dart';

import 'src/create/create_blockchain.dart';
import 'src/create/create_projects.dart';

void main(List<String> args) {
  final ArgParser argParser = ArgParser();
  argParser.addCommand("create");
  argParser.addCommand("generate");
  CreateProjects createProjects = CreateProjects();
  CreateTestBlockchain createTestBlockchain = CreateTestBlockchain();

  final ArgResults argResults = argParser.parse(args);
  if (argResults.command != null) {
    if (argResults.command!.name == "create") {
      var result = argResults.command!.rest;
      createProjects.createProjects(result[0]);
      createTestBlockchain.pullDockerImage();
    } else if (argResults.command!.name == "generate") {}
  }
}
