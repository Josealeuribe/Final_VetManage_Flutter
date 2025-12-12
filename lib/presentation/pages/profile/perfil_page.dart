import 'package:flutter/material.dart';
import 'package:project_end/widgets/custom_appbar.dart';
import 'package:project_end/widgets/custom_bottom_nav.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  bool editMode = false;

  final nombre = TextEditingController(text: "Juan");
  final apellido = TextEditingController(text: "Pérez");
  final email = TextEditingController(text: "administrador@gmail.com");
  final telefono = TextEditingController(text: "3001234567");
  final documento = TextEditingController(text: "1234567890");
  final direccion = TextEditingController(text: "Calle 123 #45–67, Bogotá");

  // 🔵 Obtiene iniciales dinámicas basadas en el nombre y apellido
  String getInitials() {
    String n = nombre.text.trim();
    String a = apellido.text.trim();

    if (n.isEmpty && a.isEmpty) return "";
    String first = n.isNotEmpty ? n[0] : "";
    String last = a.isNotEmpty ? a[0] : "";

    return (first + last).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFFF5F7FA),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: 3, // dejamos 2 para que el color del nav sea coherente (existencias)
        onTap: (i) {
          switch (i) {
            case 0:
              Navigator.pushReplacementNamed(context, "/dashboard");
              break;
            case 1:
              Navigator.pushReplacementNamed(context, "/traslados");
              break;
            case 2:
              Navigator.pushReplacementNamed(context, "/existencias");
              break;
            case 3:
              break;
          }
        },
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER SUPERIOR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Mi Perfil",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                IconButton(
                  icon: Icon(
                    editMode ? Icons.close : Icons.edit,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    setState(() => editMode = !editMode);
                  },
                )
              ],
            ),

            const SizedBox(height: 6),
            Text(
              "Gestiona tu información personal",
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),

            const SizedBox(height: 20),

            _profileHeader(),
            const SizedBox(height: 20),
            _infoCard(),

            if (editMode) _saveButton(),
          ],
        ),
      ),
    );
  }

  // 🔵 HEADER CON AVATAR DINÁMICO CENTRADO
  Widget _profileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 38,
            backgroundColor: const Color.fromARGB(255, 44, 97, 255),
            child: Text(
              getInitials(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "${nombre.text} ${apellido.text}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Administrador",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔵 TARJETA DE INFORMACIÓN PERSONAL
  Widget _infoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Información Personal",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          _field("Nombre", nombre),
          _field("Apellido", apellido),
          _field("Correo Electrónico", email),
          _field("Teléfono", telefono),
          _field("Documento", documento),
          _field("Dirección", direccion),
        ],
      ),
    );
  }

  // 🔵 CAMPOS EDITABLES
  Widget _field(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          enabled: editMode,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF1F4F9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // 🔵 BOTÓN GUARDAR CAMBIOS (actualiza avatar también)
  Widget _saveButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 44, 97, 255),
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {
          setState(() {
            editMode = false;
            getInitials(); // fuerza actualización de avatar
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Cambios guardados correctamente"),
              backgroundColor: Colors.green.shade600,
            ),
          );
        },
        child: const Text(
          "Guardar Cambios",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // 🔵 DECORACIÓN GENERAL
  BoxDecoration _box() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      );
}
