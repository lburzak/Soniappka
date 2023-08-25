import 'dart:core';

abstract interface class DashboardViewModel {
  Stream<int?> get irritabilityLevel;
  Stream<int?> get sleepinessLevel;
  Stream<int?> get anxietyLevel;
  void setIrritability(int level);
  void setSleepiness(int level);
  void setAnxiety(int level);
  void unsetIrritability();
  void unsetSleepiness();
  void unsetAnxiety();
}
