import 'dart:io';

class CreateFolders {
  String createFolders(String folderName) {
    String result = "";
    try {
      print("loop");
      var directory = Directory(folderName);

      if (!directory.existsSync()) {
        directory.createSync();
        print('Folder "$folderName" created successfully.');
        result = "folder_created";
      } else {
        result = "folder_already_exist";
      }
    } catch (e) {
      print('Error creating folder: $e');
      result = "error_creating_folder";
    }
    return result;
  }
}
