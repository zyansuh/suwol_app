import 'package:flutter/material.dart';

class CouponManageScreen extends StatelessWidget {
  const CouponManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('쿠폰 관리'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: 필터 다이얼로그
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 통계 카드
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(title: '전체 쿠폰', value: '1,234'),
                _StatItem(title: '활성 쿠폰', value: '890'),
                _StatItem(title: '사용 완료', value: '344'),
              ],
            ),
          ),
          // 쿠폰 목록
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 20, // TODO: 실제 데이터로 교체
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.local_offer, size: 30),
                    ),
                    title: const Text('쿠폰 이름'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('카페: 카페 이름'),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Chip(
                              label: const Text('활성'),
                              labelStyle: const TextStyle(fontSize: 10),
                              backgroundColor: Colors.green[100],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '유효기간: 2024-12-31',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'detail',
                          child: Text('상세 정보'),
                        ),
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('수정'),
                        ),
                        const PopupMenuItem(
                          value: 'deactivate',
                          child: Text('비활성화'),
                        ),
                      ],
                      onSelected: (value) {
                        // TODO: 액션 처리
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final String value;

  const _StatItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
