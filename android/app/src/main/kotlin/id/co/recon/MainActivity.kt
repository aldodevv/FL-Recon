package id.co.recon

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log

class MainActivity : FlutterFragmentActivity() {

    private val CHANNEL = "id.co.recon/data"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "sendString" -> {
                    val data = call.arguments as? String
                    Log.d("NativeLog-Kotlin", "Received String: $data")
                    result.success(null)
                }
                "sendObject" -> {
                    val data = call.arguments as? Map<*, *>
                    Log.d("NativeLog-Kotlin", "Received Object: $data")
                    result.success(null)
                }
                "sendArray" -> {
                    val data = call.arguments as? List<*>
                    Log.d("NativeLog-Kotlin", "Received Array: $data")
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }
}
