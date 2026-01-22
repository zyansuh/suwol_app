import 'package:flutter/material.dart';

class ReportManageScreen extends StatefulWidget {
  const ReportManageScreen({super.key});

  @override
  State<ReportManageScreen> createState() => _ReportManageScreenState();
}

class _ReportManageScreenState extends State<ReportManageScreen> with SingleTickerProviderStateMixin {
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
        title: const Text('신고/문의 관리'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: '신고 관리'), Tab(text: '문의 관리')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_ReportList(), _InquiryList()],
      ),
    );
  }
}

class _ReportList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: const Icon(Icons.report, color: Colors.red),
            title: const Text('게시글 신고'),
            subtitle: const Text('신고자: 사용자123 | 2024-01-22'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('신고 사유:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('부적절한 내용'),
                    const SizedBox(height: 8),
                    const Text('상세 내용:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('욕설 및 비방 내용이 포함되어 있습니다.'),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () {}, child: const Text('신고 기각')),
                        const SizedBox(width: 8),
                        ElevatedButton(onPressed: () {}, child: const Text('게시글 삭제')),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InquiryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 8,
      itemBuilder: (context, index) {
        final isAnswered = index % 3 == 0;
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: Icon(isAnswered ? Icons.check_circle : Icons.help, color: isAnswered ? Colors.green : Colors.orange),
            title: const Text('서비스 이용 문의'),
            subtitle: const Text('작성자: 사용자456 | 2024-01-22'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('문의 내용:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('포인트 적립이 안 되는데 어떻게 해야 하나요?'),
                    const SizedBox(height: 12),
                    if (isAnswered) ...[
                      const Divider(),
                      const Text('답변:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                      const Text('확인 결과 정상 적립되었습니다. 앱 재시작 후 확인해주세요.'),
                    ] else ...[
                      TextField(
                        decoration: const InputDecoration(labelText: '답변 작성', border: OutlineInputBorder()),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(onPressed: () {}, child: const Text('답변 등록')),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
