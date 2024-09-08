import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  @override
  _FormWidgetState createState() => _FormWidgetState();
}
class WrapLayoutExample extends StatelessWidget {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Wrap(
        spacing: 8.0, // jarak horizontal antara elemen
        runSpacing: 8.0, // jarak vertikal antara baris elemen
        children: <Widget>[
          Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 212, 212, 212),
                  image: const DecorationImage(
                    image: AssetImage('assets/dana.png'),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 212, 212, 212),
                  image: const DecorationImage(
                    image: AssetImage('assets/gopay.png'),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 212, 212, 212),
                  image: const DecorationImage(
                    image: AssetImage('assets/ovo.png'),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 212, 212, 212),
                  image: const DecorationImage(
                    image: AssetImage('assets/qris.png'),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 212, 212, 212),
                  image: const DecorationImage(
                    image: AssetImage('assets/bank.png'),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
           
        ],
      ),
    );
  }
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex : 5,
            child:  WrapLayoutExample()
            ),
          Expanded(
            flex : 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Masukan No. tujuan",
                  style : TextStyle(fontSize : 18, fontWeight: FontWeight.bold, color : Colors.green)
                  ),
                TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'No.Tujuan'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan no tujuan';
                      }
                      return null;
                    },
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: Text(
                      'Tarik',
                      style : TextStyle(fontSize: 16, fontWeight : FontWeight.bold)
                      ),
                  ),
                ),
              ],
            )
          )
          
        ],
      ),
    );
  }
}