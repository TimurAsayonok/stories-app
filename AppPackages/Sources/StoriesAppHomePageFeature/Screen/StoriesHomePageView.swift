import SwiftUI

public struct HomePageView: View {
    @StateObject private var viewModel = StoriesHomePageViewModel()

    public init() {}

    public var body: some View {
        VStack(alignment: .leading) {
            Text("Stories")
                .font(.title)
                .bold()
                .padding(.leading, 16)
            UserListView(users: viewModel.users)
        }
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}
