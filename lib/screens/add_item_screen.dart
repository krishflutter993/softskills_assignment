import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _websiteNameController = TextEditingController();
  final TextEditingController _websiteUrlController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String _selectedCategory = 'Social Media';
  bool _obscurePassword = true;
  bool _isSaving = false;
  bool _isSaved = false;
  
  final List<String> _categories = [
    'Social Media',
    'Email',
    'Development',
    'Banking',
    'Entertainment',
    'Work',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
        ),
        title: Text(
          'Add Item',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _saveItem,
            child: Text(
              'Save',
              style: GoogleFonts.inter(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Securely add a new credential to your encrypted vault.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            CustomTextField(
              label: 'Website Name',
              hint: 'e.g. GitHub',
              controller: _websiteNameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Website URL',
              hint: 'https://github.com',
              controller: _websiteUrlController,
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Username or Email',
              hint: 'your@email.com',
              controller: _usernameController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Password',
              hint: 'Enter password',
              controller: _passwordController,
              obscureText: _obscurePassword,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textMuted,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              dropdownColor: AppColors.surface,
              style: GoogleFonts.inter(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                labelText: 'Category',
                labelStyle: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(
                    category,
                    style: GoogleFonts.inter(
                      color: AppColors.textPrimary,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Notes',
              hint: 'Add optional notes',
              controller: _notesController,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    _isSaved ? Icons.check_circle : Icons.save,
                    color: _isSaved ? AppColors.success : AppColors.textMuted,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _isSaved ? 'SAVED' : 'AUTO-SAVING ACTIVE',
                    style: GoogleFonts.inter(
                      color: _isSaved ? AppColors.success : AppColors.textMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Save Item',
              isLoading: _isSaving,
              onPressed: _saveItem,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveItem() async {
    setState(() {
      _isSaving = true;
    });
    
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _isSaving = false;
      _isSaved = true;
    });
    
    Navigator.pop(context, true);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Credential saved successfully!'),
        backgroundColor: AppColors.success,
      ),
    );
  }
}