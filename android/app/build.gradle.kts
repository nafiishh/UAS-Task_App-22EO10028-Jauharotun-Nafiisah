plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter Gradle Plugin HARUS PALING AKHIR
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.task_app"
    compileSdk = 36

    defaultConfig {
        applicationId = "com.example.task_app"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = 1
        versionName = "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "17"
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
