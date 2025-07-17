//
//  ForcastManager.swift
//  StormChaser
//
//  Created by Tung on 16/7/2025.
//

import Foundation

class ForecastManager {
    static let shared = ForecastManager()
    
    private let baseUrl = "https://api.open-meteo.com/v1"

    private init() {}

    func fetchWeatherForecast(latitude: Double, longitude: Double, completion: @escaping ([WeatherData]?) -> Void) {
        let urlString = "\(baseUrl)/forecast?latitude=\(latitude)&longitude=\(longitude)&daily=temperature_2m_max,temperature_2m_min,apparent_temperature_max,windspeed_10m_max,windgusts_10m_max,precipitation_sum,weathercode&timezone=auto"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    do {
                        let forecast = try JSONDecoder().decode(ForecastResponseData.self, from: data)
                        var weatherList: [WeatherData] = []

                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"

                        let weekdayFormatter = DateFormatter()
                        weekdayFormatter.dateFormat = "EEE"

                        for i in 0..<forecast.daily.time.count {
                            if let date = dateFormatter.date(from: forecast.daily.time[i]) {
                                let day = weekdayFormatter.string(from: date).uppercased()
                                let maxTemp = Int(forecast.daily.temperature_2m_max[i])
                                let minTemp = Int(forecast.daily.temperature_2m_min[i])
                                let realFeel = Int(forecast.daily.apparent_temperature_max[i])
                                let wind = forecast.daily.windspeed_10m_max[i]
                                let gust = forecast.daily.windgusts_10m_max[i]
                                let rain = forecast.daily.precipitation_sum[i]
                                let code = forecast.daily.weathercode[i]

                                weatherList.append(
                                    WeatherData(
                                        timezone: forecast.timezone,
                                        dayOfWeek: day,
                                        temperatureMax: maxTemp,
                                        temperatureMin: minTemp,
                                        weatherCode: code,
                                        apparentTemperature: realFeel,
                                        windSpeed: wind,
                                        windGust: gust,
                                        precipitation: rain,
                                        dateString: forecast.daily.time[i]
                                    )
                                )
                            }
                        }

                        DispatchQueue.main.async {
                            completion(weatherList)
                        }

                    } catch {
                        print("Decoding error: \(error)")
                        DispatchQueue.main.async { completion(nil) }
                    }
                } else if let error = error {
                    print("Network error: \(error)")
                    DispatchQueue.main.async { completion(nil) }
                }
            }.resume()
    }
    
    func fetchStormDetails(latitude: Double, longitude: Double, completion: @escaping ([StormDetailData]?) -> Void) {
        let urlString = "\(baseUrl)/forecast?latitude=\(latitude)&longitude=\(longitude)&hourly=windspeed_10m,precipitation&timezone=auto"

        guard let url = URL(string: urlString) else {
            print("Invalid storm detail URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(StormDetailResponse.self, from: data)
                    var details: [StormDetailData] = []

                    for i in 0..<decoded.hourly.time.count {
                        let time = decoded.hourly.time[i]
                        let wind = decoded.hourly.windspeed_10m[i]
                        let rain = decoded.hourly.precipitation[i]

                        details.append(StormDetailData(time: time, windSpeed: wind, precipitation: rain))
                    }

                    DispatchQueue.main.async {
                        completion(details)
                    }

                } catch {
                    print("Storm detail decoding error: \(error)")
                    DispatchQueue.main.async { completion(nil) }
                }
            } else if let error = error {
                print("Storm detail network error: \(error)")
                DispatchQueue.main.async { completion(nil) }
            }
        }.resume()
    }
}
