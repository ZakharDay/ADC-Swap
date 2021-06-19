import classnames from 'classnames'
import React from 'react'

export default class A_Text extends React.PureComponent {
  constructor(props) {
    super(props)
  }

  render() {
    const { type, text } = this.props

    const classes = classnames({
      A_Text: true,
      [`${type}`]: true
    })

    return <div className={classes}>{text}</div>
  }
}
