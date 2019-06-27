import 'dart:io';

void main(List<String> args) {
  Process.run('grep', ['-i', 'main', 'Package Installer.dart']).then((result) {
    print(result);
  });
}