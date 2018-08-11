//
//  RecommendMessage.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 08/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Model */

import Foundation

/*
Abstract: Un objeto que almacena los datos recibidos por el JSON 'recommend_message' para luego usarlos en la construcción del ´alert view´ a mostrar como fin del proceso en la pantalla inicial.
*/

struct RecommendMessage {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	// la cantidad de cuotas elegidas por el usuario
	let cantidadCuotas: Int // DATOS PROVISTO POR EL USUARIO 👈
	// el monto calculado de cada cuota
	let montoCadaCuota: Double // DATOS PROVISTO POR LA API 👈
	// el total calculado del pago a realizar
	let total: Double // DATOS PROVISTO POR LA API 👈
	
	
	
	
	
}
