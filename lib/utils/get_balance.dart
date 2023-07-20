import 'package:http/http.dart' as http;

Future<String> getBalances(String address) async {
  final url = Uri.http('192.168.8.114:3000', '/get_balance_tokens', {
    'address': address,
  });

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to get balances');
  }
}

//checks if an address exists or not
Future<String> checkAddress(String address) async {
  final url = Uri.http('192.168.8.114:3000', '/check_address', {
    'address': address,
  });

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to get balances');
  }
}

//imports the wallet corresponding to a private key
Future<String> importWallet(String pvkey) async {
  final url = Uri.http('192.168.8.114:3000', '/fetch_wallet', {
    'pvkey': pvkey,
  });

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  }else{
        throw Exception('Failed to get balances');
  }
}
