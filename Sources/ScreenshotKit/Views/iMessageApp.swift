//
//  iMessageApp.swift
//

import SwiftUI

public struct iMessageRecipient {
    public enum Picture {
        case initials(String)
        case picture(Image)
    }

    public let name: String
    public let picture: Picture

    public init(name: String, picture: Picture) {
        self.name = name
        self.picture = picture
    }
}

public enum iMessageElement: Hashable, Equatable {
    case date(String)
    case indicator(String)
    case receivedMessage(String)
    case sentMessage(String)
}

struct iMessageAppModifier: ViewModifier {
    @Environment(\.colorScheme)
    private var colorScheme

    @Environment(\.device)
    private var device

    let recipient: iMessageRecipient
    let content: [iMessageElement]

    func body(content: Content) -> some View {
        NavigationStack {
            VStack(spacing: 0) {
                MessageScrollView(content: self.content)

                MessageComposer()

                Rectangle()
                    .fill(.linearGradient(colors: [
                        (colorScheme == .dark ? .black : .white),
                        .primary.opacity(0.05)
                    ], startPoint: .top, endPoint: .bottom))
                    .frame(height: 5)

                Capsule()
                    .fill(.foreground.opacity(0.4))
                    .frame(width: 36, height: 5)
                    .padding(.vertical, 5)

                content
                    .frame(height: device?.iMessageHeight ?? 200)
                    .ignoresSafeArea(edges: .bottom)
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    MessageHeader(recipient: recipient)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {} label: {
                        Image(systemName: "chevron.backward")
                            .imageScale(.large)
                            .font(.body.weight(.bold))
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {} label: {
                        Image(systemName: "video")
                            .imageScale(.large)
                    }
                }
            }
        }
        .withSystemDecoration()
    }
}

struct MessageHeader: View {
    let recipient: iMessageRecipient

    var body: some View {
        VStack {
            Group {
                switch recipient.picture {
                case .initials(let string):
                    Circle()
                        .fill(LinearGradient(colors: [
                            .init(red: 166/255, green: 172/255, blue: 185/255),
                            .init(red: 133/255, green: 138/255, blue: 147/255)
                        ], startPoint: .top, endPoint: .bottom))
                        .overlay {
                            Text(string)
                                .font(.system(size: 22, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                        }
                case .picture(let image):
                    image
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .mask(Circle())
                }
            }
            .frame(width: 50, height: 50)

            HStack(spacing: 1) {
                Text(recipient.name)
                Image(systemName: "chevron.forward")
                    .imageScale(.small)
                    .foregroundStyle(.secondary)
            }
            .font(.caption2)
        }
        .padding(.bottom, -29)
    }
}

struct MessageComposer: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "plus")
                .font(.headline.weight(.regular))
                .foregroundStyle(.foreground.opacity(0.6))
                .padding(9.5)
                .background(Circle().fill(.gray.opacity(0.2)))

            HStack {
                Text("iMessage")
                    .foregroundStyle(Color(UIColor.placeholderText))
                    .font(.system(size: 17))
                Spacer()
                Image(systemName: "mic.fill")
                    .foregroundStyle(.foreground.opacity(0.4))
            }
            .padding(.top, 8)
            .padding(.bottom, 7)
            .padding(.leading, 12)
            .padding(.trailing, 13)
            .background(Capsule().stroke(Color(UIColor.placeholderText)))
        }
        .padding(.leading, 13)
        .padding(.trailing, 16)
        .padding(.top, 14)
        .padding(.bottom, 10)
    }
}

struct MessageScrollView: View {
    let content: [iMessageElement]

    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { proxy in
                ScrollView {
                    ForEach(content.reversed(), id: \.self) { element in
                        Group {
                            switch element {
                            case .date(let date):
                                Text(date)
                                    .font(.caption2.weight(.medium))
                                    .foregroundStyle(.secondary)
                                    .padding(.top, 8)
                            case .indicator(let indicator):
                                HStack {
                                    Spacer()
                                    Text(indicator)
                                        .font(.caption2.weight(.medium))
                                        .foregroundStyle(.secondary)
                                }
                            case .receivedMessage(let content):
                                HStack {
                                    HStack {
                                        MessageView(content: content, style: .received)
                                        Spacer(minLength: 0)
                                    }
                                    .frame(maxWidth: proxy.size.width * 0.8)
                                    Spacer()
                                }
                            case .sentMessage(let content):
                                HStack {
                                    Spacer()
                                    HStack {
                                        Spacer(minLength: 0)
                                        MessageView(content: content, style: .sent)
                                    }
                                    .frame(maxWidth: proxy.size.width * 0.8)
                                }
                            }
                        }
                        .scaleEffect(x: 1, y: -1)
                    }
                }
                .scaleEffect(x: 1, y: -1)
            }
            .padding(.horizontal, 16)
        }
    }
}

struct MessageView: View {
    enum Style {
        case received, sent

        var foreground: Color {
            switch self {
            case .received:
                return .primary
            case .sent:
                return .white
            }
        }

        var background: Color {
            switch self {
            case .received:
                return .init(red: 233/255, green: 232/255, blue: 234/255)
            case .sent:
                return .blue
            }
        }
    }
    
    let content: String
    let style: Style

    var body: some View {
        Text(content)
            .foregroundStyle(style.foreground)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(style.background)
            )
    }
}

extension View {
    public func iMessageApp(recipient: iMessageRecipient, content: [iMessageElement]) -> some View {
        modifier(iMessageAppModifier(recipient: recipient, content: content))
    }
}
