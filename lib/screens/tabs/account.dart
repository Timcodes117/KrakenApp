import "package:flutter/material.dart";

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
       final platformBrightness = MediaQuery.of(context).platformBrightness;
    String themeMode = platformBrightness == Brightness.dark ? "dark" : "light";

    return Scaffold(
      backgroundColor: themeMode == "light" ? Color.fromARGB(255, 251, 251, 251) : Color.fromARGB(244, 25, 25, 25),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          
            Divider(
              color: Colors.transparent,
            ),
            Text(
              "You are not signed in!", textAlign: TextAlign.center,
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: themeMode == "dark" ? Colors.white : const Color.fromARGB(255, 23, 23, 23)),
            ),
            Divider(
              color: Colors.transparent,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Text(
                "Create your account or sign in to an existing account to build and manage your portfoilio.",
                style: TextStyle(
                  fontSize: 16,
                color: themeMode == "dark" ? Colors.grey : Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              color: Colors.transparent,
            ),
            Divider(
              color: Colors.transparent,
            ),
            Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                      child: Text(
                        "create account",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Sign in",
                      style: TextStyle(fontSize: 20, color: Colors.deepPurple),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}