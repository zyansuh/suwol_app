import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카페 상세'),
      ),
      body: Center(
        child: Text('카페 상세 화면: ${widget.cafeId}'),
      ),
    );
  }
}
