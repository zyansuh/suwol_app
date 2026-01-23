import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth/auth_provider.dart';
import '../../models/user/user_model.dart';
import '../../utils/validators.dart';
import '../../widgets/common/app_button.dart';
import '../../theme/app_theme.dart';

class OwnerRegisterScreen extends StatefulWidget {
  const OwnerRegisterScreen({super.key});

  @override
  State<OwnerRegisterScreen> createState() => _OwnerRegisterScreenState();
}

class _OwnerRegisterScreenState extends State<OwnerRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _businessNumberController = TextEditingController();
  bool _isSubmitting = false;
  bool _isBusinessVerified = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _businessNameController.dispose();
    _phoneController.dispose();
    _businessNumberController.dispose();
    super.dispose();
  }

  Future<void> _verifyBusiness() async {
    if (_businessNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사업자 등록번호를 입력해주세요')),
      );
      return;
    }

    // TODO: API 연동 - 사업자 인증
    // 예시 코드:
    // final result = await businessService.verifyBusinessNumber(
    //   businessNumber: _businessNumberController.text,
    // );
    // if (result.isValid) {
    //   setState(() => _isBusinessVerified = true);
    //   // 사업자 정보 자동 입력 (상호명 등)
    //   _businessNameController.text = result.businessName;
    // }
    
    setState(() => _isBusinessVerified = true);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사업자 인증이 완료되었습니다 (데모)')),
      );
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (!_isBusinessVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사업자 인증을 완료해주세요')),
      );
      return;
    }

    if (_passwordController.text != _passwordConfirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('비밀번호가 일치하지 않습니다')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final provider = Provider.of<AuthProvider>(context, listen: false);
    
    // TODO: API 연동 - 사업자 회원가입
    final success = await provider.signUp(
      email: _emailController.text,
      password: _passwordController.text,
      name: _businessNameController.text,
      phoneNumber: _phoneController.text,
      userType: UserType.owner,
      businessNumber: _businessNumberController.text,
    );

    setState(() => _isSubmitting = false);

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('사업자 회원가입이 완료되었습니다')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('회원가입에 실패했습니다')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사업자 회원가입'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.storefront,
                  size: 60,
                  color: AppTheme.brandPrimary,
                ),
                const SizedBox(height: 16),
                const Text(
                  '사업자 가입',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  '기본 정보',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: '이메일',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordConfirmController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호 확인',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  obscureText: true,
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _businessNameController,
                  decoration: const InputDecoration(
                    labelText: '가게 상호명',
                    prefixIcon: Icon(Icons.store),
                    hintText: '예) 카페링크 강남점',
                  ),
                  validator: (value) => Validators.validateRequired(value, '상호명'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: '연락처',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: Validators.validatePhoneNumber,
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                const Text(
                  '사업자 인증',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.brandPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _businessNumberController,
                  decoration: InputDecoration(
                    labelText: '사업자 등록번호',
                    prefixIcon: const Icon(Icons.business),
                    hintText: '예) 123-45-67890',
                    suffixIcon: _isBusinessVerified
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      Validators.validateRequired(value, '사업자 등록번호'),
                  enabled: !_isBusinessVerified,
                ),
                const SizedBox(height: 12),
                if (!_isBusinessVerified)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.verified_outlined),
                      label: const Text('사업자 인증하기'),
                      onPressed: _verifyBusiness,
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 8),
                        Text('사업자 인증이 완료되었습니다'),
                      ],
                    ),
                  ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    text: '회원가입',
                    onPressed: _submit,
                    isLoading: _isSubmitting,
                    backgroundColor: AppTheme.brandPrimary,
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
