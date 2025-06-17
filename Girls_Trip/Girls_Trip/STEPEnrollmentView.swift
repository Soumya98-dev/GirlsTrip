import SwiftUI

// MARK: — STEP Enrollment Screen

struct STEPEnrollmentView: View {
    @Environment(\.dismiss) private var dismiss

    private let headerColor    = Color(red: 253/255, green: 223/255, blue: 170/255)
    private let bodyBackground = Color(.systemBackground)

    var body: some View {
        VStack(spacing: 0) {
            header

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    sectionTitle("What is STEP?")
                    sectionBody("""
                    STEP is a free U.S. government service that registers your travel plans with the nearest embassy.  
                    This aids in finding and assisting you during emergencies abroad.
                    """)

                    sectionTitle("Why Use STEP?")
                    sectionBody("""
                    • Embassy can contact you in emergencies  
                    • Get safety alerts for your destination  
                    • Faster help when you need it  
                    • Family gets updates during crises
                    """)

                    sectionTitle("How to Enroll?")
                    sectionBody("""
                    1. Visit travel.state.gov/step  
                    2. Enter travel dates and destination  
                    3. Add your contact info  
                    4. Submit enrollment
                    """)

                    // repeated per screenshot
                    sectionTitle("How to Enroll?")
                    sectionBody("""
                    • Enroll 2 weeks before travel  
                    • Update if plans change  
                    • Free for all U.S. citizens
                    """)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                Spacer(minLength: 40)
            }
            .background(bodyBackground)
        }
        .edgesIgnoringSafeArea(.top)
    }

    // MARK: — Header (no back arrow)

    private var header: some View {
        ZStack {
            headerColor
            VStack(spacing: 4) {
                Spacer()
                    .frame(height: safeAreaTop + 8)

                Text("Enroll in STEP")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.black)

                Text("All things safety is at your fingertips")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Spacer()
            }
        }
        .frame(height: 140)
        .clipShape(RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight]))
    }

    // MARK: — Helpers

    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.primary)
    }

    private func sectionBody(_ text: String) -> some View {
        Text(text)
            .font(.body)
            .foregroundColor(.primary)
            .fixedSize(horizontal: false, vertical: true)
    }

    private var safeAreaTop: CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }
}

// MARK: — RoundedCorner Shape for selective corner rounding

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: — Preview

struct STEPEnrollmentView_Previews: PreviewProvider {
    static var previews: some View {
        STEPEnrollmentView()
            .previewDevice("iPhone 14")
    }
}
