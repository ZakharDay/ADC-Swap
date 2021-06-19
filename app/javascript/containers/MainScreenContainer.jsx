import React from 'react'
import ExchangeMinorCard from '../components/03_Organisms/O_ExchangeCard'

export default class MainScreenContainer extends React.PureComponent {
  constructor(props) {
    super(props)
    this.state = {
      exchenges: this.props.props
    }
  }

  renderExchangeCards = () => {
    let cardsItems = []

    this.state.exchenges.forEach((exchande, i) => {
      cardsItems.push(<ExchangeMinorCard props={exchande} />)
    })

    return cardsItems
  }

  render() {
    return <div class="display">{this.renderExchangeCards()}</div>
  }
}
