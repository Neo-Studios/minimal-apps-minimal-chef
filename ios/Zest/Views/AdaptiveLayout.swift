import SwiftUI

enum DeviceType {
    case phone
    case tablet
    case desktop
    
    static var current: DeviceType {
        #if os(iOS)
        return UIDevice.current.userInterfaceIdiom == .pad ? .tablet : .phone
        #elseif os(macOS)
        return .desktop
        #else
        return .phone
        #endif
    }
}

struct AdaptiveLayout<ListContent: View, DetailContent: View>: View {
    let listContent: ListContent
    let detailContent: DetailContent
    @State private var showDetail = false
    
    init(
        @ViewBuilder listContent: () -> ListContent,
        @ViewBuilder detailContent: () -> DetailContent
    ) {
        self.listContent = listContent()
        self.detailContent = detailContent()
    }
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > 768 {
                // Tablet/Desktop - Split view
                HStack(spacing: 0) {
                    listContent
                        .frame(width: min(400, geometry.size.width * 0.4))
                    
                    Divider()
                    
                    detailContent
                        .frame(maxWidth: .infinity)
                }
            } else {
                // Phone - Single pane
                NavigationStack {
                    listContent
                }
            }
        }
    }
}

struct AdaptiveNavigationView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > 768 {
                // iPad - Use sidebar
                NavigationSplitView {
                    content
                } detail: {
                    Text("Select an item")
                        .foregroundColor(.secondary)
                }
            } else {
                // iPhone - Use stack
                NavigationStack {
                    content
                }
            }
        }
    }
}

// Responsive Grid
struct AdaptiveGrid<Content: View>: View {
    let content: Content
    let minItemWidth: CGFloat
    
    init(minItemWidth: CGFloat = 300, @ViewBuilder content: () -> Content) {
        self.minItemWidth = minItemWidth
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            let columns = max(1, Int(geometry.size.width / minItemWidth))
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: columns),
                spacing: 16
            ) {
                content
            }
        }
    }
}

// Size class helper
extension View {
    @ViewBuilder
    func adaptiveStack<Content: View>(
        @ViewBuilder content: @escaping (Bool) -> Content
    ) -> some View {
        GeometryReader { geometry in
            let isCompact = geometry.size.width < 768
            content(isCompact)
        }
    }
}

// Responsive padding
extension View {
    func adaptivePadding() -> some View {
        GeometryReader { geometry in
            self.padding(geometry.size.width > 768 ? 32 : 16)
        }
    }
}
