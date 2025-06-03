import 'package:flutter/material.dart';

class InformasiRow extends StatelessWidget {
  final String greeting;
  final String companyName;
  final String? logoAssetPath;
  final int notificationCount;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onSearchTap;

  const InformasiRow({
    super.key,
    required this.greeting,
    required this.companyName,
    this.logoAssetPath,
    this.notificationCount = 0,
    this.onNotificationTap,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Logo (optional)
          if (logoAssetPath != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                logoAssetPath!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            )
          else
            const Icon(Icons.account_circle, size: 40, color: Colors.white),

          const SizedBox(width: 12),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  companyName,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Notification icon with badge
          GestureDetector(
            onTap: onNotificationTap,
            child: Stack(
              children: [
                const Icon(Icons.notifications_none, color: Colors.white, size: 28),
                if (notificationCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        notificationCount > 9 ? '9+' : '$notificationCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onSearchTap,
            child: const Icon(Icons.search, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }
}
