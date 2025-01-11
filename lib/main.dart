import 'package:flutter/material.dart';
import 'TambahPakaian.dart';
import 'EditPakaian.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Penjualan Pakaian',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> pakaian = [
    {'nama': 'Celana Cargo', 'harga': 50000, 'stok': 50},
    {'nama': 'Kemeja Casual', 'harga': 150000, 'stok': 50},
    {'nama': 'Jaket Hoodie', 'harga': 200000, 'stok': 50},
  ];

  void tambahPakaian(String nama, int harga, int stok) {
    setState(() {
      pakaian.add({'nama': nama, 'harga': harga, 'stok': stok});
    });
  }

  void editPakaian(int index, String nama, int harga, int stok) {
    setState(() {
      pakaian[index] = {'nama': nama, 'harga': harga, 'stok': stok};
    });
  }

  void hapusPakaian(int index) {
    setState(() {
      pakaian.removeAt(index);
    });
  }

  Future<void> konfirmasiHapus(BuildContext context, int index) async {
    final hasil = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus pakaian ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Hapus'),
          ),
        ],
      ),
    );

    if (hasil == true) {
      hapusPakaian(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Pakaian'),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        itemCount: pakaian.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pakaian[index]['nama'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Harga: Rp ${pakaian[index]['harga']}',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Stok: ${pakaian[index]['stok']}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.deepOrange),
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditPakaian(
                                    index: index,
                                    nama: pakaian[index]['nama'],
                                    harga: pakaian[index]['harga'],
                                    stok: pakaian[index]['stok'],
                                  ),
                                ),
                              );
                              if (result != null) {
                                editPakaian(index, result['nama'],
                                    result['harga'], result['stok']);
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => konfirmasiHapus(context, index),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahPakaian(),
            ),
          );
          if (result != null) {
            tambahPakaian(result['nama'], result['harga'], result['stok']);
          }
        },
      ),
    );
  }
}
