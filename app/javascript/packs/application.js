// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from '@rails/ujs'
// import Turbolinks from "turbolinks";
import * as ActiveStorage from '@rails/activestorage'
import 'channels'

Rails.start()
// Turbolinks.start();
ActiveStorage.start()

function createExchangeRequest(exchangeMinorId) {
  const data = { username: 'example' }

  fetch(
    `http://localhost:3000/api/v1/exchange_minors/${exchangeMinorId}/exchange_requests/`,
    {
      method: 'POST', // or 'PUT'
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    }
  )
    .then((response) => response.json())
    .then((data) => {
      console.log('Success:', data)

      document.getElementById('button').remove()
      const newDiv = document.createElement('div')
      const newContent = document.createTextNode('You request has been sent')
      newDiv.appendChild(newContent)
      document.body.appendChild(newDiv)
    })
    .catch((error) => {
      console.error('Error:', error)
    })
}

document.addEventListener('DOMContentLoaded', () => {
  // const button = document.getElementById('button')
  // const exchangeMinorId = button.dataset.exchangeminorid
  // console.log(button.dataset, button.dataset.exchangeminorid)

  // button.addEventListener('click', () => {
  // createExchangeRequest(exchangeMinorId)
  // })

  const sendCodeButton = document.getElementById('sendCodeButton')

  console.log('Yo')

  if (sendCodeButton) {
    sendCodeButton.addEventListener('click', () => {
      console.log('click')
      const emailField = document.getElementById('emailField')
      const hiddenEmailField = document.getElementById('hiddenEmailField')
      console.log(hiddenEmailField, emailField)
      hiddenEmailField.value = emailField.value
    })
  }
})

// Support component names relative to this directory:
var componentRequireContext = require.context('components', true)
var ReactRailsUJS = require('react_ujs')
ReactRailsUJS.useContext(componentRequireContext)
