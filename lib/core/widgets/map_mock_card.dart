import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class MapMockCard extends StatelessWidget {
  const MapMockCard({
    super.key,
    this.height = 230,
    this.title = 'Delhi route preview',
    this.showCar = true,
  });

  final double height;
  final String title;
  final bool showCar;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(painter: _MapPainter()),
            Positioned(
              left: 16,
              top: 16,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.94),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.route_rounded, size: 18),
                      const SizedBox(width: 8),
                      Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 48,
              bottom: 42,
              child: _MapPin(color: AppColors.primary, icon: Icons.my_location),
            ),
            const Positioned(
              right: 44,
              top: 78,
              child: _MapPin(color: AppColors.danger, icon: Icons.flag_rounded),
            ),
            if (showCar)
              Positioned(
                left: height * 0.72,
                top: height * 0.50,
                child: const CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.ink,
                  child: Icon(Icons.local_taxi_rounded, color: Colors.white, size: 20),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MapPin extends StatelessWidget {
  const _MapPin({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 14,
        backgroundColor: color,
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = const Color(0xFFE8EFE8);
    canvas.drawRect(Offset.zero & size, background);

    final road = Paint()
      ..color = Colors.white
      ..strokeWidth = 18
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final smallRoad = Paint()
      ..color = const Color(0xFFF7F9F7)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    canvas.drawPath(
      Path()
        ..moveTo(-20, size.height * 0.76)
        ..cubicTo(
          size.width * 0.28,
          size.height * 0.62,
          size.width * 0.55,
          size.height * 0.78,
          size.width + 20,
          size.height * 0.25,
        ),
      road,
    );
    canvas.drawLine(
      Offset(size.width * 0.22, -10),
      Offset(size.width * 0.42, size.height + 10),
      smallRoad,
    );
    canvas.drawLine(
      Offset(size.width * 0.76, -10),
      Offset(size.width * 0.64, size.height + 10),
      smallRoad,
    );

    final route = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.16, size.height * 0.76)
        ..cubicTo(
          size.width * 0.42,
          size.height * 0.58,
          size.width * 0.62,
          size.height * 0.70,
          size.width * 0.84,
          size.height * 0.35,
        ),
      route,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
