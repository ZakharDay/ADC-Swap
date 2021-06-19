import classnames from 'classnames'
import React from 'react'

export default class A_Button extends React.PureComponent {
  constructor(props) {
    super(props)
  }

  render() {
    const { type, text, handleClick } = this.props

    const classes = classnames({
      A_Button: true,
      [`${type}`]: true
    })

    return (
      <div className={classes} onClick={handleClick}>
        {text}
      </div>
    )
  }
}
