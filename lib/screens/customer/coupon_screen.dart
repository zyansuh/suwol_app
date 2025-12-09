import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/coupon/coupon_provider.dart';
import '../../widgets/coupon/coupon_card.dart';
import '../../utils/date_formatter.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({super.key});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // TODO: 실제 사용자 ID로 변경
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<CouponProvider>(context, listen: false);
      provider.loadUserCoupons('user1');
    });
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
        title: const Text('쿠폰'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '보유 쿠폰'),
            Tab(text: '사용 완료'),
          ],
        ),
      ),
      body: Consumer<CouponProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.userCoupons.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final availableCoupons = provider.userCoupons
              .where((coupon) => !coupon.isUsed)
              .toList();
          final usedCoupons = provider.userCoupons
              .where((coupon) => coupon.isUsed)
              .toList();

          return TabBarView(
            controller: _tabController,
            children: [
              // 보유 쿠폰
              RefreshIndicator(
                onRefresh: () async {
                  await provider.loadUserCoupons('user1');
                },
                child: availableCoupons.isEmpty
                    ? const Center(
                        child: Text('보유한 쿠폰이 없습니다'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: availableCoupons.length,
                        itemBuilder: (context, index) {
                          final userCoupon = availableCoupons[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CouponCard(
                              title: userCoupon.coupon.title,
                              description: userCoupon.coupon.description,
                              validUntil: userCoupon.coupon.validUntil,
                              onTap: () {
                                // 쿠폰 사용 다이얼로그
                                _showUseCouponDialog(context, userCoupon.id);
                              },
                            ),
                          );
                        },
                      ),
              ),
              // 사용 완료
              RefreshIndicator(
                onRefresh: () async {
                  await provider.loadUserCoupons('user1');
                },
                child: usedCoupons.isEmpty
                    ? const Center(
                        child: Text('사용한 쿠폰이 없습니다'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: usedCoupons.length,
                        itemBuilder: (context, index) {
                          final userCoupon = usedCoupons[index];
                          return Opacity(
                            opacity: 0.6,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: CouponCard(
                                title: userCoupon.coupon.title,
                                description: userCoupon.coupon.description,
                                validUntil: userCoupon.coupon.validUntil,
                                onTap: null,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showUseCouponDialog(BuildContext context, String userCouponId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('쿠폰 사용'),
        content: const Text('이 쿠폰을 사용하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () async {
              final provider =
                  Provider.of<CouponProvider>(context, listen: false);
              await provider.useCoupon(userCouponId);
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('쿠폰이 사용되었습니다')),
                );
              }
            },
            child: const Text('사용'),
          ),
        ],
      ),
    );
  }
}
