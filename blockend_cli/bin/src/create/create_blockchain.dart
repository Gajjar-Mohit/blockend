import 'dart:io';

class CreateTestBlockchain {
  Future<bool> pullDockerImage() async {
    final process = await Process.start(
      'docker',
      ['pull', 'ethereum/client-go'],
      runInShell: true,
    );

    final exitCode = await process.exitCode;
    if (exitCode != 0) {
      throw 'Failed to pull Docker image.';
    }
    print('Docker image pulled successfully.');
    return true;
  }

  Future<void> runDockerContainer() async {
    final process = await Process.start(
      'docker-compose',
      ['up'],
      runInShell: true,
    );

    // Optionally, you can handle the process output if needed
    // process.stdout.transform(utf8.decoder).listen((data) {
    //   print('stdout: $data');
    // });

    // process.stderr.transform(utf8.decoder).listen((data) {
    //   print('stderr: $data');
    // });

    final exitCode = await process.exitCode;
    if (exitCode != 0) {
      throw 'Failed to run Docker container.';
    }

    print('Blockchain is now running.');
  }
}
