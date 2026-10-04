import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../domain/entities/character_entity.dart';
import '../domain/services/ai_service.dart';

class ConversationScreen extends StatefulWidget {
  final CharacterEntity character;
  final AiService aiService;
  final Function(String decision)? onDecisionMade;

  const ConversationScreen({
    super.key,
    required this.character,
    required this.aiService,
    this.onDecisionMade,
  });

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _startConversation();
  }

  Future<void> _startConversation() async {
    setState(() => _isLoading = true);
    final response = await widget.aiService.generateText(
      prompt: 'Provide initial strategy consultation for our startup.',
      systemPrompt:
          'You are ${widget.character.name}, the ${widget.character.role.name.toUpperCase()} of the startup. Personality: ${widget.character.personality}.',
    );
    if (mounted) {
      setState(() {
        _messages.add({
          'speaker': widget.character.name,
          'text': response,
        });
        _isLoading = false;
      });
    }
  }

  void _makeChoice(String choice) {
    setState(() {
      _messages.add({
        'speaker': 'Founder (You)',
        'text': choice,
      });
    });
    if (widget.onDecisionMade != null) {
      widget.onDecisionMade!(choice);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Text(
                widget.character.name[0],
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.character.name, style: AppTypography.titleMedium),
                Text(
                  '${widget.character.role.name.toUpperCase()} • Trust: ${widget.character.relationshipScore}%',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    final isUser = msg['speaker'] == 'Founder (You)';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Align(
                        alignment:
                            isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: GlassCard(
                          backgroundColor: isUser
                              ? AppColors.primaryGlow
                              : AppColors.surface,
                          borderColor: isUser
                              ? AppColors.primary
                              : AppColors.cardBorder,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                msg['speaker']!,
                                style: AppTypography.bodySmall.copyWith(
                                  color: isUser
                                      ? AppColors.primary
                                      : AppColors.textSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(msg['text']!,
                                  style: AppTypography.bodyLarge),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              const SizedBox(height: 12),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () =>
                          _makeChoice('Approve proposed engineering strategy'),
                      child: const Text('Approve Strategy'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () =>
                          _makeChoice('Request revised plan with lower burn'),
                      child: const Text('Request Lower Burn'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
