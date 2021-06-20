import React from 'react'

import A_Button from '../01_Atoms/A_Button'
import A_SelectOption from '../01_Atoms/A_SelectOption'
import M_HeadingWithDescriptor from '../02_Molecules/M_HeadingWithDescriptor'

export default class S_SelectModal extends React.PureComponent {
  constructor(props) {
    super(props)
  }

  render() {
    const {
      type,
      heading,
      descriptor,
      buttonText,
      optionList,
      handleSubmit
    } = this.props

    let optionElements = []

    optionList.forEach((name, i) => {
      let checked = false

      if (i === 3) {
        checked = true
      }

      optionElements.push(
        <A_SelectOption
          type={type}
          text={name}
          checked={checked}
          icon="unselect"
          handleClick={() => console.log('click')}
          key={i}
        />
      )
    })

    return (
      <div className="S_SelectModal">
        <div className="W_ModalWrapper">
          <div className="W_ModalContainer">
            <A_Button
              type="text"
              text={buttonText}
              handleClick={handleSubmit}
            />
            <M_HeadingWithDescriptor
              heading={heading}
              descriptor={descriptor}
            />

            <div className="C_SelectOptions">{optionElements}</div>
          </div>
        </div>
      </div>
    )
  }
}
