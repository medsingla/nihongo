//
//  VocabWidget.swift
//  VocabWidget
//
//  Created by Medhansh Singla on 4/10/24.
//

import Foundation
import WidgetKit
import AppIntents
import SwiftUI

struct Provider: TimelineProvider {
        
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), english: WidgetVocab.english(), kana: WidgetVocab.kana(), show: WidgetVocab.show())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        completion(SimpleEntry(date: Date(), english: WidgetVocab.english(), kana: WidgetVocab.kana(), show: WidgetVocab.show()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [SimpleEntry(date: Date(), english: WidgetVocab.english(), kana: WidgetVocab.kana(), show: WidgetVocab.show())], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let english: String
    let kana: String
    let show: Bool
}

struct WidgetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Vocab Review")
                .font(.system(size: 20.0, weight: .regular, design: .rounded))
            Spacer()
            HStack {
                Text(entry.show ? entry.english : entry.kana)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .border(Color.gray)
            Spacer()
            HStack {
                Button(intent: MeaningIntent()) {
                    Text("Get meaning")
                }
                .tint(Color(red: 0.918, green: 0.467, blue: 0.467))
                Button(intent: VocabIntent()) {
                    Image(systemName: "arrowshape.right.fill")
                }
                .tint(Color(red: 0.918, green: 0.467, blue: 0.467))
            }
        }
        .containerBackground(Color(red: 0.851, green: 0.851, blue: 0.851), for: .widget)
    }
}

struct Widgets: Widget {
    let kind: String = "Widgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetsEntryView(entry: entry)
                .environment(\.colorScheme, .light)
        }
        .configurationDisplayName("My Widget")
        .description("Vocab Widget.")
    }
}

#Preview(as: .systemMedium) {
    Widgets()
} timeline: {
    SimpleEntry(date: .now , english: "test", kana: "test", show: true)
}

class WidgetVocab {
        
    private static let sharedDefaults: UserDefaults = UserDefaults(suiteName: "group.edu.psu.mks6942.NihonGo")!
    
    static func randomVocab() {
        
        let vocab = StorageManager<[Vocab]>(filePath: "vocab").modelData?.randomElement()
        sharedDefaults.set(vocab?.meaning, forKey: "english")
        sharedDefaults.set(vocab?.kana, forKey: "kana")
        sharedDefaults.set(false, forKey: "show")
    }
    
    static func getMeaning() {
        let show = !sharedDefaults.bool(forKey: "show")
        sharedDefaults.set(show, forKey: "show")
    }
    
    static func english() -> String {
        sharedDefaults.string(forKey: "english") ?? "None"
    }
    
    static func kana() -> String {
        sharedDefaults.string(forKey: "kana") ?? "None"
    }
    
    static func show() -> Bool {
        sharedDefaults.bool(forKey: "show")
    }
}

struct VocabIntent: AppIntent {
    static var title: LocalizedStringResource = "New vocab"
    static var description = IntentDescription("Pulls a new vocab term from app.")
    
    func perform() async throws -> some IntentResult {
        WidgetVocab.randomVocab()
        return .result()
    }
}

struct MeaningIntent: AppIntent {
    static var title: LocalizedStringResource = "Increment Count"
    static var description = IntentDescription("Increments a shared count with the main app.")
    
    func perform() async throws -> some IntentResult {
        WidgetVocab.getMeaning()
        return .result()
    }
}
