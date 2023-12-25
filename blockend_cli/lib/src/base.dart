import 'package:args/args.dart';
import 'package:blockend_cli/blockend_cli.dart';


void main(List<String> args) {
  final ArgParser argParser = ArgParser();
  argParser.addCommand("create");
  CreateProjects createProjects = CreateProjects();

  final ArgResults argResults = argParser.parse(args);
  if (argResults.command != null) {
    if (argResults.command!.name == "create") {
      var result = argResults.command!.rest;
      createProjects.createProjects(result[0]);
    }
  }
}
