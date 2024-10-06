import 'package:flutter/material.dart';



class ProfilePage extends StatelessWidget {
  // Данные профиля
  final String fullName = 'Кудрявцев Никита Дмитриевич';
  final String group = 'ЭФБО-03-22';
  final String phoneNumber = '+1 234 567 89 00';
  final String email = 'antonio@mail.ru';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Профиль'),
      centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ФИО:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(fullName, style: TextStyle(fontSize: 18)),

            SizedBox(height: 20),

            // Блок с группой
            Text(
              'Группа:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(group, style: TextStyle(fontSize: 18)),

            SizedBox(height: 20),

            Text(
              'Номер телефона:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(phoneNumber, style: TextStyle(fontSize: 18)),

            SizedBox(height: 20),


            Text(
              'Почта:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(email, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
