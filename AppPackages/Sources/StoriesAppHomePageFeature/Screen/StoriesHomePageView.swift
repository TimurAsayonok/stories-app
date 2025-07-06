import SwiftUI
import StoriesAppUserListFeature
import StoriesAppStoriesFeature

public struct StoriesHomePageView: View {
    @StateObject private var viewModel = StoriesHomePageViewModel()

    public init() {}

    public var body: some View {
        VStack(alignment: .leading) {
            Text("Stories")
                .font(.title)
                .bold()
                .padding(.leading, 16)
            UserListView(
                users: viewModel.userList,
                onUserTap: {
                    user in viewModel.presentStories(for: user)
                }
            )
                             
            Spacer()
        }
        .onAppear {
            viewModel.fetchHomePage()
        }
        .fullScreenCover(isPresented: $viewModel.onPresentStoriesView) {
            if let viewModel = viewModel.storiesViewModel {
                StoriesView(viewModel: viewModel)
            }
        }
    }
}
