import 'package:flutter/material.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

abstract class BaseStatelessWidget extends StatelessWidget {
  static StylishDialog? _progressDialog;

  const BaseStatelessWidget({Key? key}) : super(key: key);

  void _initProgressDialog(BuildContext context) {
    _progressDialog = StylishDialog(
      context: context,
      alertType: StylishDialogType.PROGRESS,
      contentText: 'Please wait...',
      dismissOnTouchOutside: false,
    );
  }

  Future<void> showProgressDialog(BuildContext context) async {
    _initProgressDialog(context);
    if (_progressDialog != null) {
      await _progressDialog?.show();
    }
  }

  void dismissProgressDialog() {
    _progressDialog?.dismiss();
    _progressDialog = null;
  }
}
