import SwiftUI
import Combine
import StoriesAppComponents
import StoriesAppModels

public struct StoriesView: View {
    @ObservedObject private var viewModel: StoriesViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var dragOffset: CGSize = .zero

    public init(viewModel: StoriesViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack(alignment: .top) {
            contentView()
            VStack {
                tappableArea()
                Spacer()
            }
            tabBarView()
        }
        .background(Color.black.ignoresSafeArea())
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
                            withAnimation {
                                viewModel.moveToNextStory()
                            }
                        } else if horizontal > 50 {
                            withAnimation { viewModel.moveToPreviousStory() }
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
        TabView(selection: $viewModel.indexToPresent) {
            ForEach(Array(viewModel.stories.enumerated()), id: \.offset) { index, story in
                VStack {
                    if let url = URL(string: story.imageURL) {
                        RemoteImageView(url: url)
                    }
                    Spacer()
                    likeButton(for: story)
                        .padding(.bottom, 32)
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .ignoresSafeArea()
        .offset(y: dragOffset.height)
        .onAppear() {
            viewModel.markStoryAsSeen(index: viewModel.indexToPresent)
        }
        .onChange(of: viewModel.indexToPresent) { newIndex in
            viewModel.markStoryAsSeen(index: newIndex)
        }
    }
}
    

extension StoriesView {
    func tappableArea() -> some View {
        HStack(spacing: 0) {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        viewModel.moveToPreviousStory()
                    }
                }
            Color.clear
                .contentShape(Rectangle())
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        viewModel.moveToNextStory()
                    }
                }
        }
        .padding(.bottom, 100)
    }
}

extension StoriesView {
    func tabBarView() -> some View {
        VStack(spacing: 8) {
            HStack(spacing: 4) {
                ForEach(0..<viewModel.stories.count, id: \.self) { index in
                    Rectangle()
                        .fill(index <= viewModel.indexToPresent ? Color.white : Color.white.opacity(0.3))
                        .frame(height: 3)
                        .cornerRadius(2)
                        .animation(.linear(duration: 0.2), value: viewModel.indexToPresent)
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

extension StoriesView {
    func likeButton(for story: Story) -> some View {
        HStack {
            Spacer()
            Button(action: {
                viewModel.toggleLike(for: story)
            }) {
                Image(systemName: story.isLiked ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 24, height: 20)
                    .foregroundColor(story.isLiked ? .red : .white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .clipShape(Circle())
            }
        }
    }
}
