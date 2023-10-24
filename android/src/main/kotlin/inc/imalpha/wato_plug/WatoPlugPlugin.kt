package inc.imalpha.wato_plug

import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.util.Log
import android.app.Activity
import android.content.Context

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import androidx.annotation.NonNull
import androidx.core.content.ContextCompat
import android.content.ActivityNotFoundException


const val WHATSAPP_PACKAGE = "com.whatsapp"
const val WHATSAPP_B_PACKAGE = "com.whatsapp.w4b"

/** WatoPlugPlugin */
class WatoPlugPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var waChannel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        waChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "wato_plug")
        waChannel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "is_installed") {
            val pm : PackageManager = context.packageManager
            val isInstalled = isPackageInstalled(WHATSAPP_B_PACKAGE,pm)
            result.success(isInstalled)
        } else if (call.method == "message_to") {
            val pack: Number? = call.argument<Number>("package")
            val mobileNo: String? = call.argument<String>("phone")
            val message: String? = call.argument<String>("message")
            val link: String? = call.argument<String>("link")
            messageToWhatsApp(result, context, pack!!, message!!, mobileNo!!, link!!)
        } else if (call.method == "files_to") {
            result.success("Feature to Send Files !")
        } else {
            result.notImplemented()
        }
    }

    private fun messageToWhatsApp(
        sendResult: MethodChannel.Result,
        context: Context,
        packageName: Number,
        message: String,
        phoneNumber: String,
        link: String
    ) {
        val pm: PackageManager = context.packageManager
        lateinit var sendIntent: Intent
        val uri =
            Uri.parse("https://api.whatsapp.com/send?phone=$phoneNumber&text=$message\n$link")
        if (packageName == 0) {
            val isInstalled = isPackageInstalled(WHATSAPP_PACKAGE, pm)
            if (isInstalled) {
                sendIntent = Intent(Intent.ACTION_VIEW, uri)
                sendIntent.setPackage(WHATSAPP_PACKAGE)
                sendResult.success(true)
            } else {
                //TODO: Go TO PLAY Store For WhatsApp
                openPlayStore(context, WHATSAPP_PACKAGE)
            }
        } else {
            val isInstalled = isPackageInstalled(WHATSAPP_B_PACKAGE, pm)
            if (isInstalled) {
                sendIntent = Intent(Intent.ACTION_VIEW, uri)
                sendIntent.setPackage(WHATSAPP_B_PACKAGE)
                sendResult.success(true)
            } else {
                //TODO: Go TO PLAY Store For WhatsApp Business
                openPlayStore(context, WHATSAPP_B_PACKAGE)
            }
        }
        try {
            ContextCompat.startActivity(context, sendIntent, null)
            sendResult.success(true)
        } catch (ex: ActivityNotFoundException) {
            sendResult.error(
                "FLUTTER_ERROR_RESULT",
                ex.message,
                ex
            )
        }
    }

    private fun isPackageInstalled(packageName: String, packageManager: PackageManager): Boolean {
        return try {
            packageManager.getPackageInfo(packageName, 0)
            true
        } catch (e: PackageManager.NameNotFoundException) {
            false
        }
    }

    private fun openPlayStore(context: Context, appPackageName: String) {
        val storeitent = Intent(Intent.ACTION_VIEW)
        storeitent.data =
            Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName")
        context.startActivity(storeitent)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        waChannel.setMethodCallHandler(null)
    }

}
