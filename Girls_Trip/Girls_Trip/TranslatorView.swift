import SwiftUI
import Translation // Import Apple's Translation framework

// --- Data Model for the Translator ---
// This class will handle the translation logic and be observed by our view.
@MainActor // Ensures UI updates happen on the main thread
class TranslatorEngine: ObservableObject {
    @Published var translatedText: String = ""
    
    // We keep track of the current translation task
    private var currentTranslationTask: Task<Void, Error>?

    func translate(text: String, from sourceLanguage: Locale, to targetLanguage: Locale) {
        // Cancel any previous, unfinished translation task to prevent old results from overwriting new ones
        currentTranslationTask?.cancel()

        // Don't translate empty text
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            self.translatedText = ""
            return
        }

        // Start a new translation task
//        currentTranslationTask = Task {
//            do {
//                // Define the translation request
//                let request = TranslationRequest(
//                    sourceLocale: sourceLanguage,
//                    targetLocale: targetLanguage,
//                    sourceText: text
//                )
//                
//                // Get the translation response
//                let response = try await TranslationSession.shared.translation(for: request)
//                
//                // Check if the task was cancelled while we were waiting
//                try Task.checkCancellation()
//
//                // Update our published property with the result
//                self.translatedText = response.targetText
//
//            } catch {
//                // Handle errors, like unsupported languages or cancellation
//                self.translatedText = "" // Clear text on error
//                print("Translation error: \(error.localizedDescription)")
//            }
//        }
    }
}


struct TranslatorView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            translatorHeader()
            TranslatorTabView()
        }
        .background(Color(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    @ViewBuilder
    private func translatorHeader() -> some View {
        // This view remains the same as before
        VStack(spacing: 8) {
            HStack {
                Button(action: { dismiss() }) {
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
    // This view remains the same as before
    var body: some View {
        TabView {
            TranslationInterfaceView()
                .tabItem { Label("Translation", systemImage: "character.bubble") }
            Text("Camera Translation (Not Implemented)")
                .tabItem { Label("Camera", systemImage: "camera") }
            Text("Conversation View (Not Implemented)")
                .tabItem { Label("Conversation", systemImage: "person.2") }
            Text("Favorites (Not Implemented)")
                .tabItem { Label("Favorites", systemImage: "star") }
        }
    }
}


struct TranslationInterfaceView: View {
    // ---- START: MODIFICATIONS FOR TRANSLATION ----
    @StateObject private var translator = TranslatorEngine() // Create an instance of our translator
    @State private var inputText: String = ""
    
    // Define the languages. Later, you can make these selectable.
    @State private var sourceLanguage = Locale(identifier: "en-US")
    @State private var targetLanguage = Locale(identifier: "es-ES")
    // ---- END: MODIFICATIONS FOR TRANSLATION ----
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack {
                    Text("Translate")
                        .font(.largeTitle).bold()
                    Spacer()
                    Button(action: {}) { Image(systemName: "ellipsis.circle").font(.title2) }
                }
                .padding()

                ZStack(alignment: .center) {
                    VStack(spacing: 2) {
                        LanguageCardView(
                            language: "English (US)",
                            text: $inputText, // Bind to our input text
                            placeholder: "Enter text"
                        )
                        LanguageCardView(
                            language: "Spanish (Spain)",
                            text: $translator.translatedText, // Bind to the output from our translator
                            placeholder: "Introducir texto",
                            isInput: false
                        )
                    }
                    
                    Button(action: {
                        // Swap languages
                        let temp = sourceLanguage
                        sourceLanguage = targetLanguage
                        targetLanguage = temp
                        // Also swap the text
                        let tempText = inputText
                        inputText = translator.translatedText
                        translator.translatedText = tempText
                    }) {
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
        // ---- START: MODIFICATIONS FOR TRANSLATION ----
        // This modifier watches for changes in `inputText` and triggers the translation
        .onChange(of: inputText) {
            translator.translate(
                text: inputText,
                from: sourceLanguage,
                to: targetLanguage
            )
        }
        // ---- END: MODIFICATIONS FOR TRANSLATION ----
    }
}


struct LanguageCardView: View {
    // This view remains largely the same, but now it correctly binds to the translator's output
    var language: String
    @Binding var text: String
    var placeholder: String
    var isInput: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: { /* TODO: Open language selector */ }) {
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
                            text.isEmpty ? Text(placeholder).font(.title).foregroundColor(.gray.opacity(0.5)).padding(.top, 8).padding(.leading, 5) : nil
                        )
                } else {
                    // This now displays the translated text from the binding
                    Text(text.isEmpty ? placeholder : text)
                        .font(.title)
                        .foregroundColor(text.isEmpty ? .gray.opacity(0.5) : .primary)
                        .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 200, alignment: .topLeading)
                        .padding(.top, 8).padding(.leading, 5)
                }
                Spacer()
                Button(action: { /* TODO: Microphone or Text-to-Speech action */ }) {
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

struct TranslatorView_Previews: PreviewProvider {
    static var previews: some View {
        TranslatorView()
    }
}
