import 'package:flutter/material.dart';

class EditPakaian extends StatelessWidget {
  final int index;
  final String nama;
  final int harga;
  final int stok;

  EditPakaian({
    required this.index,
    required this.nama,
    required this.harga,
    required this.stok,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController namaController =
        TextEditingController(text: nama);
    final TextEditingController hargaController =
        TextEditingController(text: harga.toString());
    final TextEditingController stokController =
        TextEditingController(text: stok.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pakaian'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Pakaian',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: hargaController,
                decoration: InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 16.0,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: stokController,
                decoration: InputDecoration(
                  labelText: 'Stok',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 16.0,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final updatedNama = namaController.text;
                        final updatedHarga =
                            int.tryParse(hargaController.text) ?? 0;
                        final updatedStok =
                            int.tryParse(stokController.text) ?? 0;

                        Navigator.pop(
                          context,
                          {
                            'nama': updatedNama,
                            'harga': updatedHarga,
                            'stok': updatedStok,
                          },
                        );
                      },
                      child: Text('Simpan'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
