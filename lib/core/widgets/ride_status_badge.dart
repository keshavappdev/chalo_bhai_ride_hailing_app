import 'package:flutter/material.dart';

import '../../data/models/ride_model.dart';
import '../theme/app_theme.dart';

class RideStatusBadge extends StatelessWidget {
  const RideStatusBadge({super.key, required this.status});

  final RideStatus status;

  @override
  Widget build(BuildContext context) {
    final isFinished = status == RideStatus.tripCompleted;
    final color = isFinished ? AppColors.primary : AppColors.accent;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          status.label,
          style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
