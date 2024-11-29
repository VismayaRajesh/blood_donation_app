import 'package:flutter/material.dart';
import '../database/dbhelper.dart';
import '../database/model.dart';

class UserDetailsPage extends StatefulWidget {
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  String? name;
  String? location;
  String? bloodType;
  String? phone;
  final TextEditingController lastDonationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 25,
        ),
        backgroundColor: Color(0xFFBB2727),
        title: Text(
          'Donor Details',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {
              // Show help or info dialog if needed
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Please share your details with us to connect you with those in need of blood donations.',
                    style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                    maxLines: 3,
                  ),
                ),
                _buildTextField(
                  label: 'Name',
                  onSaved: (value) => name = value,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  label: 'Location',
                  onSaved: (value) => location = value,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your location' : null,
                ),
                SizedBox(height: 10),

                // Blood Type dropdown
                _buildDropdownButtonFormField(
                  label: 'Blood Type',
                  items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
                  onChanged: (value) => setState(() => bloodType = value),
                  validator: (value) => value == null || value.isEmpty ? 'Please select your blood type' : null,
                ),
                SizedBox(height: 10),

                // Additional input fields
                _buildTextField(
                  label: 'Weight',
                  onSaved: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your weight';
                    if (double.tryParse(value) == null) return 'Enter a valid weight';
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                _buildDropdownButtonFormField(
                  label: 'Gender',
                  items: ['Male', 'Female', 'Other'],
                  onChanged: (value) {},
                  validator: (value) => value == null || value.isEmpty ? 'Please select your gender' : null,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  label: 'Age',
                  onSaved: (value) {},
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your age' : null,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  label: 'Phone Number',
                  onSaved: (value) => phone = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your phone number';
                    if (value.length < 10) return 'Enter a valid phone number';
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 10),

                // Date Picker for Last Donation Date
                _buildTextField(
                  label: 'Last Donation Date',
                  controller: lastDonationController,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode()); // Dismiss keyboard
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        lastDonationController.text =
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"; // Format date
                      });
                    }
                  },
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Please select the last donation date' : null, onSaved: (String? newValue) {
                },
                ),
                SizedBox(height: 10),

                _buildTextField(
                  label: 'Medical Condition',
                  onSaved: (value) {},
                  validator: (value) => value == null || value.isEmpty ? 'Please enter any medical condition' : null,
                ),
                SizedBox(height: 20),

                // Styled Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _addUser();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    backgroundColor: Color(0xFFBB2727),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    GestureTapCallback? onTap,
    required FormFieldSetter<String> onSaved,
    FormFieldValidator<String>? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
      controller: controller,
      onTap: onTap,
      onSaved: onSaved,
      validator: validator,
      keyboardType: keyboardType,
      readOnly: onTap != null, // Make field read-only if onTap is provided
    );
  }

  Widget _buildDropdownButtonFormField({
    required String label,
    required List<String> items,
    required FormFieldSetter<String> onChanged,
    FormFieldValidator<String>? validator,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

  Future<void> _addUser() async {
    User user = User(
      name: name!,
      location: location!,
      bloodType: bloodType!,
      phone: phone!,
    );
    await _databaseHelper.insertUser(user);
    Navigator.pop(context);
  }
}
