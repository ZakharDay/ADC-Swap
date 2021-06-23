import React from 'react'

import M_HeadingWithDescriptor from '../02_Molecules/M_HeadingWithDescriptor'
import M_Select from '../02_Molecules/M_Select'
import M_MultiSelect from '../02_Molecules/M_MultiSelect'
import S_SelectModal from '../04_Superorganisms/S_SelectModal'
import S_MultiSelectModal from '../04_Superorganisms/S_MultiSelectModal'

export default class T_Registration extends React.PureComponent {
  constructor(props) {
    super(props)

    this.state = {
      course: '',
      campus: { name: '' },
      yourMinor: { name: '' },
      wishedMinors: [],
      modal: 'none'
    }
  }

  toggleModal = (modalName) => {
    const { modal } = this.state

    this.setState({
      modal: modalName
    })
  }

  handleSubmit = (field, data) => {
    let newState = Object.assign({}, this.state)
    if (field == 'yourMinor') {
      newState.yourMinor = data
    }
    if (field == 'course') {
      newState.course = data.name
    }
    if (field == 'campus') {
      newState.campus = data
    }
    newState.modal = 'none'
    this.setState(newState)
  }

  renderModal = () => {
    const { minors, cities } = this.props
    const { modal, course, campus, yourMinor } = this.state
    let modalData = {}

    if (modal == 'wishedMinors') {
      // console.log('lel')
      modalData = {
        type: 'multi',
        heading: 'Выбери желаемые майноры',
        descriptor: 'Выбранный кампус должен совпадать с реальным',
        option: campus,
        optionList: minors[campus.id].map((minor) => {
          return { id: minor.id, name: minor.name }
        })
      }
      return (
        <S_SelectModal
          type={modalData.type}
          heading={modalData.heading}
          descriptor={modalData.descriptor}
          buttonText="Готово"
          field={modal}
          option={modalData.option}
          optionList={modalData.optionList}
          handleSubmit={this.handleSubmit}
        />
      )
    } else {
      if (modal == 'yourMinor') {
        modalData = {
          type: 'single',
          heading: 'Выбери свой майнор',
          descriptor:
            'Выбранный майнор должен совпадать с реальным. Таким образом тебе будут отправлять запрос на обмен.',
          option: yourMinor,
          optionList: minors[campus.id].map((minor) => {
            return { id: minor.id, name: minor.name }
          })
        }
      } else if (modal == 'course') {
        modalData = {
          type: 'single',
          heading: 'Выбери свой курс',
          descriptor: 'Выбранный курс должен совпадать с реальным',
          option: course,
          optionList: [
            { name: 2, id: 1 },
            { name: 3, id: 2 }
          ]
        }
      } else if (modal == 'campus') {
        modalData = {
          type: 'single',
          heading: 'Выбери свой кампус',
          descriptor: 'Выбранный кампус должен совпадать с реальным',
          option: campus,
          optionList: cities.map((city) => {
            return { id: city.id, name: city.name }
          })
        }
      }
      return (
        <S_SelectModal
          type={modalData.type}
          heading={modalData.heading}
          descriptor={modalData.descriptor}
          buttonText="Готово"
          field={modal}
          option={modalData.option}
          optionList={modalData.optionList}
          handleSubmit={this.handleSubmit}
        />
      )
    }
  }

  render() {
    const { course, campus, yourMinor, modal } = this.state
    const { minors } = this.props

    const weChoseOurCampus = campus.id ? true : false
    const weChoseOurMinor = yourMinor.id ? true : false

    return (
      <div className="T_Registration">
        {modal === 'none' ? '' : this.renderModal()}

        <div className="W_ContentArea">
          <div className="W_FormField courseAndCampus">
            <M_HeadingWithDescriptor
              heading="Базовая информация"
              descriptor="Твой курс и кампус должны совпадать с реальными"
            />

            <div className="C_CourseAndCampus">
              <M_Select
                label="Курс"
                placeholder="Выбери курс"
                icon="chevron"
                value={course}
                handleClick={() => this.toggleModal('course')}
              />

              <M_Select
                label="Кампус"
                placeholder="Выбери город"
                icon="chevron"
                value={campus.name}
                handleClick={() => this.toggleModal('campus')}
              />
            </div>
          </div>

          <div className="W_FormField yourMinor">
            <M_HeadingWithDescriptor
              heading="Выбери свой майнор"
              descriptor="Выбранный майнор должен совпадать с реальным. Таким образом тебе будут отправлять запрос на обмен."
            />

            <M_Select
              label="Твой майнор"
              placeholder="Выбери майнор"
              isActive={weChoseOurCampus}
              icon="chevron"
              value={yourMinor.name}
              handleClick={() => this.toggleModal('yourMinor')}
            />
          </div>

          <div className="W_FormField wishedMinors">
            <M_HeadingWithDescriptor
              heading="Выбери желемые майноры"
              descriptor="Обязательно уражи майноры, на которые хочешь перевестись. Мы сформируем для тебя ленту предложений."
            />

            <M_MultiSelect
              label="Твои желемые майноры"
              placeholder="Выбери несколько майноров"
              isActive={weChoseOurMinor}
              icon="chevron"
              value={yourMinor}
              handleClick={() => this.toggleModal('wishedMinors')}
            />
          </div>
        </div>
      </div>
    )
  }
}
