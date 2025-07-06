import SwiftUI
import Combine
import StoriesAppComponents

public struct StoriesView: View {
    @ObservedObject private var viewModel: StoriesViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var currentIndex: Int = 0
    @State private var dragOffset: CGSize = .zero

    public init(viewModel: StoriesViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack(alignment: .top) {
            contentView()
            tappableArea()
            tabBarView()
        }
        .background(Color.black.ignoresSafeArea())
        .onChange(of: viewModel.stories) { _ in
            currentIndex = 0 // Reset to first story when user changes
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    dragOffset = value.translation
                }
                .onEnded { value in
                    let horizontal = value.translation.width
                    let vertical = value.translation.height

                    if abs(vertical) > abs(horizontal) {
                        // Only allow downward drag to dismiss
                        if vertical > 60 {
                            dismiss()
                        } else {
                            withAnimation { dragOffset = .zero }
                        }
                    } else if abs(horizontal) > abs(vertical) {
                        // Only allow left/right navigation
                        if horizontal < -50 {
                            if currentIndex < viewModel.stories.count - 1 {
                                withAnimation { currentIndex += 1 }
                            } else {
                                viewModel.onUserChanged(to: .next)
                            }
                        } else if horizontal > 50 {
                            if currentIndex > 0 {
                                withAnimation { currentIndex -= 1 }
                            } else {
                                viewModel.onUserChanged(to: .previous)
                            }
                        }
                        withAnimation { dragOffset = .zero }
                    } else {
                        withAnimation { dragOffset = .zero }
                    }
                }
            )
    }
}

extension StoriesView {
    func contentView() -> some View {
        TabView(selection: $currentIndex) {
            ForEach(Array(viewModel.stories.enumerated()), id: \.offset) { index, story in
                VStack {
                    if let url = URL(string: story.imageURL) {
                        RemoteImageView(url: url)
                    }
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .ignoresSafeArea()
        .offset(y: dragOffset.height)
    }
}
    

extension StoriesView {
    func tappableArea() -> some View {
        HStack(spacing: 0) {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    if currentIndex > 0 {
                        withAnimation { currentIndex -= 1 }
                    } else {
                        // At first story, go to previous user
                        viewModel.onUserChanged(to: .previous)
                    }
                }
            Color.clear
                .contentShape(Rectangle())
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    if currentIndex < viewModel.stories.count - 1 {
                        withAnimation { currentIndex += 1 }
                    } else {
                        // At last story, go to next user
                        viewModel.onUserChanged(to: .next)
                    }
                }
        }
        .ignoresSafeArea()
    }
}

extension StoriesView {
    func tabBarView() -> some View {
        VStack(spacing: 8) {
            HStack(spacing: 4) {
                ForEach(0..<viewModel.stories.count, id: \.self) { index in
                    Rectangle()
                        .fill(index <= currentIndex ? Color.white : Color.white.opacity(0.3))
                        .frame(height: 3)
                        .cornerRadius(2)
                        .animation(.linear(duration: 0.2), value: currentIndex)
                }
            }

            HStack {
                if let userUrl = viewModel.user.profilePictureURL {
                    HStack(spacing: 8) {
                        RemoteImageView(url: userUrl)
                            .frame(width: 36, height: 36)
                            .clipShape(Circle())

                        Text(viewModel.user.name)
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
        }
        .padding(8)
        .background(
            Color.black.opacity(0.02)
                .blur(radius: 0.5)
        )
    }
}
