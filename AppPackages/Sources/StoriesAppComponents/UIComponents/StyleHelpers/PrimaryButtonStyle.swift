import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    var size: CGFloat
    
    public init(size: CGFloat = 16) {
        self.size = size
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .cornerRadius(size)
    }
}
