import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:typed_data';

class HealthyRecipesScreen extends StatefulWidget {
  const HealthyRecipesScreen({super.key});

  @override
  _HealthyRecipesScreenState createState() => _HealthyRecipesScreenState();
}

class _HealthyRecipesScreenState extends State<HealthyRecipesScreen> {
  final List<Recipe> recipes = [
    Recipe(
      title: 'Salad Buah',
      steps: [
        'Potong buah-buahan.',
        'Campur semua buah dalam mangkuk.',
        'Tambahkan yogurt.',
      ],
      imageUrl: 'assets/resep/saladbuah.jpg',
    ),
    Recipe(
      title: 'Smoothie Hijau',
      steps: [
        'Campurkan bayam, pisang, dan susu almond dalam blender.',
        'Blender sampai halus.',
        'Tuang ke dalam gelas dan sajikan.',
      ],
      imageUrl: 'assets/resep/smoothiehijau.jpg',
    ),
    Recipe(
      title: 'Oatmeal Buah',
      steps: [
        'Masak oatmeal sesuai petunjuk pada kemasan.',
        'Tambahkan potongan buah dan madu.',
        'Aduk rata dan sajikan.',
      ],
      imageUrl: 'assets/resep/oatmealbuah.jpg',
    ),
    Recipe(
      title: 'Chia Pudding',
      steps: [
        'Campurkan chia seeds dengan susu almond.',
        'Tambahkan madu dan vanilla.',
        'Biarkan dalam kulkas selama 4 jam atau semalaman.',
      ],
      imageUrl: 'assets/resep/chiapudding.jpg',
    ),
    Recipe(
      title: 'Quinoa Salad',
      steps: [
        'Masak quinoa sesuai petunjuk pada kemasan.',
        'Campur dengan sayuran segar dan dressing lemon.',
        'Sajikan dingin.',
      ],
      imageUrl: 'assets/resep/quinoasalad.jpg',
    ),
    Recipe(
      title: 'Sup Sayur',
      steps: [
        'Rebus berbagai jenis sayuran dengan kaldu.',
        'Tambahkan bumbu sesuai selera.',
        'Sajikan hangat.',
      ],
      imageUrl: 'assets/resep/supsayur.jpg',
    ),
    Recipe(
      title: 'Roti Gandum',
      steps: [
        'Campur tepung gandum dengan ragi dan air.',
        'Uleni adonan dan biarkan mengembang.',
        'Panggang dalam oven hingga matang.',
      ],
      imageUrl: 'assets/resep/rotigandum.jpg',
    ),
    Recipe(
      title: 'Yogurt Granola',
      steps: [
        'Campurkan yogurt dengan granola.',
        'Tambahkan buah segar.',
        'Sajikan segera.',
      ],
      imageUrl: 'assets/resep/yogurtgranola.jpg',
    ),
    Recipe(
      title: 'Sereal Buah',
      steps: [
        'Tuang sereal dalam mangkuk.',
        'Tambahkan susu dan potongan buah.',
        'Aduk rata dan nikmati.',
      ],
      imageUrl: 'assets/resep/serealbuah.jpg',
    ),
    Recipe(
      title: 'Smoothie Berry',
      steps: [
        'Campurkan berry, pisang, dan yogurt dalam blender.',
        'Blender hingga halus.',
        'Tuang ke dalam gelas dan sajikan.',
      ],
      imageUrl: 'assets/resep/smoothieberry.jpg',
    ),
  ];

  void _addRecipe(Recipe recipe) {
    setState(() {
      recipes.add(recipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.teal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: const Text('Resep Sehat'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddRecipeScreen(onAddRecipe: _addRecipe),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 238, 226),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.teal, Colors.green],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: recipes[index].imageBytes != null
                    ? Image.memory(
                        recipes[index].imageBytes!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : recipes[index].imageUrl.isNotEmpty
                        ? Image.asset(
                            recipes[index].imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey,
                            child: const Icon(Icons.image, color: Colors.white),
                          ),
                title: Text(recipes[index].title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RecipeDetailScreen(recipe: recipes[index]),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddRecipeScreen extends StatefulWidget {
  final Function(Recipe) onAddRecipe;

  const AddRecipeScreen({super.key, required this.onAddRecipe});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _stepsController = TextEditingController();
  Uint8List? _imageBytes;
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Resep Sendiri'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Judul Resep'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stepsController,
                decoration: const InputDecoration(
                    labelText: 'Langkah-langkah (pisahkan dengan koma)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Langkah-langkah tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final title = _titleController.text;
                    final steps = _stepsController.text
                        .split(',')
                        .map((s) => s.trim())
                        .toList();

                    final newRecipe = Recipe(
                      title: title,
                      steps: steps,
                      imageUrl: _imageUrl ?? '',
                      imageBytes: _imageBytes,
                    );
                    widget.onAddRecipe(newRecipe);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Tambah Resep'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          recipe.imageBytes != null
              ? Image.memory(
                  recipe.imageBytes!,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                )
              : recipe.imageUrl.isNotEmpty
                  ? kIsWeb
                      ? Image.network(
                          recipe.imageUrl,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          recipe.imageUrl,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        )
                  : Container(
                      width: double.infinity,
                      height: 250,
                      color: Colors.grey,
                      child: const Icon(Icons.image,
                          color: Colors.white, size: 100),
                    ),
          Expanded(
            child: ListView.builder(
              itemCount: recipe.steps.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(recipe.steps[index]),
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
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

class Recipe {
  final String title;
  final List<String> steps;
  final String imageUrl;
  final Uint8List? imageBytes;

  Recipe({
    required this.title,
    required this.steps,
    required this.imageUrl,
    this.imageBytes,
  });
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthy Recipes',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HealthyRecipesScreen(),
    );
  }
}
