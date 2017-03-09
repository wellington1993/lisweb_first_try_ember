import Ember from 'ember'

RequestsTipoProdutoMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  cadastrarTipoProduto: (context, options, callback = ->) ->
    return options["tipoProduto"].save()

  atualizarTipoProduto: (context, options, callback = ->) ->

    #Obtem o tipo do produto e seus relacionamentos que tiveram exclusao.
    tipoProduto              = options["tipoProduto"]
    produtosExcluidos        = options["produtosExcluidos"]
    fornecedoresExcluidos    = options["fornecedoresExcluidos"]
    unidadesEntradaExcluidos = options["unidadesEntradaExcluidos"]


    #Exclui cada fornecedor.
    fornecedoresExcluidos.forEach(
      (f) ->
        try
          f.get("produto.fornecedores").removeObject(f)
          f.destroyRecord()
        catch e
    )

    #Exclui cada unidade de medida.
    unidadesEntradaExcluidos.forEach(
      (u) ->
        try
          u.get("produto.unidadesMedidaEntrada").removeObject(u)
          u.destroyRecord()
        catch
    )

    #Exclui cada produto.
    produtosExcluidos.forEach(
      (p) ->
        try
          p.get("tipoProduto.produtos").removeObject(p)
          p.destroyRecord()
        catch
    )

    #Para cada produto do tipo de produto:
    tipoProduto.get("produtos").forEach(

      (p) ->

        #Se o produto não é novo:
        if !p.get("isNew")

          #Verifica se o produto tem novos fornecedores ou unidades de medida ou
          #se houve alguma alteraçao nos mesmos.
          ["unidadesMedidaEntrada", "fornecedores"].forEach(

            (hasManyName) ->

              p.get(hasManyName).forEach(
                (item) ->
                  if item.get("hasDirtyAttributes") || item.get("isNew")
                    item.save()
              )

          )

          #Se o produto foi alterado, salva o produto.
          if p.get("hasDirtyAttributes")
            p.save()

        #Se é um novo produto:
        else

          np = p

          #Salva o registro do produto.
          p.save().then(
            (sp) ->

              #Apos salvar salva cada unidade de medida e fornecedor vinculados.
              ["unidadesMedidaEntrada", "fornecedores"].forEach(

                (hasManyName) ->

                  recs.forEach(
                    (item) ->
                      item.save()
                  )

              )

            (err) ->
          )

    )
    
    return tipoProduto.save()

)

export default RequestsTipoProdutoMixin
