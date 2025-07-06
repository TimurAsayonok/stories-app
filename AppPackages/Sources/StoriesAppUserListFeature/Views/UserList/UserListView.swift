import SwiftUI

public struct UserListView: View {
    let users: [User]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(viewModel.users) { user in
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
                            Image(user.avatar)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 72, height: 72)
                                .clipShape(Circle())
                        }
                        Text(user.name)
                            .font(.caption)
                            .lineLimit(1)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}
