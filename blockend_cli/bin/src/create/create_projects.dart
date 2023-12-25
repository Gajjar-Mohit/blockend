import 'dart:io';

import 'create_folders.dart';

class CreateProjects {
  CreateFolders createFolders = CreateFolders();
  Future createTruffleProject(String projectName) async {
    String res = createFolders.createFolders("${projectName}_truffle_project");
    if (res == "folder_created") {
      Directory.current = "${projectName}_truffle_project";
      try {
        await Process.run('truffle', ['init']);
      } catch (e) {
        print('Error creating Truffle project: $e');
      }
    } else {
      print('Error creating Truffle project: $res');
    }
  }

  Future createProjects(String projectName) async {
    var initialDirectory = Directory.current.path;
    Directory.current = initialDirectory;
    Process.run("flutter", ['create', "${projectName}_flutter_project"])
        .then((value) {
      print('Flutter project created successfully.');
      createTruffleProject(projectName).then((value) {
        print('Truffle project created successfully.');
      });
    });
  }
}
