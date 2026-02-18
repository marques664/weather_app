import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CityHistoryWidget extends StatelessWidget {
  const CityHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('city_history')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Nenhuma cidade pesquisada ainda.'));
        }

        final docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final city = data['city'] ?? 'Cidade desconhecida';
            final time = (data['timestamp'] as Timestamp).toDate();

            return ListTile(
              title: Text(city),
              subtitle: Text(time.toString()),
              leading: const Icon(Icons.location_city),
            );
          },
        );
      },
    );
  }
}
