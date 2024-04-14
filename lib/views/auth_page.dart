import 'package:decouvrir/controllers/auth_controller.dart';
import 'package:decouvrir/controllers/user_controller.dart';
import 'package:decouvrir/main.dart';
import 'package:decouvrir/models/constantes.dart';
import 'package:decouvrir/models/user_model.dart';
import 'package:decouvrir/views/identity_page.dart';
import 'package:decouvrir/views/user_profil_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController numeroPhone = TextEditingController();
  TextEditingController codeOTP = TextEditingController();
  TextEditingController email = TextEditingController();
  bool isSending = false;

  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user != null) {
      return StreamBuilder(
          stream: UserController().getUserConnect(user.uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            if (snapshot.hasData) {
              List<Map<String, dynamic>> snapdata =
                  snapshot.data as List<Map<String, dynamic>>;
              if (snapdata.isEmpty) {
                return IdentityPage(user: user);
              }
              return UserProfilPage(
                userId: user.uid,
                identifiant: snapdata[0]['identifiant'],
                userModel: UserModel(
                  nom: snapdata[0]['nom'],
                  imageUrl: snapdata[0]['photo'],
                  age: DateTime.fromMillisecondsSinceEpoch(
                      snapdata[0]['birthday'].millisecondsSinceEpoch),
                ),
              );
            }
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          });
    }
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Constantes().mainColor, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight),
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(Constantes().imagetest)),
          ),
          child: ListView(
            children: [
              ListTile(
                leading: IconButton.filledTonal(
                    onPressed: () {
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
                      boxShadow: [
                        BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    style: const TextStyle(fontSize: 25),
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
                      elevation: 1,
                      onPressed: () async {
                        if (numeroPhone.text != "") {
                          setState(() {
                            isSending = true;
                          });
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '+226${numeroPhone.text}',
                            verificationCompleted:
                                (PhoneAuthCredential credential) {
                              setState(() {
                                isSending = false;
                              });
                              auth.signInWithCredential(credential);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                    "Verification automatique réussie"),
                                backgroundColor: Constantes().mainColor,
                              ));
                              runApp(const MyApp());
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
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(error),
                                backgroundColor: Colors.red,
                              ));
                            },
                            codeSent:
                                (String verificationId, int? resendToken) {
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
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: TextFormField(
                                              controller: codeOTP,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      "Entrer le code reçu par sms",
                                                  border: InputBorder.none)),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () async {
                                                PhoneAuthCredential credential =
                                                    PhoneAuthProvider
                                                        .credential(
                                                            verificationId:
                                                                verificationId,
                                                            smsCode:
                                                                codeOTP.text);
                                                Navigator.pop(context);

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
                                content:
                                    Text('Vérification automatique échouée'),
                                backgroundColor: Colors.orange,
                              ));
                            },
                          );
                        } else {}
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
                "Ou",
                style: TextStyle(color: Colors.white),
              )),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await authController.signInWithGoogle().then((value) =>
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text(
                          "Connexion via votre compte google réussie",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Constantes().mainColor,
                      )));
                },
                icon: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.network(
                        "https://i.pinimg.com/564x/60/41/99/604199df880fb029291ddd7c382e828b.jpg")),
                label: const Text(" continuer avec un Compte Google"),
              )
            ],
          )),
    );
  }
}
