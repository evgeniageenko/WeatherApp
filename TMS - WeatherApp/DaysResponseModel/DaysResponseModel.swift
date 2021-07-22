

import Foundation

struct DaysResponseModel : Codable {
	let city : City?
    let feelsLike: Feels_like?
	let cod : String?
	let message : Double?
	let cnt : Int?
	let list : [List]?
    let temp : Temp?
    let weather : Weather?

	enum CodingKeys: String, CodingKey {

		case city = "city"
        case feelsLike = "feelsLike"
		case cod = "cod"
		case message = "message"
		case cnt = "cnt"
		case list = "list"
        case temp = "temp"
        case weather = "weather"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		city = try? values.decodeIfPresent(City.self, forKey: .city)
        feelsLike = try? values.decodeIfPresent(Feels_like.self, forKey: .feelsLike)
		cod = try? values.decodeIfPresent(String.self, forKey: .cod)
		message = try? values.decodeIfPresent(Double.self, forKey: .message)
		cnt = try? values.decodeIfPresent(Int.self, forKey: .cnt)
		list = try? values.decodeIfPresent([List].self, forKey: .list)
        temp = try? values.decodeIfPresent(Temp.self, forKey: .temp)
        weather = try? values.decodeIfPresent(Weather.self, forKey: .weather)
	}

}
