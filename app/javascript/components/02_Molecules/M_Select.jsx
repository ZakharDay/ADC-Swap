import classnames from 'classnames'
import React from 'react'

import A_Text from '../01_Atoms/A_Text'

export default class M_Select extends React.PureComponent {
  constructor(props) {
    super(props)

    this.state = {
      placeholder: props.placeholder
    }
  }

  renderError = () => {
    console.log('error')
    this.setState({ placeholder: 'Ошибка' })
    // return <h1>ОШИБКА</h1>
  }

  render() {
    const { label, isActive, value, icon, handleClick } = this.props
    const { placeholder } = this.state
    let text = placeholder
    let type = 'formFieldPlaceholder'

    let clik = handleClick

    if (isActive == false) {
      clik = this.renderError
    }

    if (value != '') {
      text = value
      type = 'formFieldValue'
    }

    const classes = classnames({
      M_Select: true,
      [`${icon}`]: true
    })

    return (
      <div className={classes} onClick={clik}>
        <A_Text text={label} type="formFieldLabel" />
        <A_Text text={text} type={type} />
      </div>
    )
  }
}
