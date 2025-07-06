import Foundation

public enum L10N {
    public static let storiesStreenTitle = localizedString("stories_screen_title")
}

extension L10N {
     static func localizedString(_ string: String) -> String {
         return NSLocalizedString(string, bundle: .module, comment: "")
    }
}
