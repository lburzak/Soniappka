import 'package:easy_beck/dashboard/dashboard_view_model.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/observe_symptom_has_value_today.dart';
import 'package:rxdart/rxdart.dart';

class DashboardController {
  final ObserveSymptomHasValueToday _observeSleep;
  final ObserveSymptomHasValueToday _observeSleepiness;
  final ObserveSymptomHasValueToday _observeIrritability;
  final ObserveSymptomHasValueToday _observeAnxiety;

  late final viewModel = Rx.combineLatest4(
      _observeAnxiety().startWith(false),
      _observeSleep().startWith(false),
      _observeSleepiness().startWith(false),
      _observeIrritability().startWith(false), (isAnxietyFilled, isSleepFilled,
          isSleepinessFilled, isIrritabilityFilled) {
    return DashboardViewModel(
        isAnxietyFilled: isAnxietyFilled,
        isSleepFilled: isSleepFilled,
        isSleepinessFilled: isSleepinessFilled,
        isIrritabilityFilled: isIrritabilityFilled);
  }).share();

  DashboardController(this._observeSleep, this._observeSleepiness,
      this._observeIrritability, this._observeAnxiety);
}
