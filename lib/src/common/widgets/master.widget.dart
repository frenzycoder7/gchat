import 'package:flutter/material.dart';
import 'package:gchat/src/common/enums/page_status.enums.dart';
import 'package:gchat/src/common/extensions/context.extension.dart';
import 'package:gchat/src/common/models/page_state.model.dart';

class MasterWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final PageState pageState;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Function onRetry;
  const MasterWidget({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.drawer,
    this.bottomNavigationBar,
    required this.pageState,
    this.loadingWidget,
    this.errorWidget,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: _buildBody(context, pageState),
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  Widget _buildBody(BuildContext context, PageState status) {
    switch (status.status) {
      case PageStatus.LOADING:
        return loadingWidget ?? context.loadingWidget();
      case PageStatus.LOADED:
        return body ?? const SizedBox();
      case PageStatus.ERROR:
        return errorWidget ??
            context.errorWidget(
              status.message,
              () {
                onRetry();
              },
            );
      case PageStatus.NETWORK_ERROR:
        return context.networkError(onRetry: onRetry);
      case PageStatus.UN_AUTHORIZED:
        return context.unauthorized();
      default:
        return context.otherError("Something went wrong!");
    }
  }
}
