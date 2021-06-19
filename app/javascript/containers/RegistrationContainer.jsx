import React from 'react'
import Form from '../components/02_Molecules/M_Form'

export default class RegistrationContainer extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      // exchenges: this.props.props
    }
  }

  renderForm = () => {
    let formItems = []
    let i = 1
    // this.state.exchenges.forEach((exchande, i) => {
    formItems.push(<Form props={'exchande'} key={i} />)
    // })

    return formItems
  }

  render() {
    console.log(this.props.props.courses)
    return <div>{this.renderForm()}</div>
  }
}
