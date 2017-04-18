import Ember from 'ember'

RequestsGrupoParametroNFSeMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  cadastrarGrupoParametroNFSe: (context, options, callback = ->) ->
    return options["grupoParametroNFSe"].save()

  atualizarGrupoParametroNFSe: (context, options, callback = ->) ->

    #Obtem o grupo de parâmetro e seus relacionamentos que tiveram exclusao.
    grupoParametroNFSe       = options["grupoParametroNFSe"]
    gruposParametrosChavesNFSeExcluidos = options["gruposParametrosChavesNFSeExcluidos"]

    #Exclui cada parametro
    gruposParametrosChavesNFSeExcluidos.forEach(
      (u) ->
        try
          u.deleteRecord()
        catch
    )

    #Para cada grupo de parametro:
    grupoParametroNFSe.get("gruposParametrosChavesNFSe").forEach(

      (p) ->

        #Se o grupo parametro chave nfse não é novo:
        if !p.get("isNew")

          #Se o grupo de parametro foi alterado, salva
          if p.get("hasDirtyAttributes")
            p.save()

        #Se é um novo grupo de parametro:
        else
          #Salva o registro do grupo de parametro
          p.save().then(
            (sp) ->
            (err) ->
          )

    )

    return grupoParametroNFSe.save()

)

export default RequestsGrupoParametroNFSeMixin
