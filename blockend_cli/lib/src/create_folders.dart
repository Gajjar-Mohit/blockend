import 'dart:io';

class CreateFolders {
  String createFolders(String folderName) {
    String result = "";
    try {
      var directory = Directory(folderName);

      if (!directory.existsSync()) {
        directory.createSync();
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
