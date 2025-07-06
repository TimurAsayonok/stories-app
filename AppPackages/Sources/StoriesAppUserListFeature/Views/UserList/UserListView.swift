import SwiftUI
import StoriesAppComponents
import StoriesAppModels

public struct UserListView: View {
    @ObservedObject private var viewModel: UserListViewModel

    public init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(viewModel.users) { user in
                    let hasUnseen = viewModel.isSeen(user)
                    VStack {
                        ZStack {
                            Circle()
                                .strokeBorder(
                                    hasUnseen ?
                                        LinearGradient(
                                            colors: [Color.purple, Color.orange, Color.red, Color.yellow],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                        : LinearGradient(
                                            colors: [Color.white],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        ),
                                    lineWidth: 4
                                )
                                .frame(width: 80, height: 80)
                            if let profileUrl = user.profilePictureURL {
                                RemoteImageView(url: profileUrl)
                                    .frame(width: 72, height: 72)
                                    .clipShape(Circle())
                                    .opacity(hasUnseen ? 1.0 : 0.5)
                            }
                        }
                        Text(user.name)
                            .font(.caption)
                            .lineLimit(1)
                    }
                    .onTapGesture {
                        viewModel.onUserTap(user)
                    }
                    .onAppear {
                        viewModel.onUserViewAppeared(user.id)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}
