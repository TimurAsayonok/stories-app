import SwiftUI
import StoriesAppUserListFeature
import StoriesAppStoriesFeature
import StoriesAppModels
import LocalizationStrings

public struct StoriesHomePageView: View {
    @ObservedObject private var viewModel: StoriesHomePageViewModel
    
    public init(viewModel: StoriesHomePageViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Text(L10N.storiesStreenTitle)
                .font(.title)
                .bold()
                .padding(.leading, 16)
            UserListView(viewModel: viewModel.userListViewModel)
                .frame(height: 100)
            Spacer()
        }
        .fullScreenCover(isPresented: $viewModel.onPresentStoriesView) {
            if let viewModel = viewModel.storiesViewModel {
                StoriesView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.loadOrFetchUsers()
        }
    }
}
