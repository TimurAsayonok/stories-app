import SwiftUI

public struct RemoteImageView: View {
    let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    public var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .failure:
                Color.gray
            case .success(let image):
                image.resizable()
            @unknown default:
                EmptyView()
            }
        }
    }
}
