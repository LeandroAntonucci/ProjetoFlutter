import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/services/ai_service.dart';
import '../../../core/services/auth_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController =
      TextEditingController();

  final ScrollController _scrollController =
      ScrollController();

  final AiService _aiService = AiService();

  bool _isLoading = false;

  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();

    _messages.add({
      "isUser": false,
      "text": "Olá! Como posso te ajudar hoje?",
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();

    if (text.isEmpty || _isLoading) return;

    final authService =
        Provider.of<AuthService>(context, listen: false);

    setState(() {
      _messages.add({
        "isUser": true,
        "text": text,
      });

      _isLoading = true;
    });

    _messageController.clear();

    _scrollToBottom();

    try {
      final response = await _aiService.sendMessage(
        message: text,
        token: authService.token,
      );

      setState(() {
        _messages.add({
          "isUser": false,
          "text": response,
        });
      });
    } catch (e) {
      setState(() {
        _messages.add({
          "isUser": false,
          "text": "Erro ao conectar com IA.",
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });

      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,

        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.main,
              radius: 18,
              child: const Icon(
                LucideIcons.bot,
                size: 20,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  "Lavinia",
                  style: AppTextStyles.h3,
                ),

                Text(
                  authService.userName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.border,
            height: 1,
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];

                return _ChatBubble(
                  isUser: msg['isUser'],
                  text: msg['text'],
                );
              },
            ),
          ),

          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: LinearProgressIndicator(),
            ),

          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),

      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.border,
            width: 2,
          ),
        ),
      ),

      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.inputBackground,
                  borderRadius:
                      BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.border,
                    width: 1.5,
                  ),
                ),

                child: TextField(
                  controller: _messageController,

                  onSubmitted: (_) =>
                      _sendMessage(),

                  decoration: const InputDecoration(
                    hintText: "Digite sua dúvida...",
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            GestureDetector(
              onTap: _isLoading
                  ? null
                  : _sendMessage,

              child: Container(
                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: _isLoading
                      ? Colors.grey
                      : AppColors.main,

                  shape: BoxShape.circle,

                  border: Border.all(
                    color: AppColors.border,
                    width: 1.5,
                  ),
                ),

                child: const Icon(
                  LucideIcons.send,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final bool isUser;
  final String text;

  const _ChatBubble({
    required this.isUser,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser
          ? Alignment.centerRight
          : Alignment.centerLeft,

      child: Container(
        margin: const EdgeInsets.only(bottom: 16),

        constraints: BoxConstraints(
          maxWidth:
              MediaQuery.of(context).size.width * 0.75,
        ),

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color:
              isUser ? AppColors.main : Colors.white,

          border: Border.all(
            color: AppColors.border,
            width: 2,
          ),

          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),

            bottomLeft:
                Radius.circular(isUser ? 20 : 0),

            bottomRight:
                Radius.circular(isUser ? 0 : 20),
          ),
        ),

        child: Text(
          text,

          style: AppTextStyles.body.copyWith(
            color: isUser
                ? AppColors.textOnMain
                : Colors.black,

            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}