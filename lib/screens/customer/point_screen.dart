import 'package:flutter/material.dart';

class PointScreen extends StatefulWidget {
  const PointScreen({super.key});

  @override
  State<PointScreen> createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('통합 포인트'),
      ),
      body: const Center(
        child: Text('포인트 관리 화면'),
      ),
    );
  }
}
