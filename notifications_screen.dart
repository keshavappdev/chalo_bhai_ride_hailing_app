import 'package:flutter/material.dart';
import 'package:ride_hailing_app/core/constants/app_colors.dart';
import 'package:ride_hailing_app/data/models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _notifications = _generateMockNotifications();
        _isLoading = false;
      });
    });
  }

  List<NotificationModel> _generateMockNotifications() {
    return [
      NotificationModel(
        id: '1',
        userId: 'user1',
        title: 'Ride Completed',
        message: 'Your ride with John Doe has been completed. Thank you for riding!',
        type: NotificationType.ride,
        isRead: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      NotificationModel(
        id: '2',
        userId: 'user1',
        title: 'Payment Successful',
        message: 'Your payment of ₹170 has been processed successfully.',
        type: NotificationType.payment,
        isRead: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      NotificationModel(
        id: '3',
        userId: 'user1',
        title: 'Special Offer',
        message: 'Get 20% off on your next ride! Use code: RIDE20',
        type: NotificationType.promotion,
        isRead: true,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      NotificationModel(
        id: '4',
        userId: 'user1',
        title: 'New Driver Assigned',
        message: 'Your driver has been assigned. Track your ride in real-time.',
        type: NotificationType.driver,
        isRead: true,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      NotificationModel(
        id: '5',
        userId: 'user1',
        title: 'System Update',
        message: 'New features available! Update your app for the best experience.',
        type: NotificationType.system,
        isRead: true,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
              });
            },
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notifications.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No notifications',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return _buildNotificationCard(notification);
        },
      ),
    );
  }

  Widget _buildNotificationCard(NotificationModel notification) {
    IconData icon;
    Color color;
    switch (notification.type) {
      case NotificationType.ride:
        icon = Icons.car_rental;
        color = AppColors.primary;
        break;
      case NotificationType.payment:
        icon = Icons.payment;
        color = AppColors.success;
        break;
      case NotificationType.promotion:
        icon = Icons.local_offer;
        color = AppColors.warning;
        break;
      case NotificationType.system:
        icon = Icons.system_update;
        color = AppColors.info;
        break;
      case NotificationType.driver:
        icon = Icons.person;
        color = AppColors.secondary;
        break;
      default:
        icon = Icons.notifications;
        color = AppColors.textSecondary;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: notification.isRead ? null : AppColors.primary.withOpacity(0.05),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(
          notification.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.message),
            const SizedBox(height: 4),
            Text(
              _formatTime(notification.createdAt),
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        trailing: notification.isRead
            ? null
            : Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        onTap: () {
          if (!notification.isRead) {
            setState(() {
              _notifications = _notifications.map((n) {
                if (n.id == notification.id) {
                  return n.copyWith(isRead: true);
                }
                return n;
              }).toList();
            });
          }
          // Handle notification tap
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 7) {
      return '${time.day}/${time.month}/${time.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}