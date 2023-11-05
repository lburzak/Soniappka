abstract interface class DashboardRouter {
  void goToBeckTest();
  void showBeckTestAlreadySolvedWarning({required void Function() onProceed});
}
