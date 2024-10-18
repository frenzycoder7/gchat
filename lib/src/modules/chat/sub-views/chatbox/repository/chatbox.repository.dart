import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:gchat/src/core/api/api_response.dart';
import 'package:gchat/src/core/api/api_service.dart';
import 'package:gchat/src/core/api/endpoints.dart';
import 'package:gchat/src/core/api/extension.api.dart';
import 'package:gchat/src/modules/chat/sub-views/chatbox/model/message.model.dart';

class ChatBoxRepository {
  ApiService _apiService;
  ChatBoxRepository(ApiService apiService) : _apiService = apiService;

  Future<Pair<ApiResponse, Map<String, Message>>> getMessages(
      String conversationId, int page) async {
    ApiResponse response = await _apiService.get(
        '${ApiEndpoints.FETCH_CONVERSATION_MESSAGES}?cid=$conversationId&page=$page',
        null);
    Map<String, Message> messages = {};
    if (response.isSuccessful) {
      List<dynamic> data = response.data;
      for (var item in data) {
        Message message = Message.fromJSON(item);
        messages[message.localId] = message;
      }
    }
    return Pair(response, messages);
  }
}
