import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cafe/cafe_provider.dart';
import '../../widgets/cafe/cafe_card.dart';
import '../../routes/app_router.dart';

class CafeListScreen extends StatefulWidget {
  const CafeListScreen({super.key});

  @override
  State<CafeListScreen> createState() => _CafeListScreenState();
}

class _CafeListScreenState extends State<CafeListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  double? _maxDistance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<CafeProvider>(context, listen: false);
      // TODO: 실제 위치 정보 사용
      provider.loadCafes();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applySearch() {
    setState(() {
      _searchQuery = _searchController.text;
    });
    final provider = Provider.of<CafeProvider>(context, listen: false);
    provider.searchCafes(_searchQuery);
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('필터'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('최대 거리 (km)'),
              Slider(
                value: _maxDistance ?? 5.0,
                min: 1.0,
                max: 20.0,
                divisions: 19,
                label: '${(_maxDistance ?? 5.0).toStringAsFixed(1)}km',
                onChanged: (value) {
                  setDialogState(() {
                    _maxDistance = value;
                  });
                },
              ),
              Text('${(_maxDistance ?? 5.0).toStringAsFixed(1)}km'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setDialogState(() {
                  _maxDistance = null;
                });
              },
              child: const Text('초기화'),
            ),
            TextButton(
              onPressed: () {
                final provider =
                    Provider.of<CafeProvider>(context, listen: false);
                provider.filterByDistance(_maxDistance);
                Navigator.pop(context);
              },
              child: const Text('적용'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카페 목록'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // 검색바
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '카페 이름으로 검색...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _applySearch();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (_) => _applySearch(),
            ),
          ),
          // 카페 목록
          Expanded(
            child: Consumer<CafeProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading && provider.filteredCafes.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                final cafes = provider.filteredCafes;

                if (cafes.isEmpty) {
                  return const Center(
                    child: Text('검색 결과가 없습니다'),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await provider.loadCafes();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: cafes.length,
                    itemBuilder: (context, index) {
                      final cafe = cafes[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: CafeCard(
                          name: cafe.name,
                          address: cafe.address,
                          imageUrl: cafe.imageUrl,
                          distance: null, // TODO: 실제 거리 계산
                          onTap: () {
                            AppRouter.router.push('/cafes/${cafe.id}');
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
