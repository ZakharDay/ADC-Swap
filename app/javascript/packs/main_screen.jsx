// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import MainScreenContainer from '../containers/MainScreenContainer'

document.addEventListener('DOMContentLoaded', () => {
  const props = JSON.parse(document.getElementById('data').dataset.props)

  console.log(props)

  ReactDOM.render(
    <MainScreenContainer props={props} />,
    document.body.appendChild(document.createElement('div'))
  )
})
