import ProjectDescription
import ProjectDescriptionHelpers


let project = Project(
    name: "SampleKit", //프로젝트 이름
    organizationName: "com.hyundaiht", // org이름
    options: .options(automaticSchemesOptions: .disabled), //프로젝트 생성 옵션
    packages: [], //swift package 설정
    settings: .settings(configurations: [ //xcconfig를 활용해 configuration 구성
        .debug(name: "Dev", settings: [:], xcconfig: .relativeToRoot("Config/Dev.xcconfig")),
        .debug(name: "Alpha", settings: [:], xcconfig: .relativeToRoot("Config/Alpha.xcconfig")),
        .debug(name: "Prod", settings: [:], xcconfig: .relativeToRoot("Config/Prod.xcconfig"))
    ]),
    targets: [
        Target(
            name: "SampleKit",
            platform: .iOS,
            product: .staticFramework,
            bundleId: "com.hyundaiht.SampleKit",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: [.iphone]),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: []
        ),
        Target(
            name: "SampleKitTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.hyundaiht.SampleKitTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "SampleKit")
            ]
        )
    ]
)

