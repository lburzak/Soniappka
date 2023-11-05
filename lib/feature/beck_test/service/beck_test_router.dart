import 'package:easy_beck/domain/beck_test/model/beck_test_id.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract interface class BeckTestRouter {
  void goToTestResult(BeckTestId id);
}

class GoBeckTestRouter implements BeckTestRouter {
  final BuildContext _context;

  GoBeckTestRouter(this._context);

  @override
  void goToTestResult(BeckTestId id) {
    _context.replace("/beck-test/${id.serialize()}/result");
  }
}
