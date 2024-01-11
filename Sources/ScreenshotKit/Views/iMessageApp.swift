//
//  iMessageApp.swift
//

#if os(iOS)

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

    var isMessage: Bool {
        switch self {
        case .receivedMessage, .sentMessage:
            return true
        default:
            return false
        }
    }

    var content: String {
        switch self {
        case .date(let string), .indicator(let string), .receivedMessage(let string), .sentMessage(let string):
            return string
        }
    }
}

extension Array where Element == iMessageElement {
    var lastMessage: String? {
        return last { $0.isMessage }?.content
    }
}

public struct iMessageHistory: Identifiable {
    public let id: UUID
    public let recipient: iMessageRecipient
    public let date: String
    public let message: String

    public init(recipient: iMessageRecipient, date: String, message: String) {
        self.id = UUID()
        self.recipient = recipient
        self.date = date
        self.message = message
    }
}

public enum iMessageScroll {
    case top
    case bottom
}

extension View {
    @available(iOS 17, *)
    public func iMessageApp(recipient: iMessageRecipient, conversation: [iMessageElement], conversations: [iMessageHistory] = [], scroll: iMessageScroll = .bottom) -> some View {
        let conversations = conversations.isEmpty ? [.init(recipient: recipient, date: DateFormatter.shortTime.string(from: .nineFortyOne), message: conversation.lastMessage ?? "")] : conversations
        return modifier(iMessageAppModifier(recipient: recipient, conversation: conversation, conversations: conversations, scroll: scroll))
    }
}

@available(iOS 17, *)
struct iMessageAppModifier: ViewModifier {
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.device)
    private var device
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass

    let recipient: iMessageRecipient
    let conversation: [iMessageElement]
    let conversations: [iMessageHistory]
    let scroll: iMessageScroll

    var composerWidth: Double {
        guard let device, let screenSize = device.config.size else {
            return 0
        }
        return ((screenSize.width - device.iMessageSize.width) / 2) - device.iMessageOffset
    }

    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            NavigationSplitView(columnVisibility: .constant(.all), preferredCompactColumn: .constant(.detail)) {
                #warning("FIXME: sidebar should be 375 on landscape, but it doesn't work :(")
                MessageSideBar(conversations: conversations)
            } detail: {
                ZStack(alignment: .top) {
                    VStack(spacing: 0) {
                        MessageScrollView(content: conversation, scroll: scroll)
                            .safeAreaPadding(.top, 75)

                        if horizontalSizeClass == .regular {
                            HStack {
                                Spacer()
                                MessageComposer()
                                    .frame(width: composerWidth)
                            }
                        } else {
                            MessageComposer()
                        }

                        Rectangle()
                            .fill(.linearGradient(colors: [
                                (colorScheme == .dark ? .black : .white),
                                .primary.opacity(0.03)
                            ], startPoint: .top, endPoint: .bottom))
                            .frame(height: 5)

                        if horizontalSizeClass == .compact {
                            ZStack(alignment: .top) {
                                content
                                    .safeAreaPadding(.top, 15)
                                    .ignoresSafeArea(edges: .bottom)

                                Capsule()
                                    .fill(.foreground.opacity(0.4))
                                    .frame(width: 36, height: 5)
                                    .padding(.vertical, 5)
                            }
                            .frame(height: device?.iMessageSize.height ?? 200)
                        }
                    }

                    MessageNavigationBar(recipient: recipient)
                }
                .toolbar(.hidden, for: .navigationBar)
            }
            .navigationSplitViewStyle(.balanced)

            if horizontalSizeClass == .regular {
                Rectangle()
                    .fill(Color.black.opacity(0.1))
                    .ignoresSafeArea()

                content
                    .safeAreaPadding(.top, 32)
                    .background(.background)
                    .frame(width: device?.iMessageSize.width ?? 0, height: device?.iMessageSize.height ?? 0)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    .padding(.bottom)
                    .offset(x: device?.iMessageOffset ?? 0)
                    .environment(\.horizontalSizeClass, .compact)
            }
        }
        .tint(.blue)
        .withSystemDecoration()
    }
}

struct MessageSideBar: View {
    let selected: UUID?
    let conversations: [iMessageHistory]

    var body: some View {
        List(conversations, selection: .constant(selected)) { conversation in
            MessageSideBarRow(content: conversation)
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Messages")
        .navigationBarTitleDisplayMode(.large)
    }

    init(conversations: [iMessageHistory]) {
        self.selected = conversations.first?.id
        self.conversations = conversations
    }
}

struct MessageSideBarRow: View {
    let content: iMessageHistory

    var body: some View {
        HStack {
            MessageAvatar(picture: content.recipient.picture)
                .frame(width: 45, height: 45)

            VStack {
                HStack {
                    Text(content.recipient.name)
                        .font(.title3.bold())
                    Spacer(minLength: 0)
                    Text(content.date)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: true, vertical: false)
                }
                HStack(spacing: 0) {
                    Text(content.message)
                        .foregroundStyle(.secondary)
                        .lineLimit(2, reservesSpace: true)

                    Spacer(minLength: 0)
                }
            }
        }
        .padding(.leading, 4)
    }
}

struct MessageNavigationBar: View {
    @Environment(\.device)
    private var device
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass

    let recipient: iMessageRecipient

    var body: some View {
        ZStack {
            HStack {
                if horizontalSizeClass == .compact {
                    Image(systemName: "chevron.backward")
                        .imageScale(.large)
                        .font(.system(.title3,  design: .rounded, weight: .semibold))
                        .foregroundStyle(.blue)
                }
                Spacer()
                Image(systemName: "video")
                    .font(.system(size: 20))
                    .foregroundStyle(.blue)
            }
            .padding(.leading, 15)
            .padding(.trailing, 22)
            .padding(.bottom, device?.homeIndicator != nil ? 22 : 0)

            MessageHeader(recipient: recipient)
                .padding(.bottom, 4)
        }
        .frame(height: 75)
        .background(.thinMaterial, ignoresSafeAreaEdges: .all)
    }
}

struct MessageHeader: View {
    let recipient: iMessageRecipient

    var body: some View {
        VStack(spacing: 5) {
            MessageAvatar(picture: recipient.picture)
                .frame(width: 50, height: 50)

            HStack(spacing: 1) {
                Text(recipient.name)
                Image(systemName: "chevron.forward")
                    .imageScale(.small)
                    .foregroundStyle(.secondary)
            }
            .font(.caption2)
        }
    }
}

struct MessageAvatar: View {
    let picture: iMessageRecipient.Picture

    var body: some View {
        switch picture {
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
}

@available(iOS 17, *)
struct MessageComposer: View {
    @Environment(\.colorScheme)
    private var colorScheme
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass

    var body: some View {
        HStack(spacing: 12) {
            if horizontalSizeClass != .regular {
                Image(systemName: "plus")
                    .font(.headline.weight(.regular))
                    .foregroundStyle(.foreground.opacity(0.6))
                    .padding(9.5)
                    .background(Circle().fill(.gray.opacity(0.2)))
            }

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
        .padding(.top, 4)
        .padding(.bottom, 10)
        .background(colorScheme == .dark ? .black : .white)
        .padding(.top, 10)
    }
}

struct MessageScrollView: View {
    let content: [iMessageElement]
    let scroll: iMessageScroll

    var body: some View {
        GeometryReader { proxy in
            VStack {
                ForEach(content, id: \.self) { element in
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
                }
                Spacer(minLength: 0)
            }
            .frame(height: proxy.size.height, alignment: scroll == .top ?  .top : .bottom)
        }
        .padding(.horizontal, 16)
    }
}

public struct MessageView: View {
    public enum Style {
        case received, sent

        var foreground: Color {
            switch self {
            case .received:
                return .primary
            case .sent:
                return .white
            }
        }

        func background(colorScheme: ColorScheme) -> Color {
            switch self {
            case .received:
                switch colorScheme {
                case .dark:
                    return .init(red: 38/255, green: 37/255, blue: 41/255)
                default:
                    return .init(red: 233/255, green: 232/255, blue: 234/255)
                }
            case .sent:
                return .blue
            }
        }
    }
    
    @Environment(\.colorScheme)
    private var colorScheme

    let content: String
    let style: Style

    public var body: some View {
        Text(content)
            .foregroundStyle(style.foreground)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(style.background(colorScheme: colorScheme))
            )
    }

    public init(content: String, style: Style) {
        self.content = content
        self.style = style
    }
}

#endif
