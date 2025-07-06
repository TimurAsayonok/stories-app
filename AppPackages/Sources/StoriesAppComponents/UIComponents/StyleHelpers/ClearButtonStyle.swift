import SwiftUI

public struct ClearButtonStyle: ButtonStyle {
    var labelColor: Color
    
    public init(labelColor: Color = Color.black) {
        self.labelColor = labelColor
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundStyle(labelColor)
            .frame(maxWidth: .infinity)
    }
}
