import classnames from 'classnames'
import React from 'react'

import A_Text from '../01_Atoms/A_Text'

export default class M_MultiSelect extends React.PureComponent {
  constructor(props) {
    super(props)
  }

  render() {
    const { label, placeholder, value, icon } = this.props
    let text = placeholder

    const classes = classnames({
      M_MultiSelect: true,
      [`${icon}`]: true
    })

    return (
      <div className={classes}>
        <A_Text text={label} type="formFieldLabel" />
      </div>
    )
  }
}
