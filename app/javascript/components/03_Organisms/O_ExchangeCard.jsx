import React from 'react'

const ExchangeMinorCard = (props) => {
  console.log(props)
  return (
    <a href={props.props.url}>
      <div class="card">
        <h4>
          {props.props.city} • {props.props.year}
        </h4>
        <h2>{props.props.title}</h2>
      </div>
    </a>
  )
}

export default ExchangeMinorCard
