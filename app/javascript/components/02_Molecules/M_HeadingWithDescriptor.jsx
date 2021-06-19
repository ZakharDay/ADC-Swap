import React from 'react'

import A_Text from '../01_Atoms/A_Text'

export default class M_HeadingWithDescriptor extends React.PureComponent {
  constructor(props) {
    super(props)
  }

  render() {
    const { heading, descriptor } = this.props

    return (
      <div className="M_HeadingWithDescriptor">
        <A_Text text={heading} type="headingBlack" />
        <A_Text text={descriptor} type="descriptorGray" />
      </div>
    )
  }
}
