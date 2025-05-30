import SwiftUI

struct MoodboardItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let highlightColor: Color = Color(red: 255/255, green: 165/255, blue: 0/255)
}

struct SafetyHubItem: Identifiable {
    let id = UUID()
    let title: String
    let iconName: String
}

struct EmbassyInfo: Identifiable {
    let id = UUID()
    let city: String
    let imageName: String
    let address: String
    let phone: String
}

struct ContentView: View {
    let moodboards: [MoodboardItem] = [
        MoodboardItem(title: "Outfits", imageName: "outfits_moodboard"),
        MoodboardItem(title: "Food Moods", imageName: "food_moodboard"),
        MoodboardItem(title: "Packing lists", imageName: "packing_moodboard")
    ]

    let safetyHubItems: [SafetyHubItem] = [
        SafetyHubItem(title: "Embassies", iconName: "building.columns.fill"),
        SafetyHubItem(title: "Safe Areas", iconName: "heart.fill"),
        SafetyHubItem(title: "Passport Info", iconName: "doc.text.fill")
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    createMyTripSection()
                        .padding(.horizontal)

                    myMoodboardsSection()

                    safetyHubSection()

                    Spacer()
                }
                .padding(.vertical)
            }
            .background(Color(UIColor.systemGray6).edgesIgnoringSafeArea(.bottom))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Girls Trip")
                        .font(.largeTitle).bold()
                        .foregroundColor(Color(red: 255/255, green: 105/255, blue: 180/255))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 15) {
                        Button(action: { /* Notification action */ }) {
                            Image(systemName: "bell")
                                .font(.title2)
                        }
                        Button(action: { /* Menu action */ }) {
                            Image(systemName: "line.3.horizontal")
                                .font(.title2)
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
        }
    }

    @ViewBuilder
    private func createMyTripSection() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Create My Trip")
                .font(.title2).bold()

            Button(action: { /* Action for creating a trip */ }) {
                HStack {
                    Text("Upload your flight, lodging and activities.")
                        .font(.headline)
                        .foregroundColor(.primary.opacity(0.8))
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color(red: 255/255, green: 165/255, blue: 0/255))
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(red: 255/255, green: 165/255, blue: 0/255), lineWidth: 2)
                )
                .shadow(radius: 3)
            }
        }
    }

    @ViewBuilder
    private func myMoodboardsSection() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("My Moodboards")
                    .font(.title2).bold()
                Spacer()
                Button("View all >") { /* Action for viewing all moodboards */ }
                    .font(.callout)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(moodboards) { item in
                        MoodboardCardView(item: item)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
            }
        }
    }

    @ViewBuilder
    private func safetyHubSection() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Safety Hub")
                    .font(.title2).bold()
                Spacer()
                Button("View all >") { /* Action for viewing all safety items */ }
                    .font(.callout)
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(safetyHubItems) { item in
                        if item.title == "Embassies" {
                            NavigationLink(destination: EmbassiesView()) {
                                SafetyHubCardView(item: item)
                            }
                            .buttonStyle(PlainButtonStyle())
                        } else {
                            SafetyHubCardView(item: item)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
            }
        }
    }
}

struct MoodboardCardView: View {
    let item: MoodboardItem

    var body: some View {
        VStack(alignment: .leading) {
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 200)
                .overlay(
                    VStack {
                        Spacer()
                        HStack {
                            item.highlightColor
                                .frame(width: 75, height: 60)
                                .clipShape(RoundedCorner(radius: 20, corners: [.topRight, .bottomRight]))
                                .opacity(0.8)
                            Spacer()
                        }
                    }
                )
                .cornerRadius(12)

            Text(item.title)
                .font(.headline)
                .padding(.top, 5)
        }
        .frame(width: 150)
        .padding(8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct SafetyHubCardView: View {
    let item: SafetyHubItem

    var body: some View {
        VStack {
            Image(systemName: item.iconName)
                .font(.system(size: 40))
                .foregroundColor(.primary)
                .padding(.bottom, 8)
                .frame(width: 60, height: 60)

            Text(item.title)
                .font(.caption).bold()
                .multilineTextAlignment(.center)
        }
        .frame(width: 100, height: 100)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 1)
    }
}


struct EmbassiesView: View {
    let embassies: [EmbassyInfo] = [
        EmbassyInfo(city: "Mexico City", imageName: "mexico_city_embassy", address: "Paseo de la Reforma 305\nColonia Cuauhtémoc\n06500 CDMX", phone: "(55) 5080-2000"),
        EmbassyInfo(city: "Dominican Republic", imageName: "dominican_republic_embassy", address: "Av. República de Colombia #57\nSanto Domingo\nDominican Republic", phone: "(809) 567-7775"),
        EmbassyInfo(city: "United Kingdom", imageName: "uk_embassy", address: "33 Nine Elms Lane\nLondon\nSW11 7US", phone: "[44] (0)20-7499-9000"),
        EmbassyInfo(city: "Canada", imageName: "canada_embassy", address: "490 Sussex Drive\nOttawa, Ontario, K1N 1G8,\nCANADA", phone: "(613) 688-5335"),
        EmbassyInfo(city: "Italy", imageName: "italy_embassy", address: "U.S. Embassy Rome\nVia Vittorio Veneto 121\n00187 Roma", phone: "+39 06.46741"),
        EmbassyInfo(city: "France", imageName: "france_embassy", address: "2 avenue Gabriel\n75008 Paris, France\n\nConsular Services:\n4 avenue Gabriel\n75008 Paris, France", phone: "+33 143122222")
    ]
    
    let placeholderEmbassyImageName = "building.fill"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("US Embassies")
                    .font(.title2).bold()
                    .padding(.horizontal)
                Text("Most Popular destinations")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.bottom, 5)

                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(embassies) { embassy in
                        EmbassyRow(embassy: embassy, placeholderImageName: placeholderEmbassyImageName)
                        if embassy.id != embassies.last?.id {
                            Divider().padding(.leading, 111)
                        }
                    }
                }
                
                Button(action: {
                    print("View more destinations tapped")
                }) {
                    HStack {
                        Spacer()
                        (Text("Don't see your destination? ")
                            .font(.callout)
                            .foregroundColor(Color(UIColor.label))
                        + Text("View more")
                            .font(.callout).bold()
                            .foregroundColor(Color(red: 255/255, green: 135/255, blue: 0/255)))
                        Spacer()
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
            }
            .padding(.top)
        }
        .navigationTitle("Embassies")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
    }
}

struct EmbassyRow: View {
    let embassy: EmbassyInfo
    let placeholderImageName: String

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(uiImage: UIImage(named: embassy.imageName) ?? UIImage(systemName: placeholderImageName)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text(embassy.city)
                    .font(.headline).bold()
                Text(embassy.address)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                Text("Phone: \(embassy.phone)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
    }
}


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct EmbassiesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmbassiesView()
        }
    }
}
