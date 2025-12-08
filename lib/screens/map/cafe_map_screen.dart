import 'package:flutter/material.dart';

class CafeMapScreen extends StatefulWidget {
  const CafeMapScreen({super.key});

  @override
  State<CafeMapScreen> createState() => _CafeMapScreenState();
}

class _CafeMapScreenState extends State<CafeMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카페 지도'),
      ),
      body: const Center(
        child: Text('카페 지도 화면'),
      ),
    );
  }
}

