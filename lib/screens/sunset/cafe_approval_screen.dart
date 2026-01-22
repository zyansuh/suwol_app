import 'package:flutter/material.dart';

class CafeApprovalScreen extends StatefulWidget {
  const CafeApprovalScreen({super.key});

  @override
  State<CafeApprovalScreen> createState() => _CafeApprovalScreenState();
}

class _CafeApprovalScreenState extends State<CafeApprovalScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카페 승인 관리'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '승인 대기'),
            Tab(text: '승인된 카페'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 승인 대기 목록
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 5, // TODO: 실제 데이터로 교체
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              '카페 이름',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Chip(
                            label: const Text('승인 대기'),
                            backgroundColor: Colors.orange[100],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('사장님: 홍길동'),
                      const Text('사업자 등록번호: 123-45-67890'),
                      const Text('주소: 서울시 강남구...'),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // TODO: 거부 처리
                            },
                            child: const Text('거부'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              // TODO: 승인 처리
                            },
                            child: const Text('승인'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // 승인된 카페 목록
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 10, // TODO: 실제 데이터로 교체
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.brown,
                    child: Icon(Icons.local_cafe, color: Colors.white),
                  ),
                  title: const Text('카페 이름'),
                  subtitle: const Text('서울시 강남구...'),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'detail',
                        child: Text('상세 정보'),
                      ),
                      const PopupMenuItem(
                        value: 'suspend',
                        child: Text('제휴 중지'),
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
        ],
      ),
    );
  }
}
