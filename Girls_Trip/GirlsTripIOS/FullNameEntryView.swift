import SwiftUI

struct FullNameEntryView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""

    var onNextTapped: (_ firstName: String, _ lastName: String) -> Void

    var body: some View {
        ZStack {
            Color(red: 253/255, green: 223/255, blue: 170/255)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Spacer()

                Image("plumeriaFlower")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 30)

                Text("Enter your full name")
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255))
                    .padding(.bottom, 10)

                VStack(spacing: 15) {
                    TextField("First name", text: $firstName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .font(.system(size: 18))
                        .textContentType(.givenName)

                    TextField("Last name", text: $lastName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .font(.system(size: 18))
                        .textContentType(.familyName)
                }
                .padding(.horizontal, 40)

                Spacer()

                Button(action: {
                    if !firstName.isEmpty && !lastName.isEmpty {
                        onNextTapped(firstName, lastName)
                    } else {
                        print("First name or last name is empty")
                    }
                }) {
                    Text("Next")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 50) // Space from bottom edge
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// Preview
struct FullNameEntryView_Previews: PreviewProvider {
    static var previews: some View {
        FullNameEntryView { firstName, lastName in
            print("Preview: Next tapped with First Name: \(firstName), Last Name: \(lastName)")
        }
    }
}
