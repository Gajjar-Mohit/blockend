import 'dart:io';

import 'package:hello/src/create_folders.dart';

class CreateProjects {
  CreateFolders createFolders = CreateFolders();
  Future createTruffleProject(String projectName) async {
    String res = createFolders.createFolders("${projectName}_truffle_project");
    if (res == "folder_created") {
      Directory.current = "${projectName}_truffle_project";
      try {
        await Process.run('truffle', ['init']);
        print(
            'Truffle project created successfully. {Directory: ${Directory.current}}');
      } catch (e) {
        print('Error creating Truffle project: $e');
      }
    }
  }

  Future createProjects(String projectName) async {
    var initialDirectory = Directory.current.path;
    Directory.current = initialDirectory;
    Process.run("flutter", ['create', "${projectName}_flutter_project"])
        .then((value) {
      print(
          'Flutter project created successfully. {Directory: ${Directory.current}}');
      createTruffleProject(projectName).then((value) {
        print(
            'Truffle project created successfully. {Directory: ${Directory.current}}');
      });
    });

    // try {
    //   await Process.run(
    //       'flutter', ['create', "${projectName}_flutter_project"]);
    //   print(
    //       'Flutter project created successfully. {Directory: ${Directory.current}}');
    // } catch (e) {
    //   print('Error creating Flutter project: $e');
    // }
  }
}
