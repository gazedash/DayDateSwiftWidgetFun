import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
    
        let entryDate = Date()
        let entry = SimpleEntry(date: entryDate, configuration: configuration)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let configuration: ConfigurationIntent
}

struct PlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct DayBattery_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        HStack(content: {
//            Text(entry.date, style: .time)
            DayDataView(dayData: DayData(percent: "33", date: entry.date))
        })
    }
}

@main
struct DayBattery_Widget: Widget {
    private let kind: String = "DayBattery_Widget"

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(), placeholder: PlaceholderView()) { entry in
            DayBattery_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct DayBattery_Widget_Previews: PreviewProvider {
    static var previews: some View {
        DayBattery_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
