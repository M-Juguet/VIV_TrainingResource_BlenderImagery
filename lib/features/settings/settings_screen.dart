import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';


import '../../core/theme/viv_colors.dart';
import '../../core/theme/viv_spacing.dart';
import '../../core/theme/viv_typography.dart';
import '../../core/storage/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(VivSpacing.space6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Application', LucideIcons.monitor),
          const SizedBox(height: VivSpacing.space4),
          _buildCard([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Afficher en plein écran', style: VivTypography.small.copyWith(fontWeight: FontWeight.bold)),
                    Text('Bascule l\'application en mode plein écran immersif.', style: VivTypography.small.copyWith(color: VivColors.gray500)),
                  ],
                ),
                ShadSwitch(
                  value: settings.isFullScreen,
                  onChanged: (val) => ref.read(settingsProvider.notifier).setFullScreen(val),
                ),
              ],
            ),
          ]),
          const SizedBox(height: VivSpacing.space8),
          _buildSectionHeader('À propos', LucideIcons.info),
          const SizedBox(height: VivSpacing.space4),
          _buildCard([
            _buildInfoRow('Nom de l\'application', '[SU] Intitulé de la formation'),
            const Divider(height: VivSpacing.space6, color: VivColors.gray100),
            _buildInfoRow('Version de l\'application', '0.1.0'),
            const Divider(height: VivSpacing.space6, color: VivColors.gray100),
            _buildInfoRow('Copyright', '© 2026 VIV. Tous droits réservés.'),
          ]),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: VivTypography.small.copyWith(
            fontWeight: FontWeight.w500,
            color: VivColors.gray500,
          ),
        ),
        Text(
          value,
          style: VivTypography.small.copyWith(
            fontWeight: FontWeight.bold,
            color: VivColors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: VivColors.lime),
        const SizedBox(width: VivSpacing.space3),
        Text(title, style: VivTypography.h4.copyWith(color: VivColors.black)),
      ],
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(VivSpacing.space6),
      decoration: BoxDecoration(
        color: VivColors.paper,
        borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
        border: Border.all(color: VivColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
