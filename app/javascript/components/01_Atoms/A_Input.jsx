import classnames from 'classnames'
import React from 'react'

export default class A_Input extends React.Component {
  constructor(props) {
    super(props)
  }
  render() {
    const { placeholder, buttonText, handleClick } = this.props

    const classes = classnames({
      A_Input: true
    })

    return <div className={classes}>{placeholder}</div>
  }
}
