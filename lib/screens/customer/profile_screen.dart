import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user/user_provider.dart';
import '../../services/image/image_service.dart';
import '../../utils/validators.dart';
import '../../widgets/common/app_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _imageService = ImageService();
  File? _profileImage;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // TODO: 실제 사용자 데이터 로드
    _nameController.text = '홍길동';
    _emailController.text = 'user@example.com';
    _phoneController.text = '010-1234-5678';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    final image = await _imageService.pickImage();
    if (image != null) {
      setState(() {
        _profileImage = image;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = Provider.of<UserProvider>(context, listen: false);
    
    // TODO: 실제 사용자 ID로 변경
    await provider.updateUser({
      'name': _nameController.text,
      'phoneNumber': _phoneController.text,
      // 이미지는 별도 업로드 필요
    });

    setState(() {
      _isEditing = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('프로필이 저장되었습니다')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
            )
          else
            TextButton(
              onPressed: () {
                setState(() {
                  _isEditing = false;
                });
              },
              child: const Text('취소'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // 프로필 이미지
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? const Icon(Icons.person, size: 60)
                        : null,
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, size: 20),
                          color: Colors.white,
                          onPressed: _pickProfileImage,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              // 이름
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '이름',
                  prefixIcon: Icon(Icons.person),
                ),
                enabled: _isEditing,
                validator: (value) =>
                    Validators.validateRequired(value, '이름'),
              ),
              const SizedBox(height: 16),
              // 이메일
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: '이메일',
                  prefixIcon: Icon(Icons.email),
                ),
                enabled: false, // 이메일은 변경 불가
                validator: (value) => Validators.validateEmail(value),
              ),
              const SizedBox(height: 16),
              // 전화번호
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: '전화번호',
                  prefixIcon: Icon(Icons.phone),
                ),
                enabled: _isEditing,
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    Validators.validatePhoneNumber(value),
              ),
              const SizedBox(height: 32),
              if (_isEditing)
                AppButton(
                  text: '저장',
                  onPressed: _saveProfile,
                ),
              const SizedBox(height: 24),
              // 설정 메뉴
              const Divider(),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('알림 설정'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('비밀번호 변경'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('로그아웃'),
                onTap: () {
                  // TODO: 로그아웃 로직
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
