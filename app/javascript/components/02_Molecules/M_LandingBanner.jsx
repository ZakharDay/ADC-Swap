import classnames from 'classnames'
import React from 'react'

import A_Input from '../01_Atoms/A_Input'
import A_Button from '../01_Atoms/A_Button'

export default class M_LandingBanner extends React.Component {
  constructor(props) {
    super(props)
  }
  render() {
    const { text, type, handleClick, handleChange } = this.props
    const classes = classnames({
      M_LandingBanner: true,
      [`${type}`]: true
    })
    return (
      <div className={classes}>
        <div className="content">{text}</div>
        {type == 'input' ? (
          <div className="InputWrapper">
            <A_Input
              placeholder="guest.hse.ru"
              type="simple"
              handleChange={handleChange}
            />
            <A_Button
              type="block"
              text="Регистрация"
              handleClick={handleClick}
            />
          </div>
        ) : (
          ''
        )}{' '}
        {type == 'img' ? <div className="img"></div> : ''}
      </div>
    )
  }
}
