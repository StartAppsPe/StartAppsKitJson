import PackageDescription

let package = Package(
    name: "StartAppsKitJson",
    dependencies: [
        .Package(url: "https://github.com/StartAppsPe/Jessie.git", versions: Version(2,0,0)..<Version(2, .max, .max))
    ]
)
