import SwiftUI
import StoriesAppComponents

public struct UserListView: View {
    let users: [User]
    let onUserTap: (User) -> Void
    
    public init(users: [User], onUserTap: @escaping (User) -> Void) {
        self.users = users
        self.onUserTap = onUserTap
    }

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(users) { user in
                    VStack {
                        ZStack {
                            Circle()
                                .strokeBorder(
                                    LinearGradient(
                                        colors: [Color.purple, Color.orange, Color.red, Color.yellow],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 4
                                )
                                .frame(width: 80, height: 80)
                            if let profileUrl = user.profilePictureURL {
                                RemoteImageView(url: profileUrl)
                                    .frame(width: 72, height: 72)
                                    .clipShape(Circle())
                            }
                        }
                        Text(user.name)
                            .font(.caption)
                            .lineLimit(1)
                    }
                    .onTapGesture {
                        onUserTap(user)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}
