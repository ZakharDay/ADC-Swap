import classnames from 'classnames'
import React from 'react'

export default class M_LandingFooter extends React.Component {
  constructor(props) {
    super(props)
  }
  render() {
    const classes = classnames({
      M_LandingFooter: true
    })

    return (
      <div className={classes}>
        <div className="img"></div>
        Crowswap © 2021
        <div className="logoWrapper">
          <div className="img"></div>
          <div className="img"></div>
        </div>
      </div>
    )
  }
}
