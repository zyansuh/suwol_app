import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cafe/cafe_provider.dart';
import '../../providers/coupon/coupon_provider.dart';
import '../../widgets/coupon/coupon_card.dart';
import '../../routes/app_router.dart';

class CafeDetailScreen extends StatefulWidget {
  final String cafeId;

  const CafeDetailScreen({
    super.key,
    required this.cafeId,
  });

  @override
  State<CafeDetailScreen> createState() => _CafeDetailScreenState();
}

class _CafeDetailScreenState extends State<CafeDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cafeProvider =
          Provider.of<CafeProvider>(context, listen: false);
      final couponProvider =
          Provider.of<CouponProvider>(context, listen: false);
      cafeProvider.loadCafe(widget.cafeId);
      couponProvider.loadAvailableCoupons(widget.cafeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<CafeProvider, CouponProvider>(
        builder: (context, cafeProvider, couponProvider, child) {
          final cafe = cafeProvider.selectedCafe;

          if (cafeProvider.isLoading && cafe == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (cafe == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('카페 상세')),
              body: const Center(child: Text('카페 정보를 불러올 수 없습니다')),
            );
          }

          return CustomScrollView(
            slivers: [
              // AppBar with image
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(cafe.name),
                  background: cafe.imageUrl != null
                      ? Image.network(
                          cafe.imageUrl!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.brown[200],
                          child: const Icon(
                            Icons.local_cafe,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 주소
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              cafe.address,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      if (cafe.phoneNumber != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.phone, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              cafe.phoneNumber!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                      if (cafe.description != null) ...[
                        const SizedBox(height: 16),
                        const Text(
                          '소개',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(cafe.description!),
                      ],
                      const SizedBox(height: 24),
                      // 사용 가능한 쿠폰
                      const Text(
                        '사용 가능한 쿠폰',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (couponProvider.isLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (couponProvider.availableCoupons.isEmpty)
                        const Text('사용 가능한 쿠폰이 없습니다')
                      else
                        ...couponProvider.availableCoupons.map((coupon) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CouponCard(
                              title: coupon.title,
                              description: coupon.description,
                              validUntil: coupon.validUntil,
                              onTap: () {
                                _showIssueCouponDialog(
                                  context,
                                  coupon.id,
                                );
                              },
                            ),
                          );
                        }),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showIssueCouponDialog(BuildContext context, String couponId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('쿠폰 발급'),
        content: const Text('이 쿠폰을 발급받으시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () async {
              final provider =
                  Provider.of<CouponProvider>(context, listen: false);
              // TODO: 실제 사용자 ID 사용
              await provider.issueCoupon('user1', couponId);
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('쿠폰이 발급되었습니다')),
                );
              }
            },
            child: const Text('발급'),
          ),
        ],
      ),
    );
  }
}
