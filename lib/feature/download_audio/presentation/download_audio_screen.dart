import 'package:colosseum_guide/core/route/route_manager.dart';
import 'package:colosseum_guide/core/theme/app_colors.dart';
import 'package:colosseum_guide/feature/download_audio/view_model/download_audio_state.dart';
import 'package:colosseum_guide/feature/download_audio/view_model/download_audio_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DownloadAudioScreen extends ConsumerStatefulWidget {
  const DownloadAudioScreen({super.key});

  @override
  ConsumerState<DownloadAudioScreen> createState() =>
      _DownloadAudioScreenState();
}

class _DownloadAudioScreenState extends ConsumerState<DownloadAudioScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = ref.read(downloadAudioViewModelProvider.notifier);
      if (!vm.currentState.isDownloading &&
          !vm.currentState.isCompleted) {
        vm.startDownload();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(downloadAudioViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHero(context, state),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  _buildHeader(),
                  const SizedBox(height: 26),
                  _buildGuideCard(),
                  const SizedBox(height: 30),
                  _buildProgressSection(state),
                  if (state.hasError) ...[
                    const SizedBox(height: 16),
                    _buildErrorRow(state),
                  ],
                ],
              ),
            ),
          ),
          _buildBottomButton(context, state),
        ],
      ),
    );
  }

  // ── Hero ─────────────────────────────────────────────────────────────────

  Widget _buildHero(BuildContext context, DownloadAudioState state) {
    final topPadding = MediaQuery.of(context).padding.top;
    return SizedBox(
      height: 200 + topPadding,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.55, 1.0],
                  colors: [
                    AppColors.overlayLight,
                    AppColors.overlay,
                    AppColors.background,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: topPadding + 14,
            left: 22,
            child: _StatusPill(state: state),
          ),
        ],
      ),
    );
  }

  // ── Header ───────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Download\nyour guide',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 36,
            fontWeight: FontWeight.w700,
            height: 1.1,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Download once and explore the Colosseum without internet.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 15,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ── Guide card ───────────────────────────────────────────────────────────

  Widget _buildGuideCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 72,
              height: 72,
              child: Image.asset(
                'assets/images/explore03.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.surfaceHigh,
                  child: const Icon(
                    Icons.account_balance,
                    color: AppColors.goldDark,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Colosseum\nEnglish Guide',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Audio, transcript, images\nand offline answers',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceHighest,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Text(
                    '15 audio tracks',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Progress ─────────────────────────────────────────────────────────────

  Widget _buildProgressSection(DownloadAudioState state) {
    final pct = (state.progress * 100).toInt();
    final statusText = switch (state.status) {
      DownloadStatus.downloading => 'Downloading...',
      DownloadStatus.completed => 'Download complete',
      DownloadStatus.error => 'Download failed',
      DownloadStatus.cancelled => 'Download cancelled',
      DownloadStatus.idle => 'Preparing...',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              statusText,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (state.status != DownloadStatus.completed)
              Text(
                '$pct%',
                style: const TextStyle(
                  color: AppColors.gold,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        if (state.currentFile.isNotEmpty &&
            state.status == DownloadStatus.downloading)
          Text(
            '${state.completedFiles} / ${state.totalFiles} — ${state.currentFile}',
            style: TextStyle(
              color: AppColors.textSecondary.withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
        const SizedBox(height: 14),
        _GoldProgressBar(value: state.progress),
        const SizedBox(height: 20),
        if (state.status == DownloadStatus.downloading)
          const Center(
            child: Text(
              'Keep the app open for the fastest download.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        if (state.status == DownloadStatus.completed)
          Center(
            child: Text(
              'All ${state.totalFiles} tracks ready offline.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.success.withValues(alpha: 0.9),
                fontSize: 13,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildErrorRow(DownloadAudioState state) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: AppColors.error, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              state.errorMessage ?? 'Unknown error',
              style: TextStyle(color: AppColors.error, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom button ────────────────────────────────────────────────────────

  Widget _buildBottomButton(BuildContext context, DownloadAudioState state) {
    final bottomPad = MediaQuery.of(context).padding.bottom;

    final isCompleted = state.status == DownloadStatus.completed;
    final isError = state.status == DownloadStatus.error ||
        state.status == DownloadStatus.cancelled;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 12, 24, bottomPad + 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isError)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () => ref
                      .read(downloadAudioViewModelProvider.notifier)
                      .startDownload(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.background,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Retry Download',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: isCompleted
                  ? () => context.goNamed(guidedSpotsViewName)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                disabledBackgroundColor: AppColors.gold.withValues(alpha: 0.25),
                foregroundColor: AppColors.background,
                disabledForegroundColor: AppColors.textDisabled,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: isCompleted
                      ? AppColors.background
                      : AppColors.textDisabled,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Sub-widgets ──────────────────────────────────────────────────────────────

class _StatusPill extends StatelessWidget {
  final DownloadAudioState state;
  const _StatusPill({required this.state});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (state.status) {
      DownloadStatus.downloading => ('Downloading', AppColors.gold),
      DownloadStatus.completed => ('Ready', AppColors.success),
      DownloadStatus.error => ('Error', AppColors.error),
      DownloadStatus.cancelled => ('Cancelled', AppColors.textSecondary),
      DownloadStatus.idle => ('Preparing', AppColors.gold),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.overlay,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StatusDot(color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  final Color color;
  const _StatusDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _GoldProgressBar extends StatelessWidget {
  final double value;
  const _GoldProgressBar({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: FractionallySizedBox(
        widthFactor: value.clamp(0.0, 1.0),
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColors.goldGradient,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: 0.4),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
