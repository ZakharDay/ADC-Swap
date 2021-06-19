import React from 'react'

import M_HeadingWithDescriptor from '../02_Molecules/M_HeadingWithDescriptor'
import M_Select from '../02_Molecules/M_Select'
import M_MultiSelect from '../02_Molecules/M_MultiSelect'
import S_SelectModal from '../04_Superorganisms/S_SelectModal'

export default class T_Registration extends React.PureComponent {
  constructor(props) {
    super(props)

    this.state = {
      course: '',
      campus: '',
      yourMinor: '',
      modal: 'none'
    }
  }

  renderModal = () => {
    const { minors } = this.props

    return (
      <S_SelectModal
        type="single"
        heading="Выбери свой майнор"
        descriptor="Выбранный майнор должен совпадать с реальным. Таким образом тебе будут отправлять запрос на обмен."
        buttonText="Готово"
        optionList={minors.map((minor) => {
          return minor.name
        })}
        handleSubmit={() => this.toggleModal('none')}
      />
    )
  }

  toggleModal = (modalName) => {
    const { modal } = this.state

    this.setState({
      modal: modalName
    })
  }

  render() {
    const { course, campus, yourMinor, modal } = this.state
    const { minors } = this.props

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
                handleClick={() => this.toggleModal('none')}
              />

              <M_Select
                label="Кампус"
                placeholder="Выбери город"
                icon="chevron"
                value={campus}
                handleClick={() => this.toggleModal('none')}
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
              icon="chevron"
              value={yourMinor}
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
              icon="chevron"
              value={yourMinor}
              handleClick={() => console.log('bla')}
            />
          </div>
        </div>
      </div>
    )
  }
}
