import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/coupon/coupon_provider.dart';
import '../../models/coupon/coupon_model.dart';
import '../../utils/date_formatter.dart';

class CouponManageScreen extends StatefulWidget {
  const CouponManageScreen({super.key});

  @override
  State<CouponManageScreen> createState() => _CouponManageScreenState();
}

class _CouponManageScreenState extends State<CouponManageScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<CouponProvider>(context, listen: false);
      provider.loadAvailableCoupons('cafe1');
    });
  }

  void _showCreateCouponDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final discountController = TextEditingController();
    final minPurchaseController = TextEditingController();
    CouponType selectedType = CouponType.amount;
    DateTime validFrom = DateTime.now();
    DateTime validUntil = DateTime.now().add(const Duration(days: 30));

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('쿠폰 생성'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: '쿠폰 이름', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: '설명', border: OutlineInputBorder()),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<CouponType>(
                  value: selectedType,
                  decoration: const InputDecoration(labelText: '할인 유형', border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: CouponType.amount, child: Text('정액 할인')),
                    DropdownMenuItem(value: CouponType.percent, child: Text('퍼센트 할인')),
                  ],
                  onChanged: (value) => setDialogState(() => selectedType = value!),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: discountController,
                  decoration: InputDecoration(
                    labelText: selectedType == CouponType.amount ? '할인 금액' : '할인 퍼센트',
                    border: const OutlineInputBorder(),
                    suffixText: selectedType == CouponType.amount ? '원' : '%',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: minPurchaseController,
                  decoration: const InputDecoration(labelText: '최소 구매 금액 (선택)', border: OutlineInputBorder(), suffixText: '원'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                ListTile(
                  title: const Text('유효 기간 시작'),
                  subtitle: Text(DateFormatter.formatDate(validFrom)),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: validFrom,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) setDialogState(() => validFrom = picked);
                  },
                ),
                ListTile(
                  title: const Text('유효 기간 종료'),
                  subtitle: Text(DateFormatter.formatDate(validUntil)),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: validUntil,
                      firstDate: validFrom,
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) setDialogState(() => validUntil = picked);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
            TextButton(
              onPressed: () {
                if (titleController.text.isEmpty || descriptionController.text.isEmpty || discountController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('필수 항목을 입력해주세요')));
                  return;
                }
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('쿠폰이 생성되었습니다')));
              },
              child: const Text('생성'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('쿠폰 관리')),
      body: Consumer<CouponProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.availableCoupons.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final coupons = provider.availableCoupons;

          if (coupons.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_offer, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text('생성된 쿠폰이 없습니다'),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('쿠폰 생성하기'),
                    onPressed: _showCreateCouponDialog,
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(title: '전체 쿠폰', value: coupons.length.toString()),
                    _StatItem(title: '활성 쿠폰', value: coupons.where((c) => c.status == CouponStatus.active).length.toString()),
                    _StatItem(title: '만료 예정', value: coupons.where((c) => c.validUntil.isBefore(DateTime.now().add(const Duration(days: 7)))).length.toString()),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => await provider.loadAvailableCoupons('cafe1'),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: coupons.length,
                    itemBuilder: (context, index) {
                      final coupon = coupons[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(color: Colors.orange[100], borderRadius: BorderRadius.circular(8)),
                            child: const Icon(Icons.local_offer, color: Colors.orange),
                          ),
                          title: Text(coupon.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(coupon.description),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Chip(
                                    label: Text(coupon.status == CouponStatus.active ? '활성' : '비활성', style: const TextStyle(fontSize: 10)),
                                    backgroundColor: coupon.status == CouponStatus.active ? Colors.green[100] : Colors.grey[300],
                                  ),
                                  const SizedBox(width: 8),
                                  Text('~ ${DateFormatter.formatDate(coupon.validUntil)}', style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              const PopupMenuItem(value: 'edit', child: Text('수정')),
                              PopupMenuItem(value: 'toggle', child: Text(coupon.status == CouponStatus.active ? '비활성화' : '활성화')),
                              const PopupMenuItem(value: 'delete', child: Text('삭제')),
                            ],
                            onSelected: (value) {
                              if (value == 'delete') _showDeleteDialog(context, coupon.id);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: _showCreateCouponDialog, child: const Icon(Icons.add)),
    );
  }

  void _showDeleteDialog(BuildContext context, String couponId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('쿠폰 삭제'),
        content: const Text('정말로 이 쿠폰을 삭제하시겠습니까?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('쿠폰이 삭제되었습니다')));
            },
            child: const Text('삭제', style: TextStyle(color: Colors.red)),
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
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
