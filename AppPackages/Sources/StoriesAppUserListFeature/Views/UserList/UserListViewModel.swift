import Foundation
import Combine

final class UserListViewModel: ObservableObject {
    @Published var users: [User] = []

    func fetchUsers() {
    }
}
