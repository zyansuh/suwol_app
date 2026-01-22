import 'package:flutter/material.dart';

class PostManageScreen extends StatefulWidget {
  const PostManageScreen({super.key});

  @override
  State<PostManageScreen> createState() => _PostManageScreenState();
}

class _PostManageScreenState extends State<PostManageScreen> {
  String _selectedFilter = '전체';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 관리'),
      ),
      body: Column(
        children: [
          // 필터
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['전체', '신고된 게시글', '삭제된 게시글']
                          .map((filter) {
                        final isSelected = _selectedFilter == filter;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(filter),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedFilter = filter;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          // 게시글 목록
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 15, // TODO: 실제 데이터로 교체
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: const Text('게시글 제목/내용 미리보기...'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('작성자: 사용자명'),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.favorite, size: 16),
                            const Text(' 123'),
                            const SizedBox(width: 16),
                            const Icon(Icons.comment, size: 16),
                            const Text(' 45'),
                            const SizedBox(width: 16),
                            Text(
                              '2024-01-01',
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
                          child: Text('상세 보기'),
                        ),
                        const PopupMenuItem(
                          value: 'hide',
                          child: Text('숨기기'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('삭제'),
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
