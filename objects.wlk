class Villano{
	var ejercito = []
	var temperatura = 25
	var ejercito_temporal = []
	
	// PUNTO 1 //
	method nuevoMinion(){
		var minion = new Minion()
		minion.alimentar (5)
		minion.otorgarArma("rayo congelante",10)
		self.incorporar(minion)
	}
	
	method incorporar(minion){
		ejercito.add(minion)
	}
	
	// PUNTO 2 //
	
	method planificar(maldad){
		ejercito_temporal = maldad.filtrarMinions(ejercito)
	}
	method planificar(maldad,piramide){
		ejercito_temporal = maldad.filtrarMinions(ejercito,piramide)
	}
	method realizar(maldad){
		maldad.premiarMinions(ejercito_temporal)
	}

	// PUNTO 3 // 
	 method minionsInutiles(){
	 	var ejercito_temporal = ejercito
	 	ejercito_temporal.filter({x=>(x.participaciones()==0)})
	 	return ejercito_temporal
	 }
	 
	 method mejorMinion(){
	 	var ejercito_temporal = ejercito
	 	var masParticipaciones = (ejercito_temporal.map({x=>x.participaciones()})).max()
	 	return (self.minionMasParticipativo(masParticipaciones))
	 }
	 
	 method minionMasParticipativo(cant){
	 	var temporal = ejercito
	 	temporal.filter({x=>(x.participaciones() == cant)})
	 	return temporal
	 }
}

class Minion{
	var armas = []
	var potencias = []
	var property bananas = 0
	var property participaciones = 0
	
	method participar(){
		participaciones +=1
	}
	
	method tieneEstaArma(arma){
		return armas.contains(arma)
	}
	
	method alimentar(x){
		bananas += x
	}
	
	method otorgarArma(nombre,potencia){
		armas.add(nombre)
		potencias.add(potencia)
	}
	
	method esPeligroso(color){
		return (color.esPeligroso(armas))
	}
	
	method comer(){
		self.alimentar(-1)
	}
	
	method tomarSuero(color){
		color.tomarSuero(armas)
		bananas -=1
	}
	
	method nivelDeConcentracion (color){
		return (color.concentracion(self.armaMasPotente(),bananas))
	}
	
	method armaMasPotente(){
		return (potencias.max())
	}
	
	// COMPORTAMIENTO NUEVO PARA MINIONS VERDES //
	method tirarBananas(){
		if(self.esVerde()){
			bananas -=10
		}else{
			bananas -= 3
		}
	}
	
	/* 4b) así debería ser el metodo de tomar suero, no se cambia el tipo del minion una vez que es violeta
	
	 */
}

class Piramide{
	var property altura
}

class Suero{}
object Luna{}

object congelar{
	method filtrarMinions(ejercito){
		return (ejercito.filter({x=>((x.tieneEstaArma("rayo congelante"))and(x.nivelDeConcentracion() >= 500))}))
	}
	method premiarMinions(ejercitoFiltrado){
		if(ejercitoFiltrado.size() > 0){
			ejercitoFiltrado.forEach({x => x.alimentar(10)})
		}else{
			throw new Exception(message="no hay minions")
		}
	}
}

object robarPiramide{
	method filtrarMinions(ejercito,piramide){
		return (ejercito.filter({x=>((x.nivelDeConcentracion())>=(piramide.altura() / 2))}))
	}
	method premiarMinions(ejercitoFiltrado){
		if(ejercitoFiltrado.size() >0){
			ejercitoFiltrado.forEach({x=>x.alimentar(10)})
			ejercitoFiltrado.forEach({x=>x.participar()})
		}else{
			throw new Exception(message="no hay minions")
		}
	}
}

object robarLuna{
	method filtrarMinions(ejercito){
		return (ejercito.filter({x=>x.tieneEstaArma("rayo encogedor")}))
	}
	method premiarMinions(ejercitoFiltrado){
		if(ejercitoFiltrado.size() >0){
			ejercitoFiltrado.forEach({x=>x.otorgarArma("rayo congelante",10)})
			ejercitoFiltrado.forEach({x=>x.participar()})
		}else{
			throw new Exception(message="no hay minions")
		}
	}
}

object robarSuero{
	method filtrarMinions(ejercito){
		return (ejercito.filter({x=>((x.cantBananas()>=100)and((x.nivelDeConcentracion()) >=23))}))
	}
	method premiarMinions(ejercitoFiltrado){
		if(ejercitoFiltrado.size() >0){
			ejercitoFiltrado.forEach({x=>x.tomarSuero()})
			ejercitoFiltrado.forEach({x=>x.participar()})
		}else{
			throw new Exception(message="no hay minions")
		}
	}
}

object amarillo{
	method esPeligroso(armas){
		return (armas.size() > 2)
	}
	method concentracion(potencia,bananas){
		return (potencia+bananas)
	}
	method tomarSuero(armas){
		armas = []
	}
}
object violeta{
	method esPeligroso(armas){
		return true
	}
	method concentracion(potencia,bananas){
		return bananas
	}
	method tomarSuero(armas){}
}