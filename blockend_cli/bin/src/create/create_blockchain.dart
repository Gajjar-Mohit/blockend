import 'dart:io';

class CreateTestBlockchain {
  Future<bool> isDockerInstalled() async {
    final process = await Process.start(
      'docker',
      ['--version'],
      runInShell: true,
    );

    final exitCode = await process.exitCode;
    return exitCode == 0;
  }

  Future<bool> isDockerRunning() async {
    final process = await Process.start(
      'docker',
      ['info'],
      runInShell: true,
    );

    final exitCode = await process.exitCode;
    return exitCode == 0;
  }

  Future<bool> pullDockerImage() async {
    if (!await isDockerInstalled()) {
      throw 'Docker is not installed.';
    }

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
}
