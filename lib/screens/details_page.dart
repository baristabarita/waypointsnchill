import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic>? country;

  DetailsPage({required this.country});

  void _showSampleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'This button has no functionality (yet hehe)',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFF69BE8),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8C7FD),
      appBar: AppBar(
        backgroundColor: Color(0xFF664AB2),
        title: Text(
          'Viewing Country Details',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'MarketDeco',
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('lib/images/back1.jpg'),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    country?['name']?['common'] ?? 'N/A',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Center the flag
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: country?['flags']?['png'] ?? '',
                      width: 100,
                      height: 100,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Bold texts and right-aligned country details
                  _buildDetailRow('Capital:', country?['capital']?[0] ?? 'N/A'),
                  _buildDetailRow(
                      'Languages:', _getLanguages(country?['languages'])),
                  _buildDetailRow(
                      'Currency:', _getCurrency(country?['currencies'])),
                  _buildDetailRow(
                      'Timezone:', country?['timezones']?[0] ?? 'N/A'),
                  _buildDetailRow('Region:', country?['region'] ?? 'N/A'),
                  _buildDetailRow('Subregion:', country?['subregion'] ?? 'N/A'),
                  _buildDetailRow(
                      'Continent:', country?['continents']?[0] ?? 'N/A'),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      _showSampleDialog(context);
                    },
                    child: Text('Plan Trip'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF69BE8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  String _getLanguages(Map<String, dynamic>? languages) {
    if (languages == null) return 'N/A';
    List<String> languageNames = languages.values.cast<String>().toList();
    return languageNames.join(', ');
  }

  String _getCurrency(Map<String, dynamic>? currencies) {
    if (currencies == null || currencies.isEmpty) return 'N/A';

    final currency = currencies.values.first;
    final currencyName = currency['name'] ?? 'N/A';
    final currencySymbol = currency['symbol'] ?? 'N/A';

    return '$currencyName ($currencySymbol)';
  }
}
