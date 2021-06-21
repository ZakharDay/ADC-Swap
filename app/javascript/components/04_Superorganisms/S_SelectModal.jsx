import React from 'react'

import A_Button from '../01_Atoms/A_Button'
import A_SelectOption from '../01_Atoms/A_SelectOption'
import M_HeadingWithDescriptor from '../02_Molecules/M_HeadingWithDescriptor'

export default class S_SelectModal extends React.PureComponent {
  constructor(props) {
    super(props)

    this.state = {
      option: props.option
    }
  }

  changeOption = (option) => {
    this.setState({ option: option })
  }

  render() {
    const {
      type,
      heading,
      descriptor,
      buttonText,
      optionList,
      handleSubmit,
      field
    } = this.props

    const { option } = this.state

    let optionElements = []

    optionList.forEach((minor, i) => {
      let checked = false

      if (i === option.id - 1) {
        checked = true
      }

      optionElements.push(
        <A_SelectOption
          type={type}
          text={minor.name}
          checked={checked}
          handleClick={() => this.changeOption(minor)}
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
              handleClick={() => handleSubmit(field, this.state.option)}
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
