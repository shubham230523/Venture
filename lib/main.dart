import 'package:flutter/material.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'features/company/presentation/screens/dashboard_screen.dart';
import 'features/company/presentation/screens/startup_creation_screen.dart';
import 'features/game/domain/entities/game_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const VentureApp());
}

class VentureApp extends StatefulWidget {
  const VentureApp({super.key});

  @override
  State<VentureApp> createState() => _VentureAppState();
}

class _VentureAppState extends State<VentureApp> {
  GameState? _activeState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Venture — AI Startup Simulator',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: _activeState == null
          ? StartupCreationScreen(
              onStartupCreated: (createdState) {
                setState(() => _activeState = createdState);
              },
            )
          : DashboardScreen(
              initialState: _activeState!,
            ),
    );
  }
}
