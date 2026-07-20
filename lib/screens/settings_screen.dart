import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rto_assmant/providers/app_state_provider.dart';
import 'package:rto_assmant/widgets/glass_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppStateProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent, // Displays the custom theme background
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            children: [
              _buildSectionTitle('Preferences'),
              const SizedBox(height: 12),
              GlassCard(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  children: [
                    _buildSwitchTile(
                      icon: Icons.dark_mode_outlined,
                      title: 'Dark Mode',
                      subtitle: 'Optimize interface brightness',
                      value: state.darkMode,
                      onChanged: (val) => state.updateSetting('darkMode', val),
                    ),
                    const Divider(color: Colors.white10),
                    _buildSwitchTile(
                      icon: Icons.notifications_none_outlined,
                      title: 'Notifications',
                      subtitle: 'Weekly leaderboard and reset alerts',
                      value: state.notifications,
                      onChanged: (val) => state.updateSetting('notifications', val),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Audio'),
              const SizedBox(height: 12),
              GlassCard(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  children: [
                    _buildSwitchTile(
                      icon: Icons.music_note_outlined,
                      title: 'Background Music',
                      subtitle: 'Ambient soundtrack during gameplay',
                      value: state.music,
                      onChanged: (val) => state.updateSetting('music', val),
                    ),
                    const Divider(color: Colors.white10),
                    _buildSwitchTile(
                      icon: Icons.volume_up_outlined,
                      title: 'Sound Effects',
                      subtitle: 'Keypress and level up audios',
                      value: state.sound,
                      onChanged: (val) => state.updateSetting('sound', val),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Language & Account'),
              const SizedBox(height: 12),
              GlassCard(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDropdownTile(
                      icon: Icons.translate,
                      title: 'Language',
                      value: state.language,
                      items: const [
                        DropdownMenuItem(value: 'en', child: Text('English', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 'hi', child: Text('Hindi (हिंदी)', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 'es', child: Text('Spanish (Español)', style: TextStyle(color: Colors.white))),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          state.updateSetting('language', val);
                        }
                      },
                    ),
                    const Divider(color: Colors.white10),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.info_outline, color: Color(0xFFD1C4E9)),
                      title: const Text('App Version', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                      trailing: const Text('v1.0.0', style: TextStyle(color: Colors.white70)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent.withOpacity(0.15),
                  foregroundColor: Colors.redAccent,
                  shadowColor: Colors.transparent,
                  side: const BorderSide(color: Colors.redAccent, width: 1),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.delete_forever_outlined),
                label: const Text('Reset Game Progress', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () => _showResetConfirmationDialog(context, state),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFFD1C4E9),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: const Color(0xFFD1C4E9)),
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 12)),
      trailing: Switch(
        value: value,
        activeColor: Colors.cyanAccent,
        activeTrackColor: Colors.cyan.withOpacity(0.3),
        inactiveThumbColor: Colors.white54,
        inactiveTrackColor: Colors.white10,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: const Color(0xFFD1C4E9)),
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      trailing: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items,
          onChanged: onChanged,
          dropdownColor: const Color(0xFF1E1A31),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
        ),
      ),
    );
  }

  void _showResetConfirmationDialog(BuildContext context, AppStateProvider state) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1A31),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
              SizedBox(width: 8),
              Text(
                'Reset Progress?',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text(
            'This will permanently reset all your levels, coins, gems, achievements, and weekly scores. This action cannot be undone.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await state.resetProgress();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('🎉 Game progress has been reset successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text('Reset', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}
