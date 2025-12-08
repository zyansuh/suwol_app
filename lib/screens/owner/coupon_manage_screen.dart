import 'package:flutter/material.dart';

class CouponManageScreen extends StatefulWidget {
  const CouponManageScreen({super.key});

  @override
  State<CouponManageScreen> createState() => _CouponManageScreenState();
}

class _CouponManageScreenState extends State<CouponManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('쿠폰 관리'),
      ),
      body: const Center(
        child: Text('쿠폰 관리 화면'),
      ),
    );
  }
}

