import classnames from 'classnames'
import React from 'react'

export default class A_Input extends React.Component {
  constructor(props) {
    super(props)
  }
  render() {
    const { placeholder, handleChange, type, value, title } = this.props

    const classes = classnames({
      A_Input: true,
      [`${type}`]: true
    })

    return type == 'simple' ? (
      <input
        type="text"
        placeholder={placeholder}
        className={classes}
        onChange={(e) => handleChange(e.target.value)}
      />
    ) : (
      <div className={classes}>
        <div className="inputTitle">{title}</div>
        <input
          type="text"
          placeholder={placeholder}
          value={value}
          className="input"
          onChange={(e) => handleChange(e.target.value)}
        />
      </div>
    )
  }
}
