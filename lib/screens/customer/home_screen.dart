import 'package:flutter/material.dart';
import 'package:suwol/widgets/cafe/cafe_card.dart';
import 'package:suwol/widgets/common/app_button.dart';
import 'package:suwol/widgets/coupon/coupon_card.dart';
import 'package:suwol/widgets/point/point_card.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카페링크 수월'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future<void>.delayed(const Duration(milliseconds: 500));
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: _HeaderSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: PointCard(
                    totalPoints: 12500,
                    onTap: () {},
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '내 쿠폰',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('전체 보기'),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 160,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final coupon = _dummyCoupons[index];
                      return SizedBox(
                        width: 260,
                        child: CouponCard(
                          title: coupon.title,
                          description: coupon.description,
                          validUntil: coupon.validUntil,
                          onTap: () {},
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemCount: _dummyCoupons.length,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '주변 카페',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('더 보기'),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList.separated(
                itemBuilder: (context, index) {
                  final cafe = _dummyCafes[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CafeCard(
                      name: cafe.name,
                      address: cafe.address,
                      distance: cafe.distance,
                      imageUrl: cafe.imageUrl,
                      onTap: () {},
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemCount: _dummyCafes.length,
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '우리 동네 카페들이 하나로 이어지다',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          Text(
            '카페링크 수월',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: '카페 찾기',
                  onPressed: () {},
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  textColor: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('포인트 사용'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DummyCoupon {
  final String title;
  final String description;
  final DateTime validUntil;

  _DummyCoupon({
    required this.title,
    required this.description,
    required this.validUntil,
  });
}

class _DummyCafe {
  final String name;
  final String address;
  final double distance;
  final String imageUrl;

  _DummyCafe({
    required this.name,
    required this.address,
    required this.distance,
    required this.imageUrl,
  });
}

final List<_DummyCoupon> _dummyCoupons = [
  _DummyCoupon(
    title: '아메리카노 1잔 무료',
    description: '1만원 이상 결제 시 적용',
    validUntil: DateTime.now().add(const Duration(days: 7)),
  ),
  _DummyCoupon(
    title: '디저트 20% 할인',
    description: '모든 케이크류 할인',
    validUntil: DateTime.now().add(const Duration(days: 14)),
  ),
];

final List<_DummyCafe> _dummyCafes = [
  _DummyCafe(
    name: '카페 브라운',
    address: '서울시 강남구 테헤란로 100',
    distance: 0.4,
    imageUrl:
        'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400',
  ),
  _DummyCafe(
    name: '그린 빈즈',
    address: '서울시 강남구 삼성동 50',
    distance: 0.9,
    imageUrl:
        'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
  ),
  _DummyCafe(
    name: '라떼하우스',
    address: '서울시 강남구 역삼동 200',
    distance: 1.4,
    imageUrl:
        'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=400',
  ),
];

