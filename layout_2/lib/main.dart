import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FabBottomBar(),
    );
  }
}

class FabBottomBar extends StatefulWidget {
  const FabBottomBar({super.key});

  @override
  _FabBottomBarState createState() => _FabBottomBarState();
}

class _FabBottomBarState extends State<FabBottomBar> {
  int _selectedIndex = 0;
  bool _showFabOptions = false;
  final _fabIcon = ValueNotifier(Icons.add);

  final _pages = [
    const Center(child: Text('Página Inicial', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Perfil', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleFabOptions() {
    setState(() {
      _showFabOptions = !_showFabOptions;
      _fabIcon.value = _showFabOptions ? Icons.close : Icons.add;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex],
          if (_showFabOptions)
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton.small(
                        heroTag: null,
                        onPressed: () {
                          _toggleFabOptions();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Opção 1 selecionada')),
                          );
                        },
                        child: const Icon(Icons.photo_camera),
                      ),
                      const SizedBox(height: 20),
                      FloatingActionButton.small(
                        heroTag: null,
                        onPressed: () {
                          _toggleFabOptions();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Opção 2 selecionada')),
                          );
                        },
                        child: const Icon(Icons.photo_library),
                      ),
                      const SizedBox(height: 20),
                      FloatingActionButton.small(
                        heroTag: null,
                        onPressed: () {
                          _toggleFabOptions();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Opção 3 selecionada')),
                          );
                        },
                        child: const Icon(Icons.settings),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: ValueListenableBuilder<IconData>(
        valueListenable: _fabIcon,
        builder: (context, icon, _) {
          return FloatingActionButton(
            onPressed: _toggleFabOptions,
            child: Icon(icon),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: const Icon(Icons.person),
              color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
              onPressed: () => _onItemTapped(1),
            ),
          ],
        ),
      ),
    );
  }
}