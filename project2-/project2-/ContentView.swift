import SwiftUI



struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack {
            TextField("Enter City", text: $viewModel.city)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Get Weather") {
                
                
                
                viewModel.fetchWeather()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
            HStack{
                if let weatherData = viewModel.weatherData {
                    Text("Temperature: \(weatherData.main.temp, specifier: "%.2f") °C")
                    
                    Text("Description: \(weatherData.weather.first?.description ?? "N/A")")
                    
                    Text("Feels Like: \(String(format: "%.2f", viewModel.feelsLike ?? 0.0)) °C")
                    Text("Min Temperature: \(String(format: "%.2f", viewModel.tempMin)) °C")
                    Text("Max Temperature: \(String(format: "%.2f", viewModel.tempMax)) °C")
                    
                    
                    Text("Humidity: \(viewModel.humidity)%")
                    
                    AsyncImage(url:URL(string:"https://openweathermap.org/img/wn/10d@2x.png"))
                }
            }
        }
    }
}


import Foundation

class WeatherViewModel: ObservableObject {
    @Published var city = ""
    @Published var weatherData: WeatherData?
    
    private let networkManager = NetworkManager.shared

    func fetchWeather() {
        networkManager.fetchWeather(for: city) { result in
            switch result {
            case .success(let weatherData):
                DispatchQueue.main.async {
                    self.weatherData = weatherData
                }
            case .failure(let error):
                print("Error fetching weather data: \(error)")
            }
        }
    }

    var feelsLike: Double? {
        return weatherData?.main.feelsLike
    }

    var tempMin: Double {
        return weatherData?.main.tempMin ?? 0.0
    }

    var tempMax: Double {
        return weatherData?.main.tempMax ?? 0.0
    }

    var pressure: Double {
        return weatherData?.main.pressure ?? 0.0
    }

    var humidity: Int {
        return weatherData?.main.humidity ?? 0
    }

    var seaLevel: Double? {
        return weatherData?.main.seaLevel
    }

    var grndLevel: Double? {
        return weatherData?.main.grndLevel
    }

    var sunrise: Int {
        return weatherData?.sys.sunrise ?? 0
    }

    var sunset: Int {
        return weatherData?.sys.sunset ?? 0
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

