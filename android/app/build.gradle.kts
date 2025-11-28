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
            // --- PASSO 1: Tenta pegar do seu local.properties (VS Code) ---
            // Nota: O 'as String?' serve para evitar erros de tipo se a chave não existir
            var storePath = localProps["storeFile"] as String?
            var storePass = localProps["storePassword"] as String?
            var keyAlias = localProps["keyAlias"] as String?
            var keyPass = localProps["keyPassword"] as String?

            // --- PASSO 2: Se não achou (null), tenta pegar do Codemagic ---
            if (storePath == null) storePath = System.getenv("CM_KEYSTORE_PATH")
            if (storePass == null) storePass = System.getenv("CM_KEYSTORE_PASSWORD")
            if (keyAlias == null) keyAlias = System.getenv("CM_KEY_ALIAS")
            if (keyPass == null) keyPass = System.getenv("CM_KEY_PASSWORD")

            // --- PASSO 3: Validação Final ---
            if (storePath != null && storePass != null && keyAlias != null && keyPass != null) {
                storeFile = file(storePath)
                storePassword = storePass
                keyAlias = keyAlias
                keyPassword = keyPass
                
                enableV1Signing = false
                enableV2Signing = true
                println("✅ Assinatura de Release configurada com sucesso!")
            } else {
                // Se estiver no emulador (Debug), isso vai aparecer e é normal.
                println("⚠️ Chaves de release não encontradas. Build local rodará sem assinatura de release.")
            }
        }
    }

    buildTypes {
        getByName("release") {
            // Só aplica a assinatura se ela foi configurada com sucesso acima
            val releaseConfig = signingConfigs.getByName("release")
            if (releaseConfig.storeFile != null) {
                signingConfig = releaseConfig
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
