import 'package:flutter/material.dart';
import 'package:suwol/utils/validators.dart';
import 'package:suwol/models/user/user_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _nameController = TextEditingController();
  final _businessNumberController = TextEditingController();
  final _phoneController = TextEditingController();

  UserType _selectedType = UserType.customer;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _nameController.dispose();
    _businessNumberController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _selectType(UserType type) {
    if (_selectedType == type) return;
    setState(() {
      _selectedType = type;
      _businessNumberController.clear();
      _nameController.clear();
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_passwordController.text != _passwordConfirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('비밀번호가 일치하지 않습니다')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    await Future<void>.delayed(const Duration(milliseconds: 400));
    setState(() => _isSubmitting = false);

    final typeLabel =
        _selectedType == UserType.owner ? '사업자 회원가입' : '고객 회원가입';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$typeLabel 요청이 전송되었습니다 (데모 동작)')),
    );
  }

  void _verifyBusiness() {
    if (_businessNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사업자 등록번호를 입력해주세요')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('사업자 인증 요청을 전송했습니다 (데모 동작)'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isOwner = _selectedType == UserType.owner;

    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '역할을 선택해주세요',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _RoleTile(
                        title: '고객',
                        subtitle: '포인트 적립 / 쿠폰 사용',
                        icon: Icons.person,
                        selected: !isOwner,
                        onTap: () => _selectType(UserType.customer),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _RoleTile(
                        title: '사업자',
                        subtitle: '카페 관리 / 쿠폰 발행',
                        icon: Icons.storefront,
                        selected: isOwner,
                        onTap: () => _selectType(UserType.owner),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 기본 정보
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: '이메일',
                    hintText: 'example@email.com',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                  ),
                  obscureText: true,
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordConfirmController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호 확인',
                  ),
                  obscureText: true,
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: isOwner ? '가게 상호명' : '이름',
                    hintText: isOwner ? '예) 카페링크 수월점' : '이름을 입력하세요',
                  ),
                  validator: (v) =>
                      Validators.validateRequired(v, isOwner ? '상호명' : '이름'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: '연락처',
                    hintText: '010-0000-0000',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: Validators.validatePhoneNumber,
                ),

                if (isOwner) ...[
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 12),
                  const Text(
                    '사업자 인증',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _businessNumberController,
                    decoration: const InputDecoration(
                      labelText: '사업자 등록번호',
                      hintText: '예) 123-45-67890',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        Validators.validateRequired(v, '사업자 등록번호'),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _verifyBusiness,
                      icon: const Icon(Icons.verified_outlined),
                      label: const Text('사업자 인증하기'),
                    ),
                  ),
                ],

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text('회원가입'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _RoleTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.08)
              : Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).dividerColor,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}

