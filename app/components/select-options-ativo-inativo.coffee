import Ember from 'ember'
import SelectOptions from './select-options'

SelectOptionsAtivoInativoComponent = SelectOptions.extend(

  templateName: "/components/select-options"

  arrayOpcoes: [
    {title:"Ativo", value:"ATIVO"}
    {title:"Inativo", value:"INATIVO"}
  ]

)

export default SelectOptionsAtivoInativoComponent
