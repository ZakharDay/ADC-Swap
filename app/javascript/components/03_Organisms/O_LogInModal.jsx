import React from 'react'

import A_Button from '../01_Atoms/A_Button'
import A_Input from '../01_Atoms/A_Input'

import M_HeadingWithDescriptor from '../02_Molecules/M_HeadingWithDescriptor'

export default class O_LogInModal extends React.PureComponent {
  constructor(props) {
    super(props)

    this.state = {
      option: props.option
    }
  }

  render() {
    const { handleClose, value, handleChange } = this.props
    return (
      <div className="O_LogInModal">
        <div className="W_ModalWrapper">
          <div className="W_ModalContainer">
            <div className="closeButton" onClick={handleClose}></div>
            <div className="header">Вход по почте HSE</div>
            <A_Input
              value={value}
              type="withHeader"
              title="Почта hse"
              placeholder="Введи свою корпоративную почту"
              handleChange={handleChange}
            />
            <A_Button
              type="block"
              text="Далее"
              handleClick={() => console.log(lol)}
            />
          </div>
        </div>
      </div>
    )
  }
}
