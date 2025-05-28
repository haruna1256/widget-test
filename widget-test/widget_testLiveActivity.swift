//
//  widget_testLiveActivity.swift
//  widget-test
//
//  Created by 川岸遥奈 on 2025/05/28.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct widget_testAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct widget_testLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: widget_testAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension widget_testAttributes {
    fileprivate static var preview: widget_testAttributes {
        widget_testAttributes(name: "World")
    }
}

extension widget_testAttributes.ContentState {
    fileprivate static var smiley: widget_testAttributes.ContentState {
        widget_testAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: widget_testAttributes.ContentState {
         widget_testAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: widget_testAttributes.preview) {
   widget_testLiveActivity()
} contentStates: {
    widget_testAttributes.ContentState.smiley
    widget_testAttributes.ContentState.starEyes
}
