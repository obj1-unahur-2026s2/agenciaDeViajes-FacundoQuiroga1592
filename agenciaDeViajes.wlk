class Beneficio {
  
  const tipo
  const costo
  var vigente = true

  
  method tipo() = tipo
 
  
  method vigente() = vigente


  method vigente(unEstado) {
    vigente = unEstado
  }
}


object guia {
  
  method cumpleCondicionSegunRol(coordinador) = coordinador.estaMotivado()
}


object asistenteLogistico {
  
  method cumpleCondicionSegunRol(coordinador) = coordinador.aniosDeExperiencia() >= 3
}


object acompaniante {
  
  method cumpleCondicionSegunRol(coordinador) = true
}



class Coordinador {
  
  var viajesRealizados
  var estaMotivado
  const aniosDeExperiencia
  var rol

  
  const rolesValidos = #{guia, asistenteLogistico, acompaniante}


  method initialize() {
    self.validarRol(rol)
  }

  
  method validarRol(unRol) {
    if (!rolesValidos.contains(unRol)) {
      throw new DomainException(message = "El rol asignado no es válido")
    }
  }

  
  method viajesRealizados() = viajesRealizados
  method estaMotivado() = estaMotivado
  method aniosDeExperiencia() = aniosDeExperiencia
  method rol() = rol

 
  method viajesRealizados(cantidad) {
    viajesRealizados = cantidad
  }

  method estaMotivado(unEstado) {
    estaMotivado = unEstado
  }

 
  method rol(nuevoRol) {
    self.validarRol(nuevoRol)
    rol = nuevoRol
  }

 
  method esAltamenteCalificado() =
    viajesRealizados > 20 and rol.cumpleCondicionSegunRol(self)
}


class Pack {
  
  const duracionEnDias
  const precioBase
  const beneficios = [] 
  const coordinador


  method duracionEnDias() = duracionEnDias
  method precioBase() = precioBase
  method beneficios() = beneficios
  method coordinador() = coordinador

  
  method costoBeneficiosVigentes() =
    beneficios.filter({ b => b.vigente() }).sum({ b => b.costo() })

  
  method totalSinRecargos() = precioBase + self.costoBeneficiosVigentes()

  
  method valorFinal() = self.totalSinRecargos()

  
  method esPremium()
}


class PackNacional inherits Pack {
  
  const provinciaDestino
  const actividades = []

 
  method provinciaDestino() = provinciaDestino
  method actividades() = actividades


  override method esPremium() =
    duracionEnDias > 10 and coordinador.esAltamenteCalificado()
}


class PackInternacional inherits Pack {
  
  const paisDestino
  const escalas
  const esLugarDeInteres

 
  method paisDestino() = paisDestino
  method escalas() = escalas
  method esLugarDeInteres() = esLugarDeInteres

 
  override method valorFinal() = super() * 1.2

  
  override method esPremium() =
    esLugarDeInteres and duracionEnDias > 20 and escalas == 0
}



class PackProvincial inherits PackNacional {
  
  const ciudadesAVisitar

 
  method ciudadesAVisitar() = ciudadesAVisitar

  
  override method esPremium() =
    actividades.size() >= 4 and
    ciudadesAVisitar > 5 and
    beneficios.count({ b => b.vigente() }) >= 3

  
  override method valorFinal() {
    const total = super()
    return if (self.esPremium()) total * 1.05 else total
  }
}