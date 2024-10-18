import 'package:gchat/src/common/enums/page_status.enums.dart';

class PageState {
  final PageStatus status;
  final String message;

  const PageState({required this.status, this.message = ''});
}
