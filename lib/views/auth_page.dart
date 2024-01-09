import 'package:decouvrir/controllers/auth_controller.dart';
import 'package:decouvrir/models/constantes.dart';
import 'package:decouvrir/views/identity_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController numeroPhone = TextEditingController();
  TextEditingController codeOTP = TextEditingController();
  bool isSending = false;

  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(50),
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://i.pinimg.com/564x/2e/c0/77/2ec0773a1fcd847a5bd258ea4bba668e.jpg")),
          ),
          child: ListView(
            children: [
              ListTile(
                leading: IconButton.filledTonal(
                    onPressed: () {
                      authController.deconnexion();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                title: Text(
                  Constantes().appName,
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Container(
                  //height: 200,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.center,
                  child: const Text(
                    "Sortons comme des stars !\n\nDécouvrez les plus beaux et extraordinaires endroits de Ouagadougou\nParticiper a des évènements tous aussi exceptionnels\n\nSortons comme des stars",
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 20),
                  )),
              const Text("Authentification",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Container(
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.green, blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: numeroPhone,
                    //textAlign: TextAlign.center,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        prefixText: " +226 ",
                        border: InputBorder.none,
                        labelText: " Numéro de telephone (sans l'indice)"),
                  )),
              const SizedBox(
                height: 25,
              ),
              (isSending != false)
                  ? const ListTile(
                      title: Text('Verification du numero en cours'),
                      trailing: CircularProgressIndicator())
                  : FloatingActionButton.extended(
                      onPressed: () async {
                        print('+226${numeroPhone.text}');
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '+226${numeroPhone.text}',
                          verificationCompleted:
                              (PhoneAuthCredential credential) {
                            setState(() {
                              isSending = false;
                            });
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Vérification réussie"),
                                    content: const Text(
                                        "Nous avons pu vérifier automatiquement votre numéro de telephone, veuillez cliquer sur OK"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            print("Authentified");
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const IdentityPage();
                                            }));
                                            await auth.signInWithCredential(
                                                credential);
                                          },
                                          child: const Text("OK"))
                                    ],
                                  );
                                });
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            String error = "Error";
                            switch (e.code) {
                              case "network-request-failed":
                                error = "Aucune connexion internet";
                                break;
                              case "invalid-phone-number":
                                error = "Numéro de telephone incorrect";
                                break;
                              default:
                                error = e.code;
                                break;
                            }
                            setState(() {
                              isSending = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(error),
                              backgroundColor: Colors.red,
                            ));
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            setState(() {
                              isSending = false;
                            });
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Code OTP"),
                                      content: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: TextFormField(
                                            controller: codeOTP,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                                hintText:
                                                    "Entrer le code reçu par sms",
                                                border: InputBorder.none)),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              PhoneAuthCredential credential =
                                                  PhoneAuthProvider.credential(
                                                      verificationId:
                                                          verificationId,
                                                      smsCode: codeOTP.text);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              print("Authentified");
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return const IdentityPage();
                                              }));
                                              await auth.signInWithCredential(
                                                  credential);
                                            },
                                            child: const Text("Valider"))
                                      ],
                                    ));
                          },
                          timeout: const Duration(seconds: 120),
                          codeAutoRetrievalTimeout: (String verificationId) {
                            // Auto-resolution timed out...
                            setState(() {
                              isSending = false;
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Vérification automatique échouée'),
                              backgroundColor: Colors.orange,
                            ));
                          },
                        );
                        /*Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const IdentityPage();
                    }));*/
                      },
                      label: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 100,
                        child: const Text("Recevoir le code",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 20)),
                      )),
              const SizedBox(
                height: 25,
              ),
              const Center(
                  child: Text(
                "Ou continuer avec",
                style: TextStyle(color: Colors.white),
              )),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () async {
                      print("Authentified");
                      await authController.signInWithGoogle();
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const IdentityPage();
                      }));
                    },
                    child: Image.network(
                        "https://i.pinimg.com/564x/60/41/99/604199df880fb029291ddd7c382e828b.jpg"),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: () {},
                    child: const Icon(
                      Icons.facebook,
                      color: Colors.white,
                    ),
                  ),
                  FloatingActionButton(
                      backgroundColor: Colors.black,
                      onPressed: () {},
                      child: Image.network(
                          "https://i.pinimg.com/564x/cc/31/6f/cc316f97197528e5e26e613a93ab16a4.jpg")),
                ],
              ),
            ],
          )),
    );
  }
}
