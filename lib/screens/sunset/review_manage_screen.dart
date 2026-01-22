import 'package:flutter/material.dart';

class ReviewManageScreen extends StatelessWidget {
  const ReviewManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('리뷰/평가 관리')),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.amber[50], borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(title: '전체 리뷰', value: '1,234'),
                _StatItem(title: '평균 별점', value: '4.5'),
                _StatItem(title: '신고된 리뷰', value: '12'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 20,
              itemBuilder: (context, index) {
                final isReported = index % 5 == 0;
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: isReported ? Colors.red[50] : null,
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        Text('4.5', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    title: Text(isReported ? '[신고] 리뷰 내용...' : '리뷰 내용...'),
                    subtitle: const Text('카페: 카페명 | 작성자: 사용자123 | 2024-01-20'),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'detail', child: Text('상세 보기')),
                        if (isReported) const PopupMenuItem(value: 'delete', child: Text('삭제')),
                      ],
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
  const _StatItem({required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), Text(title, style: const TextStyle(fontSize: 12))]);
  }
}
