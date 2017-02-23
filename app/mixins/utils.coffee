import Ember from 'ember'

UtilsMixin = Ember.Mixin.create(

  intForArray: (numInt) ->

    retorno = []

    if !numInt
      return retorno

    numInt  = parseInt(numInt)

    i = 1
    while i <= numInt
      retorno.push(i)
      i++

    return retorno

  validarCPF: (cpf) ->

    if !cpf
      return false

    cpf = new String(cpf)

    cpf = cpf.replace(/[^\d]+/g, '')
    if cpf == ''
      return false
    # Elimina CPFs invalidos conhecidos
    if cpf.length != 11 or cpf == '00000000000' or cpf == '11111111111' or cpf == '22222222222' or cpf == '33333333333' or cpf == '44444444444' or cpf == '55555555555' or cpf == '66666666666' or cpf == '77777777777' or cpf == '88888888888' or cpf == '99999999999'
      return false
    # Valida 1o digito
    add = 0
    i = 0
    while i < 9
      add += parseInt(cpf.charAt(i)) * (10 - i)
      i++
    rev = 11 - (add % 11)
    if rev == 10 or rev == 11
      rev = 0
    if rev != parseInt(cpf.charAt(9))
      return false
    # Valida 2o digito
    add = 0
    i = 0
    while i < 10
      add += parseInt(cpf.charAt(i)) * (11 - i)
      i++
    rev = 11 - (add % 11)
    if rev == 10 or rev == 11
      rev = 0
    if rev != parseInt(cpf.charAt(10))
      return false
    true

  validarCNPJ: (cnpj) ->

    if !cnpj
      return false

    cnpj = new String(cnpj).replace(/[^\d]+/g, '')

    if cnpj == ''
      return false
    if cnpj.length != 14
      return false
    # Elimina CNPJs invalidos conhecidos
    if cnpj == '00000000000000' or cnpj == '11111111111111' or cnpj == '22222222222222' or cnpj == '33333333333333' or cnpj == '44444444444444' or cnpj == '55555555555555' or cnpj == '66666666666666' or cnpj == '77777777777777' or cnpj == '88888888888888' or cnpj == '99999999999999'
      return false
    # Valida DVs
    tamanho = cnpj.length - 2
    numeros = cnpj.substring(0, tamanho)
    digitos = cnpj.substring(tamanho)
    soma = 0
    pos = tamanho - 7
    i = tamanho
    while i >= 1
      soma += numeros.charAt(tamanho - i) * pos--
      if pos < 2
        pos = 9
      i--
    resultado = if soma % 11 < 2 then 0 else 11 - (soma % 11)
    if resultado != parseInt(digitos.charAt(0))
      return false
    tamanho = tamanho + 1
    numeros = cnpj.substring(0, tamanho)
    soma = 0
    pos = tamanho - 7
    i = tamanho
    while i >= 1
      soma += numeros.charAt(tamanho - i) * pos--
      if pos < 2
        pos = 9
      i--
    resultado = if soma % 11 < 2 then 0 else 11 - (soma % 11)
    if resultado != parseInt(digitos.charAt(1))
      return false
    true

  validarTelefone: (telefone) ->

    if !telefone
      return false

    telefone = new String(telefone)

    length = telefone.length

    return (!isNaN(telefone) && length <= 11 && length > 9)

  validarCEP: (cep) ->

    if !cep
      return false

    cep = new String(cep)

    length = cep.length

    return (!isNaN(cep) && length == 8)

  validarEmail: (email) ->

    if !email
      return false

    email = new String(email)

    expressaoRegular = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
    expressaoRegular.test email


)

export default UtilsMixin
