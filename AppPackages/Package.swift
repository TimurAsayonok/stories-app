// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

enum Module: String, CaseIterable {
    case LocalizationStrings
    case StoriesAppModule
    case StoriesAppComponents
    case StoriesAppCore
    case StoriesAppModels
    case StoriesAppStoriesFeature
    case StoriesAppServices
    case 
    
    static let staticModules: [Module] = [.StoriesAppModule]
    
    var product: Product {
        .library(
            name: rawValue,
            type: Self.staticModules.contains(self) ? .static : .dynamic,
            targets: [rawValue]
        )
    }
    
    var target: Target {
        switch self {
        case .StoriesAppModule:
            return .target(
                name: rawValue,
                dependencies: [
                    .init(.LocalizationStrings),
                    .init(.StoriesAppComponents),
                    .init(.StoriesAppCore),
                    .init(.StoriesAppModels),
                    .init(.StoriesAppStoriesFeature),
                    .init(.StoriesAppServices)
                ]
            )
        case .LocalizationStrings:
            return .target(
                name: rawValue,
                dependencies: [],
                resources: [.process("Resources")]
            )
        case .StoriesAppComponents:
            return .target(
                name: rawValue,
                dependencies: []
            )
        case .StoriesAppCore:
            return .target(
                name: rawValue,
                dependencies: [
                    .init(.StoriesAppModels)
                ]
            )
        case .StoriesAppModels:
            return .target(
                name: rawValue,
                dependencies: [
                    .init(.LocalizationStrings)
                ]
            )
        case .StoriesAppStoriesFeature:
            return .target(
                name: rawValue,
                dependencies: [
                    .init(.LocalizationStrings)
                ]
            )
        case .StoriesAppServices:
            return .target(
                name: rawValue,
                dependencies: [
                    .init(.StoriesAppModels),
                    .init(.LocalizationStrings)
                ]
            )
        }
    }
    var testName: String {
        rawValue + "Tests"
    }
    
    var testTarget: Target? {
        switch self {
        case .StoriesAppCore:
            return .testTarget(
                name: testName,
                dependencies: [
                    .init(self)
                ]
            )
        default: return nil
        }
    }
}

//enum Dependency: String, CaseIterable {
//    var packageDependency: Package.Dependency?
//    var packageName: String = ""
//}

extension Target.Dependency {
    init(_ module: Module) {
        self.init(stringLiteral: module.rawValue)
    }
}
//    init(_ dependency: Dependency) {
//        self = .product(name: dependency.rawValue, package: dependency.packageName)
//    }

let package = Package(
    name: "AppPackages",
    defaultLocalization: "en",
    platforms: [.iOS(.v18)],
    products: Module.allCases.map(\.product),
    dependencies: [],
    targets: Module.allCases.map(\.target) + Module.allCases.compactMap(\.testTarget)
)
