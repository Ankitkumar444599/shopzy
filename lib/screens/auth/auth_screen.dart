import 'package:ai_real_estate/services/auth_service.dart';
import 'package:ai_real_estate/widgets/app_shell.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget { const AuthScreen({super.key}); @override State<AuthScreen> createState() => _AuthScreenState(); }
class _AuthScreenState extends State<AuthScreen> { final email = TextEditingController(); final password = TextEditingController(); final auth = AuthService(); @override Widget build(BuildContext context) => AppShell(title: 'Account', child: ListView(padding: const EdgeInsets.all(20), children: [TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')), const SizedBox(height: 12), TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')), const SizedBox(height: 16), FilledButton(onPressed: () => auth.signIn(email.text, password.text), child: const Text('Login')), OutlinedButton(onPressed: () => auth.register(email.text, password.text), child: const Text('Register')), TextButton(onPressed: () => auth.resetPassword(email.text), child: const Text('Forgot password')), FilledButton.tonalIcon(onPressed: auth.signInWithGoogle, icon: const Icon(Icons.login), label: const Text('Continue with Google'))])); }
}
