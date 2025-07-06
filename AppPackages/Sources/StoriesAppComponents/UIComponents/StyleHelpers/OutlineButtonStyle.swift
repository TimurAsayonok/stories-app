import SwiftUI

public struct OutlineButtonStyle: ButtonStyle {
    var color: Color
    
    public init(color: Color = Color.black) {
        self.color = color
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundStyle(color)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(
                    cornerRadius: 16,
                    style: .continuous
                )
                .stroke(color, lineWidth: 2)
            )
    }
}
