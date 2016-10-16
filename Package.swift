import PackageDescription

let package = Package(
    name: "StartAppsKitJson",
    dependencies: [
        .Package(url: "https://github.com/StartAppsPe/Jessie.git", versions: Version(0,9,0)..<Version(1, .max, .max))
    ]
)
