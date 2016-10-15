import PackageDescription

let package = Package(
    name: "StartAppsKitJson",
    dependencies: [
        .Package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", versions: Version(3,1,0)..<Version(3, .max, .max))
    ]
)
