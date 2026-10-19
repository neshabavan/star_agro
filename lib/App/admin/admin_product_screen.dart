import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'admin_product_controller.dart';
import '../../utility/product_model.dart';

class AdminProductScreen extends StatefulWidget {
  const AdminProductScreen({super.key});

  @override
  State<AdminProductScreen> createState() => _AdminProductScreenState();
}

class _AdminProductScreenState extends State<AdminProductScreen> {
  // Products manage karne ke liye controller.
  late final AdminProductController controller;

  @override
  void initState() {
    super.initState();

    controller = AdminProductController();
    controller.addListener(updateScreen);
    controller.loadProducts();
  }

  // Controller change hone par screen refresh hogi.
  void updateScreen() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.removeListener(updateScreen);
    controller.dispose();
    super.dispose();
  }

  // Add aur Edit product form.
  void showProductForm({ProductModel? product}) {
    final nameController = TextEditingController(text: product?.name ?? '');

    final descriptionController = TextEditingController(
      text: product?.description ?? '',
    );

    // Purani image ka path edit karte waqt rahega.
    final imageController = TextEditingController(
      text: product?.imagePath ?? '',
    );

    String selectedCategory = product?.category ?? 'Seeds';

    // Nayi select ki hui image.
    Uint8List? selectedImageBytes;
    String selectedImageName = '';

    bool isSaving = false;

    final List<String> categories = [
      'Seeds',
      'Fertilizers',
      'Crop Care',
      'Farm Tools',
    ];

    // Laptop ya mobile se image select karna.
    Future<void> pickProductImage(
      void Function(void Function()) setDialogState,
    ) async {
      try {
        final result = await FilePicker.pickFiles(
          type: FileType.image,
          withData: true,
        );

        if (result != null && result.files.single.bytes != null) {
          setDialogState(() {
            selectedImageBytes = result.files.single.bytes!;
            selectedImageName = result.files.single.name;
          });
        }
      } catch (error, stackTrace) {
        debugPrint('Image selection error: $error');
        debugPrintStack(stackTrace: stackTrace);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image error: $error'),
            duration: const Duration(seconds: 8),
          ),
        );
      }
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(product == null ? 'Add Product' : 'Edit Product'),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: 400,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Product name.
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Product Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Product category.
                      DropdownButtonFormField<String>(
                        value: selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                        ),
                        items: categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              selectedCategory = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Product description.
                      TextField(
                        controller: descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Image selection heading.
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Product Image',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Image select karne ka button.
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: isSaving
                              ? null
                              : () => pickProductImage(setDialogState),
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Choose Image'),
                        ),
                      ),
                      const SizedBox(height: 8),

                     

                      // Nayi image ka naam.
                      if (selectedImageName.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          selectedImageName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],

                      // Nayi image ka preview.
                      if (selectedImageBytes != null) ...[
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            selectedImageBytes!,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ] else if (product != null &&
                          product.imagePath.isNotEmpty) ...[
                        // Edit karte waqt existing image dikhana.
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 160,
                          width: double.infinity,
                          child: productImage(product.imagePath, height: 160),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Current image',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              actions: [
                // Cancel button.
                TextButton(
                  onPressed: isSaving
                      ? null
                      : () {
                          Navigator.pop(dialogContext);
                        },
                  child: const Text('Cancel'),
                ),

                // Save button.
                ElevatedButton(
                  onPressed: isSaving
                      ? null
                      : () async {
                          final name = nameController.text.trim();

                          final description = descriptionController.text.trim();

                          // Agar nayi image select nahi hui,
                          // to existing image ka path use hoga.
                          String imagePath = imageController.text.trim();

                          if (name.isEmpty ||
                              description.isEmpty ||
                              (imagePath.isEmpty &&
                                  selectedImageBytes == null)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please fill all details and select an image.',
                                ),
                              ),
                            );
                            return;
                          }

                          // Nayi image ko Base64 mein convert karna.
                          if (selectedImageBytes != null) {
                            final fileName = selectedImageName.toLowerCase();

                            String imageType = 'jpeg';

                            if (fileName.endsWith('.png')) {
                              imageType = 'png';
                            } else if (fileName.endsWith('.webp')) {
                              imageType = 'webp';
                            } else if (fileName.endsWith('.gif')) {
                              imageType = 'gif';
                            } else if (fileName.endsWith('.jpg') ||
                                fileName.endsWith('.jpeg')) {
                              imageType = 'jpeg';
                            }

                            imagePath =
                                'data:image/$imageType;base64,'
                                '${base64Encode(selectedImageBytes!)}';
                          }

                          setDialogState(() {
                            isSaving = true;
                          });

                          try {
                            if (product == null) {
                              await controller.addProduct(
                                name: name,
                                category: selectedCategory,
                                description: description,
                                imagePath: imagePath,
                              );
                            } else {
                              await controller.updateProduct(
                                id: product.id,
                                name: name,
                                category: selectedCategory,
                                description: description,
                                imagePath: imagePath,
                              );
                            }

                            if (!mounted) return;

                            Navigator.pop(dialogContext);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  product == null
                                      ? 'Product added successfully!'
                                      : 'Product updated successfully!',
                                ),
                              ),
                            );
                          } catch (error) {
                            debugPrint('Product save error: $error');

                            setDialogState(() {
                              isSaving = false;
                            });

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Unable to save product.'),
                              ),
                            );
                          }
                        },
                  child: isSaving
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      // Form close hone par controllers dispose karna.
      nameController.dispose();
      descriptionController.dispose();
      imageController.dispose();
    });
  }

  // Product image dikhana.
  Widget productImage(String imagePath, {double height = 160}) {
    if (imagePath.startsWith('data:image/')) {
      try {
        final base64Data = imagePath.split(',').last;

        return Image.memory(
          base64Decode(base64Data),
          height: height,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return imagePlaceholder(height: height);
          },
        );
      } catch (error) {
        return imagePlaceholder(height: height);
      }
    }

    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return imagePlaceholder(height: height);
        },
      );
    }

    if (imagePath.isNotEmpty) {
      return Image.asset(
        imagePath,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return imagePlaceholder(height: height);
        },
      );
    }

    return imagePlaceholder(height: height);
  }

  // Image na mile to placeholder.
  Widget imagePlaceholder({double height = 160}) {
    return Container(
      height: height,
      width: double.infinity,
      color: const Color(0xFFE8F5E9),
      child: const Icon(Icons.agriculture, size: 50, color: Color(0xFF2E7D32)),
    );
  }

  // Product delete karne se pehle confirmation.
  void confirmDelete(ProductModel product) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: Text('Do you want to delete ${product.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                try {
                  await controller.deleteProduct(product.id);

                  if (!mounted) return;

                  Navigator.pop(dialogContext);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Product deleted successfully!'),
                    ),
                  );
                } catch (error) {
                  debugPrint('Product delete error: $error');

                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Unable to delete product.')),
                  );
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F2),

      // Admin page header.
      appBar: AppBar(
        title: const Text('Manage Products'),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
      ),

      // Loading ya product list.
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: controller.loadProducts,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Add product button.
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () => showProductForm(),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Product'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Product count.
                  Text(
                    'Total Products: ${controller.products.length}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // No products message.
                  if (controller.products.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(child: Text('No products added yet.')),
                    ),

                  // Product cards.
                  ...controller.products.map((product) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 14),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product image.
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: productImage(product.imagePath),
                            ),
                            const SizedBox(height: 12),

                            // Product name.
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),

                            // Product category.
                            Text('Category: ${product.category}'),
                            const SizedBox(height: 5),

                            // Product description.
                            Text(product.description),
                            const SizedBox(height: 12),

                            // Edit and Delete buttons.
                            Wrap(
                              spacing: 8,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {
                                    showProductForm(product: product);
                                  },
                                  icon: const Icon(Icons.edit),
                                  label: const Text('Edit'),
                                ),
                                OutlinedButton.icon(
                                  onPressed: () {
                                    confirmDelete(product);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  label: const Text('Delete'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
    );
  }
}
