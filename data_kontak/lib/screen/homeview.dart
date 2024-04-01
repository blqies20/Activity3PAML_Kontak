import 'package:data_kontak/controller/kontak_controller.dart';
import 'package:data_kontak/model/kontak.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final KontakController _controller = KontakController();

  @override
  void initState() {
    super.initState();
    _controller.getPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Orang"),
      ),
      body: FutureBuilder<List<Kontak>>(
          future: _controller.getPeople(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    Kontak kontak = snapshot.data![index];
                    return ListTile(
                      title: Text(kontak.nama),
                      subtitle: Text(kontak.email),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(kontak.foto),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
