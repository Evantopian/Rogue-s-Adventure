import 'package:postgres/postgres.dart';

void main() async {
  // move this into a dotenv file
  final conn = await Connection.open(
    Endpoint(
      host: '127.0.0.1',
      database: 'cardgame',
      username: 'postgres',
      password: 'superuserpassword',
    ),
    //we can implement ssl encrypt later if we want to follow conventions through and through
    settings: const ConnectionSettings(sslMode: SslMode.disable), 
  );
  //print('has connection!');

  
  await conn.execute('''
      id SERIAL PRIMARY KEY,
      name TEXT NOT NULL,
      level INT NOT NULL,
      card_collection TEXT[] -- Assuming card collection is stored as an array of strings
    )
  ''');

  //print('Table created successfully');

  await conn.close();
}