import SwiftUI
import Translation   // iOS 18+

struct TranslatorView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            header
            TranslatorTabView()
        }
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarHidden(true)
    }

    private var header: some View {
        VStack(spacing: 8) {
            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)

            Text("Translator")
                .font(.system(size: 32, weight: .bold, design: .rounded))
            Text("Communicate around the world with confidence")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(.black.opacity(0.7))
                .padding(.bottom)
        }
        .frame(maxWidth: .infinity)
        .background(Color(red: 253/255, green: 223/255, blue: 170/255))
    }
}

struct TranslatorTabView: View {
    var body: some View {
        TabView {
            TranslationInterfaceView()
                .tabItem { Label("Translation", systemImage: "character.bubble") }

            PhotoCaptureView()
                .tabItem { Label("Camera", systemImage: "camera") }

            Text("Conversation View (Not Implemented)")
                .tabItem { Label("Conversation", systemImage: "person.2") }

            Text("Favorites (Not Implemented)")
                .tabItem { Label("Favorites", systemImage: "star") }
        }
    }
}

struct TranslationInterfaceView: View {
    @State private var inputText = ""
    @State private var translatedText = ""

    @State private var sourceLang = Locale.Language(languageCode: "en", region: "US")
    @State private var targetLang = Locale.Language(languageCode: "es", region: "ES")

    @State private var config: TranslationSession.Configuration?

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack {
                    Text("Translate")
                        .font(.largeTitle).bold()
                    Spacer()
                    Button { /* options */ } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.title2)
                    }
                }
                .padding()

                ZStack(alignment: .center) {
                    VStack(spacing: 2) {
                        LanguageCardView(
                            language: "English (US)",
                            text: $inputText,
                            placeholder: "Enter text"
                        )
                        LanguageCardView(
                            language: "Spanish (Spain)",
                            text: $translatedText,
                            placeholder: "Introducir texto",
                            isInput: false
                        )
                    }

                    Button {
                        swap(&sourceLang, &targetLang)
                        let tmp = inputText
                        inputText = translatedText
                        translatedText = tmp
                        config?.invalidate()
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.blue)
                            .padding(10)
                            .background(.regularMaterial)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                    .offset(y: -1)
                }
                .padding(.horizontal)
            }
        }
        .background(Color(UIColor.systemGray6))
        .onChange(of: inputText) { _ in
            config?.invalidate()
        }
        .onAppear {
            config = TranslationSession.Configuration(
                source: sourceLang,
                target: targetLang
            )
        }
        .translationTask(config) { session in
            let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmed.isEmpty else { return }

            do {
                let response = try await session.translate(trimmed)
                translatedText = response.targetText
            } catch {
                print("Translation failed:", error.localizedDescription)
            }
        }
    }
}

struct LanguageCardView: View {
    let language: String
    @Binding var text: String
    let placeholder: String
    var isInput: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button { /* TODO: show language picker */ } label: {
                HStack {
                    Text(language)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .padding([.horizontal, .top])

            HStack(alignment: .top) {
                if isInput {
                    TextEditor(text: $text)
                        .font(.title)
                        .frame(minHeight: 100, maxHeight: 200)
                        .background(
                            Group {
                                if text.isEmpty {
                                    Text(placeholder)
                                        .font(.title)
                                        .foregroundColor(.gray.opacity(0.5))
                                        .padding(.top, 8)
                                        .padding(.leading, 5)
                                }
                            }
                        )
                } else {
                    Text(text.isEmpty ? placeholder : text)
                        .font(.title)
                        .foregroundColor(text.isEmpty ? .gray.opacity(0.5) : .primary)
                        .frame(maxWidth: .infinity,
                               minHeight: 100, maxHeight: 200,
                               alignment: .topLeading)
                        .padding(.top, 8)
                        .padding(.leading, 5)
                }

                Spacer()

                Button { /* TODO: mic / TTS */ } label: {
                    Image(systemName: "mic.fill")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .padding(.trailing)
                .padding(.top, 8)
            }
        }
        .background(.background)
        .cornerRadius(12)
    }
}

// MARK: — Preview

struct TranslatorView_Previews: PreviewProvider {
    static var previews: some View {
        TranslatorView()
    }
}
