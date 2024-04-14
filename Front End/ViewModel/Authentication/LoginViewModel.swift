import Foundation

class LoginViewModel: ObservableObject, Observable{
    @Published var loggedIn = false
    @Published var token: String = ""
    @Published var error: String?

    // This function will be called to perform the login operation.
    func login(email: String, password: String) {
        let urlString = "http://35.246.81.166:8080/auth/login"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let loginDetails = ["email": "siris@gmail.com", "password": "Testpassword11hehe"]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: loginDetails, options: []) else {
            print("Failed to serialize login data to JSON")
            return
        }
        request.httpBody = httpBody

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error occurred during login: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }

            if let jsonString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self?.token = jsonString
                    self?.loggedIn = true
                }
            }
        }.resume()
    }
}
