import 'package:flutter/material.dart';

class TibiaUI extends StatelessWidget {
  const TibiaUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      color: const Color(0xFF303030),
      child: Column(
        children: [
          // 1. MINIMAPA
          Container(
            height: 100,
            width: double.infinity,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.grey[800]!, width: 2),
            ),
            child: const Center(child: Icon(Icons.map, color: Colors.white24)),
          ),

          // 2. BARRAS DE STATUS
          _buildStatusBar(label: 'HP', color: Colors.green[700]!, value: '150'),
          _buildStatusBar(label: 'Mana', color: Colors.blue[700]!, value: '55'),

          const SizedBox(height: 10),

          // 3. SLOTS DE EQUIPAMENTO (Set Inicial)
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSlot(), // Exemplo
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [_buildSlot(), _buildSlot(), _buildSlot()],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSlot(), // Anel (Vazio)
                    _buildSlot(),
                    _buildSlot(), // Ammo (Vazio)
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 4. ÁREA DE INVENTÁRIO (MOCHILA)
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: const Color(0xFF222222),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemCount: 20, // 20 slots de mochila
                itemBuilder: (context, index) => _buildSlot(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBar({
    required String label,
    required Color color,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Column(
        children: [
          Container(
            height: 14,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              border: Border.all(color: Colors.black),
            ),
            child: Stack(
              children: [
                // Parte colorida da barra
                FractionallySizedBox(
                  widthFactor: 0.8, // Ex: 80% de vida
                  child: Container(color: color),
                ),
                Center(
                  child: Text(
                    "$label: $value",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlot({String? image}) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFF454545),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: image != null
          ? Image.asset('assets/images/items/$image', fit: BoxFit.contain)
          : null,
    );
  }
}
