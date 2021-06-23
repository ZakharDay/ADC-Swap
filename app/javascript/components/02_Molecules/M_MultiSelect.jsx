import classnames from 'classnames'
import React from 'react'

import A_Text from '../01_Atoms/A_Text'

export default class M_MultiSelect extends React.PureComponent {
  constructor(props) {
    super(props)

    this.state = {
      placeholder: props.placeholder
    }
  }

  action = () => {
    const { isActive, handleClick } = this.props
    console.log(isActive)
    if (isActive) {
      return handleClick()
    } else {
      this.setState({ placeholder: 'Ошибка' })
    }
  }

  render() {
    const { label, value, icon } = this.props
    const { placeholder } = this.state
    let text = placeholder

    const classes = classnames({
      M_MultiSelect: true,
      [`${icon}`]: true
    })

    return (
      <div className={classes} onClick={this.action}>
        <A_Text text={label} type="formFieldLabel" />
        <A_Text text={placeholder} type="formFieldPlaceholder" />
      </div>
    )
  }
}
