import classnames from 'classnames'
import React from 'react'

import A_Button from '../01_Atoms/A_Button'
import A_Input from '../01_Atoms/A_Input'

export default class M_LandingBlock extends React.Component {
  constructor(props) {
    super(props)
  }
  render() {
    const { isFirst, headingContent, text, handleClick } = this.props

    const classes = classnames({
      M_LandingBlock: true
    })

    return (
      <div className={classes}>
        <div className="img"></div>
        <div className="Q_LandingBlockHeading">{headingContent}</div>
        <div className="Q_LandingBlockText">{text}</div>
        {isFirst ? (
          <div className="InputWrapper">
            <A_Input placeholder="guest.hse.ru" />
            <A_Button
              type="block"
              text="Регистрация"
              handleClick={handleClick}
            />
          </div>
        ) : (
          ''
        )}
      </div>
    )
  }
}
