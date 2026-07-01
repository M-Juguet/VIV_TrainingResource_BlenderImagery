import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/theme/viv_colors.dart';
import '../../core/theme/viv_spacing.dart';
import '../../core/theme/viv_typography.dart';
import '../../core/storage/settings_provider.dart';
import '../../core/storage/update_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final updateState = ref.watch(updateProvider);
    final localVersion = updateState.localVersion ?? '0.1.0';

    ref.listen<UpdateState>(updateProvider, (previous, next) {
      if (previous?.status == UpdateStatus.checking) {
        if (next.status == UpdateStatus.upToDate) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Vous disposez déjà de la dernière version.'),
              backgroundColor: VivColors.limeDeep,
            ),
          );
        } else if (next.status == UpdateStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.errorMessage ?? 'Erreur de vérification.'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    });

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
          _buildSectionHeader('Mise à jour', LucideIcons.refreshCw),
          const SizedBox(height: VivSpacing.space4),
          _buildCard([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rechercher une mise à jour', style: VivTypography.small.copyWith(fontWeight: FontWeight.bold)),
                    Text(
                      updateState.status == UpdateStatus.checking
                          ? 'Vérification en cours sur GitHub...'
                          : 'Vérifier manuellement si une nouvelle version est disponible.',
                      style: VivTypography.small.copyWith(color: VivColors.gray500),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: VivColors.black,
                    foregroundColor: VivColors.lime,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(VivSpacing.radiusMd),
                    ),
                  ),
                  onPressed: updateState.status == UpdateStatus.checking
                      ? null
                      : () => ref.read(updateProvider.notifier).checkForUpdates(silent: false),
                  child: Text(
                    updateState.status == UpdateStatus.checking ? 'Recherche...' : 'Vérifier',
                    style: VivTypography.small.copyWith(fontWeight: FontWeight.bold, color: VivColors.lime),
                  ),
                ),
              ],
            ),
          ]),
          const SizedBox(height: VivSpacing.space8),
          _buildSectionHeader('À propos', LucideIcons.info),
          const SizedBox(height: VivSpacing.space4),
          _buildCard([
            _buildInfoRow('Nom de l\'application', '[SU] Matériaux et rendu dans Blender : les fondamentaux'),
            const Divider(height: VivSpacing.space6, color: VivColors.gray100),
            _buildInfoRow('Version de l\'application', localVersion),
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
