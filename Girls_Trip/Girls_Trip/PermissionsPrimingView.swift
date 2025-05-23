import SwiftUI

struct PermissionsPrimingView: View {
    var onGotItTapped: () -> Void

    var body: some View {
        ZStack {
            Color(red: 253/255, green: 223/255, blue: 170/255)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Spacer()

                Image("coconutDrink")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 30)

                Text("Certain permissions need to be granted to experience Girls Trip in full.")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Text("We'll just need 3 pieces of information to get started.")
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .foregroundColor(Color(red: 80/255, green: 80/255, blue: 80/255))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Spacer()

                Button(action: {
                    onGotItTapped()
                }) {
                    Text("Got it!")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10) // Slightly less rounded than previous buttons
                        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 50)
            }
        }
    }
}

// Preview
struct PermissionsPrimingView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionsPrimingView(onGotItTapped: {
            print("Preview: Got it tapped!")
        })
    }
}
