import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_card.dart';

class BoardRoomScreen extends StatefulWidget {
  final Function(String vote)? onVoteSubmitted;

  const BoardRoomScreen({
    super.key,
    this.onVoteSubmitted,
  });

  @override
  State<BoardRoomScreen> createState() => _BoardRoomScreenState();
}

class _BoardRoomScreenState extends State<BoardRoomScreen> {
  String? _selectedVote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('Q3 BOARD MEETING'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('BOARDROOM AGENDA',
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.primary, letterSpacing: 2)),
              const SizedBox(height: 6),
              Text('Capital Allocation Strategy',
                  style: AppTypography.headlineMedium),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildExecutiveStatement(
                      name: 'Dr. Elena Rostova (CTO)',
                      roleColor: AppColors.primary,
                      statement:
                          'Our infrastructure is strained under recent traffic growth. We must invest \$50k in database architecture optimization now.',
                    ),
                    const SizedBox(height: 12),
                    _buildExecutiveStatement(
                      name: 'Sarah Chen (CFO)',
                      roleColor: AppColors.secondary,
                      statement:
                          'We only have 8 months of runway. Spending \$50k without new revenue commitments compromises our Series A positioning.',
                    ),
                    const SizedBox(height: 12),
                    _buildExecutiveStatement(
                      name: 'Marcus Sterling (Lead Investor)',
                      roleColor: AppColors.warning,
                      statement:
                          'I side with capital efficiency. Show me 15% MoM growth before expanding infrastructure spend.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('FOUNDER DECISION', style: AppTypography.titleMedium),
                    const SizedBox(height: 12),
                    RadioListTile<String>(
                      title: const Text('Approve CTO Tech Debt Investment (\$50k)'),
                      value: 'cto_plan',
                      groupValue: _selectedVote,
                      onChanged: (val) => setState(() => _selectedVote = val),
                    ),
                    RadioListTile<String>(
                      title: const Text('Side with CFO: Enforce Capital Discipline'),
                      value: 'cfo_plan',
                      groupValue: _selectedVote,
                      onChanged: (val) => setState(() => _selectedVote = val),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _selectedVote == null
                      ? null
                      : () {
                          if (widget.onVoteSubmitted != null) {
                            widget.onVoteSubmitted!(_selectedVote!);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.surface,
                  ),
                  child: Text('SUBMIT BOARD VOTE',
                      style: AppTypography.titleMedium
                          .copyWith(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExecutiveStatement({
    required String name,
    required Color roleColor,
    required String statement,
  }) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: roleColor,
                child: Text(name[0],
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              ),
              const SizedBox(width: 8),
              Text(name,
                  style: AppTypography.bodySmall
                      .copyWith(color: roleColor, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(statement, style: AppTypography.bodyLarge),
        ],
      ),
    );
  }
}
