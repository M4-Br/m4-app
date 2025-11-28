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
        val keyAliasValue = System.getenv("CM_KEY_ALIAS")
        val keyPasswordValue = System.getenv("CM_KEY_PASSWORD")
        val storePasswordValue = System.getenv("CM_KEYSTORE_PASSWORD")
        val storeFilePath = System.getenv("CM_KEYSTORE_PATH")

        if (keyAliasValue == null || keyPasswordValue == null || storePasswordValue == null || storeFilePath == null) {
            throw GradleException("Codemagic keystore variables are missing!")
        }

        keyAlias = keyAliasValue
        keyPassword = keyPasswordValue
        storePassword = storePasswordValue
        storeFile = file(storeFilePath)

        enableV1Signing = false
        enableV2Signing = true
    }
}

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
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
