import 'package:flutter/material.dart';

class CafeManageScreen extends StatefulWidget {
  const CafeManageScreen({super.key});

  @override
  State<CafeManageScreen> createState() => _CafeManageScreenState();
}

class _CafeManageScreenState extends State<CafeManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카페 관리'),
      ),
      body: const Center(
        child: Text('카페 관리 화면'),
      ),
    );
  }
}

