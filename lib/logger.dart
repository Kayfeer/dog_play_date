import 'dart:developer' as developer;
import 'package:logging/logging.dart';

final Logger logger = Logger('DogPlayDate');

void setupLogger() {
  // Définir le niveau de log désiré (par exemple, ALL en développement, INFO ou WARNING en production)
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    // Utilisation de developer.log au lieu de print.
    // Vous pouvez personnaliser ce comportement (par exemple, envoyer ces logs à un service distant en production).
    developer.log(
      '${record.level.name}: ${record.time}: ${record.message}',
      name: record.loggerName,
      level: record.level.value,
    );
  });
}
