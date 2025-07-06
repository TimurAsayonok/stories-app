import Foundation

public enum L10N {
    public static let welcomeScreenTitle = localizedString("welcome_screen_title")
    public static let startButtonTitle = localizedString("start_button_title")
    public static let welcomeScreenMessage = localizedString("welcome_screen_message")

    public static let transactionListTitle = localizedString("transaction_list_title")
    public static let transactionListTotalAmount = localizedString("transaction_list_total_amount")
    public static let transactionListEmptyTitle = localizedString("transaction_list_empty_title")
    public static let transactionListEmptyDescription = localizedString("transaction_list_empty_description")
    
    public static let filterSortByTitle = localizedString("filter_sort_by_title")
    public static let filterSortDateDescending = localizedString("filter_sort_date_descending")
    public static let filterSortDateAscending = localizedString("filter_sort_date_ascending")
    public static let filterCategoryTitle = localizedString("filter_category_title")
    
    public static let closeButton = localizedString("close_button")
    public static let clearButton = localizedString("clear_button")
    public static let cancelButton = localizedString("cancel_button")
    public static let okButton = localizedString("ok_button")
    
    public static let alertTitle = localizedString("alert_title")
    
    public static let noInternetConnectionTitle = localizedString("no_internet_connection_title")
    public static let noInternetConnectionDescription = localizedString("no_internet_connection_description")
}

public extension L10N {
    static var tabDiscover: String {
        return localizedString("tab_discover")
    }
    
    static var tabProfile: String {
        return localizedString("tab_profile")
    }
    
    static var tabScan: String {
        return localizedString("tab_scan")
    }
}

extension L10N {
     static func localizedString(_ string: String) -> String {
         return NSLocalizedString(string, bundle: .module, comment: "")
    }
}
