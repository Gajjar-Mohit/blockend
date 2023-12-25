import 'dart:io';

import 'package:args/args.dart';
import 'package:hello/hello.dart';
import 'package:hello/src/create_folders.dart';

void main(List<String> args) {
  print("Welcome to Blockend CLI...");
  // print(args);
  final ArgParser argParser = ArgParser();
  argParser.addCommand("create");
  // Create().createTruffleProject();
  CreateFolders createFolders = CreateFolders();
  CreateProjects createProjects = CreateProjects();

  final ArgResults argResults = argParser.parse(args);
  if (argResults.command != null) {
    if (argResults.command!.name == "create") {
      var result = argResults.command!.rest;
      // print(result);
      // print("Creating Flutter project...");

      createProjects.createProjects(result[0]);

      // createProjects.createTruffleProject(result[0]);
      // print("Creating Truffle project...");
    }
  }
}
