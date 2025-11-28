import com.android.build.gradle.internal.dsl.BaseAppModuleExtension
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import java.util.Properties 

val localProps = Properties()
val localPropsFile = rootProject.file("local.properties")
if (localPropsFile.exists()) {
    localProps.load(localPropsFile.inputStream())
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.app_flutter_miban4"
    compileSdk = 36
    ndkVersion = "29.0.13599879"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "mibanka4.release"
        minSdk = 27
        targetSdk = 36
        versionCode = 1
        versionName = "1.0.0"
    }

    signingConfigs {
        create("release") {
            println("\n====== [DIAGNÓSTICO DE ASSINATURA] ======")
            
            // 1. Tenta carregar do local.properties (VS Code)
            var storePath = localProps["storeFile"] as String?
            var storePass = localProps["storePassword"] as String?
            var keyAliasVal = localProps["keyAlias"] as String?
            var keyPass = localProps["keyPassword"] as String?

            if (!storePath.isNullOrEmpty()) {
                println("✅ Modo Local detectado via local.properties")
            } else {
                // 2. Tenta carregar do Codemagic (Variáveis de Ambiente)
                println("🔄 Tentando ler variáveis do Codemagic...")
                storePath = System.getenv("CM_KEYSTORE_PATH")
                storePass = System.getenv("CM_KEYSTORE_PASSWORD")
                keyAliasVal = System.getenv("CM_KEY_ALIAS")
                keyPass = System.getenv("CM_KEY_PASSWORD")
            }

            // --- IMPRESSÃO DOS STATUS (Sem revelar senhas) ---
            println("   > Caminho do Arquivo (StorePath): ${if (storePath.isNullOrEmpty()) "❌ NULO/VAZIO" else "✅ OK: $storePath"}")
            println("   > Senha da Store (StorePass):     ${if (storePass.isNullOrEmpty()) "❌ NULO/VAZIO" else "✅ OK (Definida)"}")
            println("   > Alias da Chave (KeyAlias):      ${if (keyAliasVal.isNullOrEmpty()) "❌ NULO/VAZIO" else "✅ OK: $keyAliasVal"}")
            println("   > Senha da Chave (KeyPass):       ${if (keyPass.isNullOrEmpty()) "❌ NULO/VAZIO" else "✅ OK (Definida)"}")

            // 3. Configuração REAL
            if (!storePath.isNullOrEmpty() && !storePass.isNullOrEmpty() && !keyAliasVal.isNullOrEmpty() && !keyPass.isNullOrEmpty()) {
                val f = file(storePath!!)
                if (f.exists()) {
                    storeFile = f
                    storePassword = storePass
                    keyAlias = keyAliasVal
                    keyPassword = keyPass
                    enableV1Signing = false
                    enableV2Signing = true
                    println("🚀 SUCESSO: Assinatura configurada para o arquivo ${f.absolutePath}")
                } else {
                    println("❌ ERRO CRÍTICO: O caminho existe ($storePath), mas o arquivo NÃO foi encontrado no disco.")
                }
            } else {
                println("⚠️ AVISO: Faltam variáveis. A assinatura de Release será PULADA.")
            }
            println("=========================================\n")
        }
    }

    buildTypes {
        getByName("release") {
            // Só aplica a assinatura se ela foi realmente configurada acima
            val releaseConf = signingConfigs.getByName("release")
            
            // Verificação extra para evitar o NullPointerException
            if (releaseConf.storeFile != null && releaseConf.storePassword != null && releaseConf.keyAlias != null && releaseConf.keyPassword != null) {
                signingConfig = releaseConf
            } else {
                println("⚠️ Build de Release sendo gerado SEM assinatura (signingConfig ignorado).")
            }

            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    val appCenterSdkVersion = "4.4.5"
    implementation("com.microsoft.appcenter:appcenter-analytics:$appCenterSdkVersion")
    implementation("com.microsoft.appcenter:appcenter-crashes:$appCenterSdkVersion")

    val cameraXVersion = "1.3.2"
    implementation("androidx.camera:camera-core:$cameraXVersion")
    implementation("androidx.camera:camera-camera2:$cameraXVersion")
    implementation("androidx.camera:camera-lifecycle:$cameraXVersion")
    implementation("androidx.camera:camera-view:$cameraXVersion")
    implementation("androidx.camera:camera-extensions:$cameraXVersion")
}
