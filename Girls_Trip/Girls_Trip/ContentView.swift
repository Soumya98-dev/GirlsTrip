import SwiftUI

// MARK: — Data Models

struct MoodboardItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

struct SafetyHubItem: Identifiable {
    let id = UUID()
    let title: String
    let iconName: String
}

// MARK: — Main ContentView with TabView

struct ContentView: View {
    @State private var selectedTab = 0

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground

        let selectedColor = UIColor(red: 255/255, green: 105/255, blue: 180/255, alpha: 1)
        appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]

        let normalColor = UIColor.gray
        appearance.stackedLayoutAppearance.normal.iconColor = normalColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: normalColor]

        UITabBar.appearance().standardAppearance    = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: selectedTab == 0 ? "house.fill" : "house")
                }
                .tag(0)

            Text("#OOTD Screen")
                .tabItem { Label("#OOTD", systemImage: "camera") }
                .tag(1)

            Text("Import Screen")
                .tabItem { Label("Import", systemImage: "square.and.arrow.down") }
                .tag(2)

            Text("Map Screen")
                .tabItem { Label("Map", systemImage: "paperplane") }
                .tag(3)

            Text("Profile Screen")
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
                .tag(4)
        }
    }
}

// MARK: — Home Screen

struct HomeView: View {
    @State private var searchText = ""

    private let moodboards = [
        MoodboardItem(title: "Outfits",       imageName: "outfits_moodboard"),
        MoodboardItem(title: "Food Moods",    imageName: "food_moodboard"),
        MoodboardItem(title: "Packing lists", imageName: "packing_moodboard")
    ]

    private let safetyItems = [
        SafetyHubItem(title: "Embassies",       iconName: "building.columns"),
        SafetyHubItem(title: "STEP Enrollment", iconName: "doc.text"),
        SafetyHubItem(title: "Translator",      iconName: "message")
    ]

    private let btnYellow     = Color(red: 254/255, green: 228/255, blue: 154/255)
    private let bgColor       = Color(UIColor.systemGray6)
    private let navBarBG      = Color.white.opacity(0.8)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    searchBar
                    createTripCard
                    moodboardsSection
                    safetyHubSection
                }
                .padding(.top)
                .padding(.bottom, 40)
            }
            .background(bgColor)
            .ignoresSafeArea(edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("gtverticallogo")
                        .resizable()
                        .renderingMode(.original)
                        .scaledToFit()
                        .frame(height: 32)
                        .accessibilityLabel("Girls Trip")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { /* TODO */ } label: {
                        Image(systemName: "bell")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                }
            }
            .toolbarBackground(navBarBG, for: .navigationBar)
            .toolbarBackground(.visible,  for: .navigationBar)
        }
    }

    // MARK: — Subviews

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.gray)
            TextField("Search my trips", text: $searchText)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal)
    }

    private var createTripCard: some View {
        VStack(spacing: 16) {
            Text("Create your first trip by uploading flight, lodging and activity info.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Create a trip") { /* TODO */ }
                .font(.headline)
                .foregroundColor(.black.opacity(0.8))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(btnYellow)
                .cornerRadius(10)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                .foregroundColor(btnYellow.opacity(0.9))
        )
        .padding(.horizontal)
    }

    private var moodboardsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Moodboards").font(.title2).bold()
                Spacer()
                Button("View all") {}
                Image(systemName: "chevron.right")
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(moodboards) { item in
                        VStack(alignment: .leading, spacing: 8) {
                            Image(item.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 140, height: 180)
                                .cornerRadius(12)
                            Text(item.title)
                                .font(.headline)
                                .fontWeight(.medium)
                        }
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
            }
        }
    }

    private var safetyHubSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Safety Hub").font(.title2).bold()
                Spacer()
                Button("View all") {}
                Image(systemName: "chevron.right")
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(safetyItems) { item in
                        switch item.title {
                        case "Embassies":
                            NavigationLink(destination: EmbassiesView()) {
                                safetyCard(for: item)
                            }
                            .buttonStyle(.plain)

                        case "STEP Enrollment":
                            NavigationLink(destination: STEPEnrollmentView()) {
                                safetyCard(for: item)
                            }
                            .buttonStyle(.plain)

                        case "Translator":
                            NavigationLink(destination: TranslatorView()) {
                                safetyCard(for: item)
                            }
                            .buttonStyle(.plain)

                        default:
                            safetyCard(for: item)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
            }
        }
    }

    @ViewBuilder
    private func safetyCard(for item: SafetyHubItem) -> some View {
        VStack(spacing: 8) {
            Image(systemName: item.iconName)
                .font(.system(size: 32))
                .foregroundColor(.black.opacity(0.7))
            Text(item.title)
                .font(.caption)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
        .frame(width: 100, height: 100)
        .background(Color.white)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

// MARK: — Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
