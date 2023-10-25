import ProjectDescription
import ProjectDescriptionHelpers

let schemes: [Scheme] = [.makeScheme(target: .configuration("Dev"), name: "Sample")]

let infoPlist: [String: InfoPlist.Value] = [
    "ITSAppUsesNonExemptEncryption": false,
    "CFBundleName": "sample",
    "CFBundleShortVersionString": "1.0.0",
    "CFBundleVersion": "1",
    "UILaunchStoryboardName": "LaunchScreen",
    "KAKAO_REST_KEY": "$(KAKAO_REST_KEY)",
    "KAKAO_APP_KEY": "$(KAKAO_APP_KEY)",
    "SERVER_HOST": "$(SERVER_HOST)",
    "SERVER_JWT_MASTER_KEY": "$(SERVER_JWT_MASTER_KEY)",
    "GOOGLE_API_KEY": "$(GOOGLE_API_KEY)",
    "CFBundleURLTypes": [
        [
            "CFBundleTypeRole": "Editor",
            "CFBundleURLSchemes": ["kakao$(KAKAO_APP_KEY)"]
        ]
    ],
    "UIApplicationSceneManifest": [
        "UIApplicationSupportsMultipleScenes": false,
        "UISceneConfigurations": [
            "UIWindowSceneSessionRoleApplication": [
                [
                    "UISceneConfigurationName": "Default Configuration",
                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate",
                    "UISceneStoryboardFile": "Main"
                ],
            ]
        ]
    ],
    "LSApplicationQueriesSchemes": ["kakaokompassauth", "kakaolink", "kakao$(KAKAO_APP_KEY)", "googlechromes", "comgooglemaps"],
    "App Transport Security Settings": ["Allow Arbitrary Loads": true],
    "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
    "UIAppFonts": [
        "Item 0": "Pretendard-Medium.otf",
        "Item 1": "Pretendard-Regular.otf",
        "Item 2": "Pretendard-SemiBold.otf",
        "Item 3": "Pretendard-Bold.otf"
    ],
    "UIUserInterfaceStyle": "Light"
]

let project = Project(
    name: "Sample", //프로젝트 이름
    organizationName: "com.hyundaiht", // org이름
    options: .options(automaticSchemesOptions: .disabled), //프로젝트 생성 옵션
    packages: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .branch("master"))
    ], //swift package 설정
    settings: .settings(configurations: [ //xcconfig를 활용해 configuration 구성
        .debug(name: "Dev", settings: [:], xcconfig: .relativeToRoot("Config/Dev.xcconfig")),
        .debug(name: "Alpha", settings: [:], xcconfig: .relativeToRoot("Config/Alpha.xcconfig")),
        .debug(name: "Prod", settings: [:], xcconfig: .relativeToRoot("Config/Prod.xcconfig"))
    ]),
    targets: [
        Target(
            name: "Sample",
            platform: .iOS,
            product: .app,
            bundleId: "com.hyundaiht.Sample",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: [.iphone]),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .package(product: "Alamofire"),
                .project(target: "SampleKit", path: .relativeToRoot("Projects/SampleKit")),
                .project(target: "SampleUI", path: .relativeToRoot("Projects/SampleUI"))
            ]
        ),
        Target(
            name: "SampleTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.hyundaiht.SampleTests",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Sample")
            ]
        )
    ],
    schemes: schemes
)

