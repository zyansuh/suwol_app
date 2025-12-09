import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/point/point_provider.dart';
import '../../models/point/point_model.dart';
import '../../widgets/point/point_card.dart';
import '../../utils/format_helper.dart';
import '../../utils/date_formatter.dart';

class PointScreen extends StatefulWidget {
  const PointScreen({super.key});

  @override
  State<PointScreen> createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: 실제 사용자 ID로 변경
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PointProvider>(context, listen: false);
      provider.loadTotalPoints('user1');
      provider.loadPointHistory('user1');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('통합 포인트'),
      ),
      body: Consumer<PointProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.pointHistory.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              await provider.loadTotalPoints('user1');
              await provider.loadPointHistory('user1');
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PointCard(
                      totalPoints: provider.totalPoints,
                      onTap: () {},
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '포인트 내역',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // 필터링 기능 (전체/적립/사용)
                          },
                          child: const Text('전체'),
                        ),
                      ],
                    ),
                  ),
                ),
                if (provider.pointHistory.isEmpty)
                  const SliverFillRemaining(
                    child: Center(
                      child: Text('포인트 내역이 없습니다'),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final point = provider.pointHistory[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: point.type == PointType.earn
                                  ? Colors.green
                                  : Colors.orange,
                              child: Icon(
                                point.type == PointType.earn
                                    ? Icons.add
                                    : Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              point.type == PointType.earn
                                  ? '포인트 적립'
                                  : '포인트 사용',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              point.description ?? '카페 이용',
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${point.type == PointType.earn ? '+' : '-'}${FormatHelper.formatPoints(point.amount)}',
                                  style: TextStyle(
                                    color: point.type == PointType.earn
                                        ? Colors.green
                                        : Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateFormatter.formatRelativeTime(point.createdAt),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: provider.pointHistory.length,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
