package com.example.recon

// import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity

// class MainActivity : FlutterActivity()
class MainActivity : FlutterFragmentActivity() {
      // 1. Definisikan nama channel yang SAMA PERSIS dengan di Flutter.
    private val CHANNEL = "com.example.flutter_bridge/data"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // 2. Buat instance MethodChannel.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // `call` berisi nama metode dan argumennya.
            // `result` digunakan untuk mengirim kembali hasil ke Flutter.
            call, result ->

            // 3. Gunakan 'when' untuk menangani metode yang dipanggil dari Flutter.
            when (call.method) {
                "sendString" -> {
                    // Ambil argumen sebagai String
                    val data = call.arguments<String>()
                    // Log di Logcat Android Studio
                    Log.d("NativeLog-Kotlin", "Received String: $data")
                    result.success(null) // Kirim konfirmasi sukses (opsional)
                }
                "sendObject" -> {
                    // Ambil argumen sebagai Map
                    val data = call.arguments<Map<String, Any>>()
                    Log.d("NativeLog-Kotlin", "Received Object: $data")
                    result.success(null)
                }
                "sendArray" -> {
                    // Ambil argumen sebagai List
                    val data = call.arguments<List<Any>>()
                    Log.d("NativeLog-Kotlin", "Received Array: $data")
                    result.success(null)
                }
                else -> {
                    // Jika metode tidak ditemukan
                    result.notImplemented()
                }
            }
        }
    }
}
