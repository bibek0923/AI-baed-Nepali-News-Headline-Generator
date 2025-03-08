
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/services.dart';

// class HeadlineGenerator extends StatefulWidget {
//   @override
//   _HeadlineGeneratorState createState() => _HeadlineGeneratorState();
// }

// class _HeadlineGeneratorState extends State<HeadlineGenerator> {
//   final TextEditingController _controller = TextEditingController();
//   String _generatedHeadline = "";
//   bool _isLoading = false;

//   Future<void> _generateHeadline() async {
//     // Set loading state to true
//     setState(() {
//       _isLoading = true;
//     });
//     // Dismiss the keyboard when generating headline
//     FocusScope.of(context).unfocus();

//     final String articleText = _controller.text;

//     // API URL
//     // final Uri url = Uri.parse('http://127.0.0.1:8000/generate_headline'); for chrome fastapi  uvicorn main:app --reload
//        // final Uri url = Uri.parse('http://192.168.1.69:8000/generate_headline');// for mobile device uvicorn main:app --host 192.168.1.69 --port 8000 //

//         final Uri url = Uri.parse('http://10.0.2.2:8000/generate_headline');//for emulator//


//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: json.encode({"article": articleText}),
      
//     );
//     print("Response status: ${response.statusCode}");
//        print("Response body: ${response.body}");

//     // decoding byte into Nepali
//     final actres = utf8.decode(response.bodyBytes);

//     if (response.statusCode == 200) {
//       // converting decoded data into JSON format
//       final Map<String, dynamic> responseData = json.decode(actres);
//       final headline = responseData["headline"].toString();
//       print("decoded JSON data $responseData");
//       setState(() {
//         _generatedHeadline = headline;
//         _isLoading = false;
//       });
//     } else {
//       setState(() {
//         _generatedHeadline = "Error generating headline!";
//       });
//     }
//   }

//   Future<void> _copyToClipboard() async {
//     if (_generatedHeadline.isNotEmpty) {
//       await Clipboard.setData(ClipboardData(text: _generatedHeadline));
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Headline copied to clipboard!'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Nepali News Headline Generator')),
//       resizeToAvoidBottomInset: true,
//       body: GestureDetector(
//         onTap: () {
//           // Unfocus TextField when tapping outside
//           FocusScope.of(context).unfocus();
//         },
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextField(
//                   controller: _controller,
//                   decoration: InputDecoration(
//                     labelText: 'Enter Article Text',
//                     border: OutlineInputBorder(),
//                   ),
//                   maxLines: 5,
//                 ),
//                 SizedBox(height: 10),
//                 _isLoading ? CircularProgressIndicator():ElevatedButton(
//                   onPressed: _generateHeadline,
//                   child: 
//                       Text('Generate Headline')                   
//                 ),
//                 SizedBox(height: 20),
//                 if (_generatedHeadline.isNotEmpty) ...[
//                   Container(
//                     height: 100,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: SingleChildScrollView(
//                       child: Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Text(
//                           _generatedHeadline,
//                           textAlign: TextAlign.justify,
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: ElevatedButton.icon(
//                       onPressed: _copyToClipboard,
//                       icon: Icon(Icons.copy),
//                       label: Text('Copy Headline'),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

class HeadlineGenerator extends StatefulWidget {
  @override
  _HeadlineGeneratorState createState() => _HeadlineGeneratorState();
}

class _HeadlineGeneratorState extends State<HeadlineGenerator> {
  final TextEditingController _controller = TextEditingController();
  String _generatedHeadline = "";
  bool _isLoading = false;

  Future<void> _generateHeadline() async {
    setState(() {
      _isLoading = true;
    });
    FocusScope.of(context).unfocus();

    final String articleText = _controller.text;
    final Uri url = Uri.parse('http://10.0.2.2:8000/generate_headline');
    // final Uri url = Uri.parse('http://192.168.1.75:8000/generate_headline');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"article": articleText}),
    );
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    final actres = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(actres);
      final headline = responseData["headline"].toString();
      print("decoded JSON data $responseData");
      setState(() {
        _generatedHeadline = headline;
        _isLoading = false;
      });
    } else {
      setState(() {
        _generatedHeadline = "Error generating headline!";
      });
    }
  }

  Future<void> _copyToClipboard() async {
    if (_generatedHeadline.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: _generatedHeadline));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Headline copied to clipboard!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _clearText() {
    setState(() {
      _controller.clear();
      _generatedHeadline = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nepali News Headline Generator')),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter Article Text',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: _generateHeadline,
                              child: Text('Generate Headline'),
                            ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _clearText,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: Text('Clear', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                if (_generatedHeadline.isNotEmpty) ...[
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          _generatedHeadline,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: _copyToClipboard,
                      icon: Icon(Icons.copy),
                      label: Text('Copy Headline'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
