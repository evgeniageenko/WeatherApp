

import Foundation
struct List : Codable {
	let dt : Int?
	let sunrise : Int?
	let sunset : Int?
	let temp : Temp?
	let feels_like : Feels_like?
	let pressure : Int?
	let humidity : Int?
	let weather : [Weather]?
	let speed : Double?
	let deg : Int?
	let gust : Double?
	let clouds : Int?
	let pop : Double?

	enum CodingKeys: String, CodingKey {

		case dt = "dt"
		case sunrise = "sunrise"
		case sunset = "sunset"
		case temp = "temp"
		case feels_like = "feels_like"
		case pressure = "pressure"
		case humidity = "humidity"
		case weather = "weather"
		case speed = "speed"
		case deg = "deg"
		case gust = "gust"
		case clouds = "clouds"
		case pop = "pop"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dt = try? values.decodeIfPresent(Int.self, forKey: .dt)
		sunrise = try? values.decodeIfPresent(Int.self, forKey: .sunrise)
		sunset = try? values.decodeIfPresent(Int.self, forKey: .sunset)
		temp = try? values.decodeIfPresent(Temp.self, forKey: .temp)
		feels_like = try? values.decodeIfPresent(Feels_like.self, forKey: .feels_like)
		pressure = try? values.decodeIfPresent(Int.self, forKey: .pressure)
		humidity = try? values.decodeIfPresent(Int.self, forKey: .humidity)
		weather = try? values.decodeIfPresent([Weather].self, forKey: .weather)
		speed = try? values.decodeIfPresent(Double.self, forKey: .speed)
		deg = try? values.decodeIfPresent(Int.self, forKey: .deg)
		gust = try? values.decodeIfPresent(Double.self, forKey: .gust)
		clouds = try? values.decodeIfPresent(Int.self, forKey: .clouds)
		pop = try? values.decodeIfPresent(Double.self, forKey: .pop)
	}

}
