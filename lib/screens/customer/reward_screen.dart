import 'package:flutter/material.dart';
import '../../models/reward/reward_model.dart';
import '../../utils/format_helper.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  // TODO: 실제 데이터로 교체
  final int currentPoints = 3500;
  final RewardLevel currentLevel = RewardLevel.silver;
  final int totalVisits = 12;

  RewardLevel get nextLevel {
    if (currentLevel == RewardLevel.bronze) return RewardLevel.silver;
    if (currentLevel == RewardLevel.silver) return RewardLevel.gold;
    if (currentLevel == RewardLevel.gold) return RewardLevel.platinum;
    return RewardLevel.platinum;
  }

  double get progress {
    final currentRequired = currentLevel.requiredPoints;
    final nextRequired = nextLevel.requiredPoints;
    if (nextRequired == currentRequired) return 1.0;
    return (currentPoints - currentRequired) /
        (nextRequired - currentRequired);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('리워드 & 등급'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 현재 등급 카드
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getLevelColor(currentLevel),
                      ),
                      child: Center(
                        child: Text(
                          currentLevel.displayName[0],
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      currentLevel.displayName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      FormatHelper.formatPoints(currentPoints),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // 다음 등급까지 진행률
            const Text(
              '다음 등급까지',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          nextLevel.displayName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${FormatHelper.formatPoints(currentPoints)} / ${FormatHelper.formatPoints(nextLevel.requiredPoints)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: progress.clamp(0.0, 1.0),
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getLevelColor(nextLevel),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${FormatHelper.formatPoints(nextLevel.requiredPoints - currentPoints)} 더 적립하면 ${nextLevel.displayName} 등급이 됩니다',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // 통계 정보
            const Text(
              '활동 통계',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.local_cafe,
                            size: 32,
                            color: Colors.brown,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$totalVisits',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            '방문 횟수',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.stars,
                            size: 32,
                            color: Colors.amber,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            FormatHelper.formatPoints(currentPoints),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            '보유 포인트',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // 등급별 혜택
            const Text(
              '등급별 혜택',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...RewardLevel.values.map((level) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getLevelColor(level),
                      child: Text(
                        level.displayName[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      level.displayName,
                      style: TextStyle(
                        fontWeight: level == currentLevel
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(
                      '${FormatHelper.formatPoints(level.requiredPoints)} 이상',
                    ),
                    trailing: level == currentLevel
                        ? const Chip(
                            label: Text('현재 등급'),
                            backgroundColor: Colors.green,
                          )
                        : null,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Color _getLevelColor(RewardLevel level) {
    switch (level) {
      case RewardLevel.bronze:
        return Colors.brown[300]!;
      case RewardLevel.silver:
        return Colors.grey[400]!;
      case RewardLevel.gold:
        return Colors.amber;
      case RewardLevel.platinum:
        return Colors.blue[300]!;
    }
  }
}
