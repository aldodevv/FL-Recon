import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "id.co.recon.dev"
            resValue(type = "string", name = "app_name", value = "Recon dev")
        }
        create("uat") {
            dimension = "flavor-type"
            applicationId = "id.co.recon.uat"
            resValue(type = "string", name = "app_name", value = "Recon uat")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "id.co.recon"
            resValue(type = "string", name = "app_name", value = "Recon")
        }
    }
}