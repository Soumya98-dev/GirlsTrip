import SwiftUI

struct ProfileSetupView: View {
    private enum Field: Hashable {
        case firstName, emergencyName, emergencyPhone, passportNumber
    }

    // MARK: — Form fields
    @State private var firstName: String = ""
    @State private var emergencyName: String = ""
    @State private var emergencyPhone: String = ""
    @State private var passportNumber: String = ""

    // MARK: — Keyboard focus
    @FocusState private var focusedField: Field?

    // MARK: — Flow control flag (once true, AppFlowView will advance)
    @AppStorage("hasCompletedProfileSetup") private var hasCompletedProfileSetup: Bool = false

    var body: some View {
        ZStack {
            // Background
            Color(red: 253/255, green: 223/255, blue: 170/255)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture { focusedField = nil }

            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    Text("Profile")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .padding(.top, 20)

                    HStack(spacing: 20) {
                        Text("🥥").font(.largeTitle)
                        Text("🏝️").font(.largeTitle)
                        Text("☀️").font(.largeTitle)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 20)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your name").font(.headline)
                        TextField("First name", text: $firstName)
                            .styled()
                            .focused($focusedField, equals: .firstName)
                            .overlay(
                                Capsule()
                                    .stroke(focusedField == .firstName ? Color.orange : .clear, lineWidth: 2)
                            )
                    }

                    // Emergency contact fields
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Emergency contact").font(.headline)
                        TextField("First name", text: $emergencyName)
                            .styled()
                            .focused($focusedField, equals: .emergencyName)
                        TextField("Phone number", text: $emergencyPhone)
                            .styled()
                            .keyboardType(.phonePad)
                            .focused($focusedField, equals: .emergencyPhone)
                    }

                    // Passport number field
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Passport number").font(.headline)
                            Text("(You can add this later)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        TextField("Passport number", text: $passportNumber)
                            .styled()
                            .focused($focusedField, equals: .passportNumber)
                    }

                    Spacer()
                }
                .padding(.horizontal, 30)
            }

            VStack {
                Spacer()
                Button("Next") {
                    hasCompletedProfileSetup = true
                }
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(Capsule())
                .shadow(radius: 5)
                .padding(.horizontal, 50)
                .padding(.bottom, 40)
            }
        }
        .onAppear { focusedField = .firstName }
    }
}

// MARK: — TextField Styling

extension View {
    func styled() -> some View {
        modifier(StyledTextField())
    }
}

struct StyledTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .clipShape(Capsule())
            .overlay(
                Capsule().stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
    }
}

// MARK: — Preview

struct ProfileSetupView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSetupView()
    }
}
