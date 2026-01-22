import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cafe/cafe_provider.dart';
import '../../services/image/image_service.dart';
import '../../utils/validators.dart';
import '../../widgets/common/app_button.dart';

class CafeManageScreen extends StatefulWidget {
  const CafeManageScreen({super.key});

  @override
  State<CafeManageScreen> createState() => _CafeManageScreenState();
}

class _CafeManageScreenState extends State<CafeManageScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageService = ImageService();
  File? _cafeImage;
  List<File> _cafeImages = [];

  @override
  void initState() {
    super.initState();
    _loadCafeData();
  }

  void _loadCafeData() {
    _nameController.text = '내 카페';
    _addressController.text = '서울시 강남구 테헤란로 123';
    _phoneController.text = '02-1234-5678';
    _descriptionController.text = '맛있는 커피와 따뜻한 분위기의 카페입니다.';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickMainImage() async {
    final image = await _imageService.pickImage();
    if (image != null) {
      setState(() {
        _cafeImage = image;
      });
    }
  }

  Future<void> _pickMultipleImages() async {
    final images = await _imageService.pickMultipleImages();
    setState(() {
      _cafeImages.addAll(images);
    });
  }

  Future<void> _saveCafe() async {
    if (!_formKey.currentState!.validate()) return;

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('카페 정보가 저장되었습니다')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('카페 정보 수정')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('대표 이미지', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _pickMainImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    image: _cafeImage != null ? DecorationImage(image: FileImage(_cafeImage!), fit: BoxFit.cover) : null,
                  ),
                  child: _cafeImage == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_photo_alternate, size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 8),
                            Text('대표 이미지 추가', style: TextStyle(color: Colors.grey[600])),
                          ],
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('추가 이미지', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextButton.icon(icon: const Icon(Icons.add), label: const Text('추가'), onPressed: _pickMultipleImages),
                ],
              ),
              const SizedBox(height: 12),
              if (_cafeImages.isNotEmpty)
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _cafeImages.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            width: 100,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(image: FileImage(_cafeImages[index]), fit: BoxFit.cover),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 12,
                            child: GestureDetector(
                              onTap: () => setState(() => _cafeImages.removeAt(index)),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                child: const Icon(Icons.close, size: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: '카페명', prefixIcon: Icon(Icons.store)),
                validator: (value) => Validators.validateRequired(value, '카페명'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: '주소', prefixIcon: Icon(Icons.location_on)),
                validator: (value) => Validators.validateRequired(value, '주소'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: '전화번호', prefixIcon: Icon(Icons.phone)),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: '카페 소개', prefixIcon: Icon(Icons.description)),
                maxLines: 4,
              ),
              const SizedBox(height: 32),
              SizedBox(width: double.infinity, child: AppButton(text: '저장', onPressed: _saveCafe)),
            ],
          ),
        ),
      ),
    );
  }
}
