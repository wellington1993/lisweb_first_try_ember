import Ember from 'ember'
import SelectOptions from './select-options'

SelectOptionsTipoPessoaComponent = SelectOptions.extend(

  templateName: "/components/select-options"

  arrayOpcoes: [
    {title:"Pessoa Física", value:"PF"}
    {title:"Pessoa Jurídica", value:"PJ"}
  ]

)

export default SelectOptionsTipoPessoaComponent
