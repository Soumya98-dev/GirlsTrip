import SwiftUI

// MARK: — Data Model

struct Embassy: Identifiable {
    let id = UUID()
    let city: String
    let imageName: String
    let addressLines: [String]
    let phone: String
}

// MARK: — Embassies Screen

struct EmbassiesView: View {
    private let embassies: [Embassy] = [
        .init(
            city: "Mexico City",
            imageName: "mexico_city_embassy",
            addressLines: [
                "Paseo de la Reforma 305",
                "Colonia Cuauhtémoc",
                "06500 CDMX"
            ],
            phone: "(55) 5080-2000"
        ),
        .init(
            city: "Dominican Republic",
            imageName: "dominican_republic_embassy",
            addressLines: [
                "Av. República de Colombia #57",
                "Santo Domingo"
            ],
            phone: "(809) 567-7775"
        ),
        .init(
            city: "United Kingdom",
            imageName: "uk_embassy",
            addressLines: [
                "33 Nine Elms Lane",
                "London SW11 7US"
            ],
            phone: "[44] 20-7499-9000"
        ),
        .init(
            city: "Canada",
            imageName: "canada_embassy",
            addressLines: [
                "490 Sussex Drive",
                "Ottawa, Ontario, K1N 1G8, Canada"
            ],
            phone: "(613) 688-5335"
        ),
        .init(
            city: "Italy",
            imageName: "italy_embassy",
            addressLines: [
                "U.S. Embassy Rome",
                "Via Vittorio Veneto 121",
                "00187 Roma"
            ],
            phone: "+39 06.46741"
        ),
        .init(
            city: "France",
            imageName: "france_embassy",
            addressLines: [
                "2 avenue Gabriel",
                "75008 Paris, France",
                "Consular Services: 4 avenue Gabriel",
                "75008 Paris, France"
            ],
            phone: "+33 1 43 12 2222"
        )
    ]

    private let headerColor  = Color(red: 253/255, green: 223/255, blue: 170/255)
    private let buttonYellow = Color(red: 254/255, green: 228/255, blue: 154/255)

    var body: some View {
        VStack(spacing: 0) {
            header
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(embassies) { embassy in
                        EmbassyRow(embassy: embassy)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)

                viewMoreButton
                    .padding(.horizontal, 40)
                    .padding(.vertical, 30)
            }
            .background(Color(.systemBackground))
        }
        .edgesIgnoringSafeArea(.top)
    }

    private var header: some View {
        ZStack {
            headerColor
            VStack(spacing: 4) {
                Spacer()
                    .frame(height: safeAreaTop + 8)

                Text("US Embassies")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.black)

                Text("Most popular destinations")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Spacer()
            }
        }
        .frame(height: 140)
    }

    private var viewMoreButton: some View {
        Button(action: {
            // TODO: your action
        }) {
            Text("View more")
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(buttonYellow)
                .clipShape(Capsule())
        }
    }

    private var safeAreaTop: CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }
}

private struct EmbassyRow: View {
    let embassy: Embassy
    private let highlight = Color(red: 254/255, green: 228/255, blue: 154/255)

    var body: some View {
        HStack(spacing: 16) {
            Image(embassy.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(highlight, lineWidth: 3)
                )

            VStack(alignment: .leading, spacing: 6) {
                Text(embassy.city)
                    .font(.headline).bold()

                ForEach(embassy.addressLines, id: \.self) { line in
                    Text(line)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Text("Phone: \(embassy.phone)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            }
            Spacer()
        }
    }
}

struct EmbassiesView_Previews: PreviewProvider {
    static var previews: some View {
        EmbassiesView()
            .previewDevice("iPhone 14")
    }
}
