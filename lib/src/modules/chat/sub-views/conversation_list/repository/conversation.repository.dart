import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:gchat/src/core/api/api_response.dart';
import 'package:gchat/src/core/api/api_service.dart';
import 'package:gchat/src/core/api/endpoints.dart';
import 'package:gchat/src/core/api/extension.api.dart';
import 'package:gchat/src/modules/chat/sub-views/conversation_list/model/conversation.model.dart';

class ConversationRepository {
  ApiService _apiService;
  ConversationRepository(ApiService apiService) : _apiService = apiService;

  Future<Pair<ApiResponse, List<Conversation>>> fetchConversations(
    int page,
  ) async {
    ApiResponse response = await _apiService
        .get('${ApiEndpoints.FETCH_CONVERSATIONS}?page=$page&limit=10', {});
    List<Conversation> conversations = [];

    if (response.isSuccessful) {
      conversations = (response.data as List<dynamic>)
          .map((e) => Conversation.fromJSON(e))
          .toList();
    }
    return Pair(response, conversations);
  }
}
