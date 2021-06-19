import classnames from 'classnames'
import React from 'react'

import A_Text from '../01_Atoms/A_Text'

export default class M_Select extends React.PureComponent {
  constructor(props) {
    super(props)
  }

  render() {
    const { label, placeholder, value, icon, handleClick } = this.props
    let text = placeholder
    let type = 'formFieldPlaceholder'

    if (value != '') {
      text = value
      type = 'formFieldValue'
    }

    const classes = classnames({
      M_Select: true,
      [`${icon}`]: true
    })

    return (
      <div className={classes} onClick={handleClick}>
        <A_Text text={label} type="formFieldLabel" />
        <A_Text text={text} type={type} />
      </div>
    )
  }
}
