//
//  KeyboardExtension.swift
//

import SwiftUI

@available(iOS 17, *)
extension View {
    public func keyboardExtension<Toolbar: View, App: View>(height: ((CGSize) -> Double)? = nil, @ViewBuilder keyboardToolbar: () -> Toolbar = { EmptyView() }, @ViewBuilder foregroundApp: () -> App) -> some View {
        modifier(KeyboardExtensionModifier(height: height, keyboardToolbar: keyboardToolbar(), foregroundApp: foregroundApp()))
    }
}

@available(iOS 17, *)
struct KeyboardExtensionModifier<Toolbar: View, App: View>: ViewModifier {
    @Environment(\.colorScheme)
    private var colorScheme

    @Environment(\.device)
    private var device

    let height: ((CGSize) -> Double)?
    let keyboardToolbar: Toolbar
    let foregroundApp: App

    func body(content: Content) -> some View {
        GeometryReader { proxy in
            foregroundApp
                .ignoresSafeArea()
                .overlay {
                    VStack(spacing: 0) {
                        Spacer()

                        VStack(spacing: 0) {
                            keyboardToolbar

                            content
                                .frame(height: height?(proxy.size) ?? device?.keyboardHeight ?? 302)

                            if let safeArea = device?.config.safeArea.bottom, safeArea > 0 {
                                HStack(alignment: .center) {
                                    Image(systemName: "globe")
                                    Spacer()
                                    Image(systemName: "mic")
                                }
                                .font(.title.weight(.light))
                                .foregroundStyle(colorScheme == .dark ? Color.white : Color(red: 80/255, green: 85/255, blue: 92/255))
                                .padding(.bottom, 6)
                                .padding(.leading, 26)
                                .padding(.trailing, 30)
                                .frame(height: 75)
                            }
                        }
                        .background(colorScheme == .dark ? Color(red: 43/255, green: 43/255, blue: 43/255) : Color(red: 209/255, green: 212/255, blue: 217/255), ignoresSafeAreaEdges: .all)
                    }
                    .ignoresSafeArea(edges: .bottom)
                }
                .withSystemDecoration()
        }
    }
}
