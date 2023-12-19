import 'package:decouvrir/models/constantes.dart';
import 'package:decouvrir/views/identity_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
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
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.green, blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Numéro de telephone (avec l'indice)"),
                  )),
              const SizedBox(
                height: 25,
              ),
              FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const IdentityPage();
                    }));
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
                    onPressed: () {},
                    child: const Icon(Icons.mail),
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
                    child:
                        const Icon(Icons.one_x_mobiledata, color: Colors.white),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
