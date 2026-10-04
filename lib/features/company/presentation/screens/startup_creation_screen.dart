import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../game/domain/entities/game_state.dart';
import '../../domain/services/startup_generator.dart';

class StartupCreationScreen extends StatefulWidget {
  final Function(GameState) onStartupCreated;

  const StartupCreationScreen({
    super.key,
    required this.onStartupCreated,
  });

  @override
  State<StartupCreationScreen> createState() => _StartupCreationScreenState();
}

class _StartupCreationScreenState extends State<StartupCreationScreen> {
  int _currentStep = 0;
  final _companyNameController = TextEditingController(text: 'Aetherium AI');
  final _taglineController =
      TextEditingController(text: 'Autonomous enterprise workflows');
  final _founderNameController = TextEditingController(text: 'Alex Vance');

  String _selectedIndustry = 'AI & Software';
  final List<String> _industries = [
    'AI & Software',
    'Fintech & Payments',
    'CleanTech & Energy',
    'Biotech & Health',
  ];

  final StartupGenerator _generator = StartupGenerator();

  void _generateAiIdea() {
    final generated =
        _generator.generateFallbackStartup(industry: _selectedIndustry);
    setState(() {
      _companyNameController.text = generated.companyName;
      _taglineController.text = generated.tagline;
    });
  }

  void _submit() {
    final newState = GameState(
      companyName: _companyNameController.text.trim(),
      founderName: _founderNameController.text.trim(),
      industry: _selectedIndustry,
      cash: 250000.0,
      monthlyExpenses: 8000.0,
      monthlyRevenue: 0.0,
      employeeCount: 2,
    );
    widget.onStartupCreated(newState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('FOUNDER ONBOARDING',
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.primary, letterSpacing: 2)),
              const SizedBox(height: 8),
              Text('Launch Your Startup', style: AppTypography.displayLarge),
              const SizedBox(height: 24),
              Expanded(
                child: GlassCard(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Select Industry',
                            style: AppTypography.titleMedium),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _industries.map((ind) {
                            final isSelected = _selectedIndustry == ind;
                            return ChoiceChip(
                              label: Text(ind),
                              selected: isSelected,
                              selectedColor: AppColors.primary,
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Colors.black
                                    : AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                              onSelected: (val) {
                                if (val) setState(() => _selectedIndustry = ind);
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _founderNameController,
                          decoration: const InputDecoration(
                            labelText: 'Founder Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _companyNameController,
                                decoration: const InputDecoration(
                                  labelText: 'Company Name',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            IconButton.filled(
                              icon: const Icon(Icons.auto_awesome),
                              tooltip: 'Auto-Generate with AI',
                              onPressed: _generateAiIdea,
                              style: IconButton.styleFrom(
                                backgroundColor: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _taglineController,
                          decoration: const InputDecoration(
                            labelText: 'Company Tagline',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.rocket_launch, color: Colors.black),
                  label: Text('START SIMULATION',
                      style: AppTypography.titleMedium
                          .copyWith(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
