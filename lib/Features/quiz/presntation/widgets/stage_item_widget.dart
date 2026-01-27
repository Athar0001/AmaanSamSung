import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/quiz/data/model/top_ten_model.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';

class StageItemWidget extends StatelessWidget {
  const StageItemWidget({
    super.key,
    required this.child,
    required this.rank,
  });

  final ChildModel child;
  final int rank;

  @override
  Widget build(BuildContext context) {
    final Color podiumColor;
    final double height;
    final IconData icon;

    switch (rank) {
      case 1:
        podiumColor = const Color(0xFFFFD700); // Gold
        height = 180;
        icon = Icons.emoji_events;
        break;
      case 2:
        podiumColor = const Color(0xFFC0C0C0); // Silver
        height = 150;
        icon = Icons.workspace_premium;
        break;
      case 3:
        podiumColor = const Color(0xFFCD7F32); // Bronze
        height = 120;
        icon = Icons.military_tech;
        break;
      default:
        podiumColor = Colors.grey;
        height = 100;
        icon = Icons.person;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Profile image with crown/badge
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: podiumColor, width: 3),
              ),
              child: ClipOval(
                child: child.childImage?.presignedUrl != null
                    ? CachedNetworkImage(
                        imageUrl: child.childImage!.presignedUrl!,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: Colors.grey.shade800,
                        child: Icon(
                          Icons.person,
                          color: AppColorsNew.white,
                          size: 40,
                        ),
                      ),
              ),
            ),
            if (rank <= 3)
              Positioned(
                top: -10,
                child: Icon(
                  icon,
                  color: podiumColor,
                  size: 30,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        // Name
        Text(
          child.childName ?? '',
          style: TextStyle(
            color: AppColorsNew.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        // Podium
        Container(
          width: 100,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                podiumColor,
                podiumColor.withValues(alpha: 0.7),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '#$rank',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${child.totalScore}',
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
