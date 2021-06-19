// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

import T_Registration from '../components/05_Templates/T_Registration'

document.addEventListener('DOMContentLoaded', () => {
  let props = document.getElementById('reactContainer').dataset.props
  props = JSON.parse(props)

  ReactDOM.render(
    <T_Registration {...props} />,
    document.body.appendChild(document.createElement('div'))
  )
})
