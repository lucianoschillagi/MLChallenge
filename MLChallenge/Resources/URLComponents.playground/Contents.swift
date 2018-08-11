
//: Playground - noun: a place where people can play

import Foundation

// first callback
// https://api.mercadopago.com/v1/payment_methods?public_key=444a9ef5-8a6b-429f-abdf-587639155d88

var components = URLComponents()
components.scheme = "https"
components.host = "api.mercadopago.com"
components.path = "/v1/payment_methods"
components.queryItems = [URLQueryItem]()

let queryItem1 = URLQueryItem(name: "public_key", value: "444a9ef5-8a6b-429f-abdf-587639155d88")
//let queryItem2 = URLQueryItem(name: "api_key", value: "1234")
//let queryItem3 = URLQueryItem(name: "text", value: "purple")

components.queryItems!.append(queryItem1)
//components.queryItems!.append(queryItem2)
//components.queryItems!.append(queryItem3)

print(components.url!)
