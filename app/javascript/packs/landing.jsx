import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

import T_Landing from '../components/05_Templates/T_Landing'

document.addEventListener('DOMContentLoaded', () => {
  // let props = document.getElementById('reactContainer').dataset.props
  // props = JSON.parse(props)

  ReactDOM.render(
    <T_Landing />,
    document.body.appendChild(document.createElement('div'))
  )
})
