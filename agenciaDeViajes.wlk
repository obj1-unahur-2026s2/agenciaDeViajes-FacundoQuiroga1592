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


object acompanianter {
  
  method cumpleCondicionSegunRol(coordinador) = true
}



class Coordinador {
  
  var viajesRealizados
  var estaMotivado
  const aniosDeExperiencia
  var rol

  
  const rolesValidos = #{guia, asistenteLogistico, acompanianter}


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

}