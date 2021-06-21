import classnames from 'classnames'
import React from 'react'

export default class A_SelectOption extends React.PureComponent {
  constructor(props) {
    super(props)
  }

  render() {
    const { type, text, checked, handleClick } = this.props

    const classes = classnames({
      A_SelectOption: true,
      checked: checked
    })
    // [`${icon}`]: true

    return (
      <div className={classes} onClick={handleClick}>
        {text}
      </div>
    )
  }
}
