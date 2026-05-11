import 'package:flutter/material.dart';
import 'package:ccavenue_india_sdk_flutter/ccavenue_india_sdk_flutter.dart'; // Your package
 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CCAvenue Payment Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF164880),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _amountController = TextEditingController(text: "170.00");
  final _sdk = CcavenueIndiaSdk(); // Initialize your SDK
  String errorText = "";
  bool _loading = false;

  Future<void> _initiatePayment() async {
    setState(() {
      _loading = true;
      errorText = "";
    }); 
            
    try {
      final order = CCAvenueOrderModel( 
        accessCode: "AVOM83GB32AL00MOLA",
        encRequest: "b9afe5eb3a65f0f0f114a0bd93534873d7689b7bb17c30eb65291702aaaa5b59942209a66364dd2b6fc666f55ab537d24e703093f907f8c6f5d074dc9f393f01b835b96935ec0b73eb6eb97052f4621f3c0a257b7016457d406c407ab2b95450349bb4934a1107ca60bf428d8b46acf94c14fc4631910267e846e8f7296eb6040ae946a7ee5ee7df74e9a0fb6a95884d89f932770c718331a03f1fc7222a4f8ec0ae811ec6d9e5e542605fd9dffc62a7996de90392c497dfa8526d24eab105ba323ec0b9f911854321c2dd44a994aa6c43910648bf0cf48298c02a85a3d8da5916a8e256be88d729ccd0801d0cb06570d9a1bbfa6f2e3d46280e12f749aa2d65a6e79e1c215f9f47d6be6866429f2d67f1972faf89678e04950c4aedf424d4693083aee7f490dd40540b36257dc0e5e976216b86e611cc38de8301e38617f28e69e521eb6ff2cdf0020600d4b4490d166dd5f6be791b6e06f853a13cbace243a814ca6224300c345eb50dae2c69fb72907e3055643f7330193306eb28db082ec3c0d1ed821d70fdd895e3175e9a10b1ebaaec4b87346da7d7fd042827178f986cb6ca5ccba69c1808e3db6ac4741352dc161fa698a984a0a5457a8960208a68733896137e3995408554fcd11034de935bd0c10fe729c041830c75da41e14b4dbfe29a24e8d946484486dbdb6af1bb62e6357166f3986e3bef434c18d88a14f2c918a35873c9b862bb55569c9d1d4d5869500b1856a2e54ecb721663b6e1301441408dd7e23f0699d938e967a3f634b9de0065f39af10fbcda3cdac76bde6df3b74db72e0aa4a9639dce176033eb053379cc737c90e366e5eebf0106f55b61e8a9e9c4050a0bad2c8fd32f5aa942ead7e5841632f1a8b3653c585232db633a9471697a3ed5cfe2e8c704ee3ab61704cdafd615c9bf35f84c8de398f05a387d2fe385070e7ff43efeba6ca3eb1e7646d56651b9d4a9ba764e158b3ca163571ef22ef7bec09a3e0c6e72fc84677a81fc7d117d978f470804936ad3fbac897cb587e0dae8e781f091f7011f9dad3a6a7b7e15c685382bd624fdcc3c66f4315973ca9136ba29a293fe46c182d77f6da2767bf7a636623b2d143259ddf2f3c6a8140b6bceca9fa57ad9511d0fa74a44726cf1ab3ed459909885aa82b31cbba67238942dd89af2ec4ddc97e008226b994a81474792984e6eb888f020ee46e9429fa6893df008f0b54d67610580f6d62dddb2e1ca5f6e4b4cbc4212bc128d5f0606535fb2d8ce7189355360c3a7fe30a0265e35f2b36542f70a33cbb33ae0e485fe0fbeb66ca7e95646118eb7c700fd0b7112c7b0b57f19f4af5a88bc06f0d09ee415ac5f371009516a8604ce2e180336457a65ab22374560cdcf1bff43d6bbea3ba97a4f6d45557dc72b70301bd69c9c88bb6f2d13a605f08e83e4d9b8a27e0b564043af6a3bc0b1f396aa55ef0721fe07dc505fbc84f537fb10ed5ad58d53e2a1f9ac4a695615af5ef1b598f5839a4f820511d060d928eeec4d4e0d67a891f0e07ee71b010b5f11c1ca4416f0892efa8cdef08bd2333cade2373a569b98373740324dfd45183aa658132db51befcca0aefe89d2867d284ab9a7b5920a9e3341b761bb043956b4f711275805247fd9913eb6895e25f696277b073f1c97ddb2fb81ab6b2189c8dc27a8b2a098ebccb56a659e20747c83a31112cf066d54de53cb9b69156eac66b9d3ca6d0273632cc6f70310b58467375e5f4ef91f9058bf4cf7afeba275bdbbdeaa78231905700c2f5240c5379e244eeb879596ede5458a0bcdad0059dbdf5160720aaca9f9c1db6da57e712a0f15356d0176414a7e1d2e0b82a0e0023ab0959892b1f2006d82b05373def5223",
        paymentEnvironment: 'production',
      );      
      
      // 2. Call the SDK - this triggers the native bridge
      final String? response = await _sdk.initiatePayment(order);

      if (!mounted) return;

      setState(() {
        _loading = false;
      }); 

      // 3. Show the raw response returned from Native (Kotlin/Swift)
      _showResponseDialog(response ?? "No response received");

    } catch (e) {
      setState(() {
        _loading = false;
        errorText = "Error: $e";
      });
    }
  } 

  void _showResponseDialog(String response) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('CCAvenue SDK Response'),
        content: SingleChildScrollView(
          child: Text(
            response,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CCAvenue India SDK'),
        centerTitle: true,
        backgroundColor: const Color(0xFF164880),
        foregroundColor: Colors.white,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.account_balance_wallet, size: 80, color: Color(0xFF164880)),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: "Payment Amount",
                      prefixIcon: const Icon(Icons.currency_rupee),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorText: errorText.isEmpty ? null : errorText,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _initiatePayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF164880),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "PROCEED TO PAY",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}