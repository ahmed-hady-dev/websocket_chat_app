import 'package:supabase/supabase.dart';

class MessageRepository {
  const MessageRepository({required this.dbClient});

  final SupabaseClient dbClient;
  createMessage() {
    throw UnimplementedError();
  }

  Future<List<Map<String, dynamic>>> fetchMessages(String chatRoomId) async {
    try {
      final messages = await dbClient.from('messages').select<PostgrestList>().eq('chat_room_id', chatRoomId);
      return messages;
    } catch (err) {
      throw Exception(err);
    }
  }
}
