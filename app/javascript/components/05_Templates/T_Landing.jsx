import React from 'react'

import M_LandingBlock from '../02_Molecules/M_LandingBlock'
import M_LandingBanner from '../02_Molecules/M_LandingBanner'
import M_LandingFooter from '../02_Molecules/M_LandingFooter'
import O_LogInModal from '../03_Organisms/O_LogInModal'

export default class T_Landing extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      modal: false,
      email: ''
    }
  }

  changeEmail = (email) => {
    console.log(email)
    this.setState({ email: email })
  }

  render() {
    const { modal } = this.state
    return (
      <div className="T_Landing">
        <M_LandingBlock
          isFirst={true}
          headingContent={'Crowswap'}
          text={
            'Приложение, которое упростит твой обмен майнорми с\u00a0другим студентом Высшей Школы Экономики.'
          }
          handleClick={() => this.setState({ modal: !modal })}
          handleChange={this.changeEmail}
        />
        <M_LandingBlock
          isFirst={false}
          headingContent={'Скачивай приложение для\u00a0телефона'}
          text={
            'Обязательно скачивай наше приложение для\u00a0IOS\u00a0устройств и\u00a0всегда буд\u00a0на\u00a0связи!'
          }
        />
        <M_LandingBlock
          isFirst={false}
          headingContent={
            'Настраивай свою карточку и\u00a0получай запросы на обмен'
          }
          text={
            'В нашем приложение ты\u00a0точно найдешь тот\u00a0майнор, на\u00a0который хочешь перейти благодаря умной фильтрации\u00a0твоих данных.'
          }
        />
        <M_LandingBlock
          isFirst={false}
          headingContent={'Успешно обенивайся майнором внутри приложения'}
          text={
            'Мы внедрили в\u00a0приложение чат, который не\u00a0только поможет тебе\u00a0обсуждать нюансы перехода с\u00a0другим студентом, но\u00a0и\u00a0пошагово раскажет как\u00a0организовать процесс.'
          }
        />
        <div className="BannersWrapper">
          <M_LandingBanner
            text={
              'Начни использовать Crowawap уже\u00a0сегодня, поменяйся на\u00a0нужный майнор, увелич качествосвоего образования!'
            }
            type="input"
            handleClick={() => this.setState({ modal: !modal })}
            handleChange={this.changeEmail}
          />
          <M_LandingBanner
            text={
              'А\u00a0также ты\u00a0можешь использовать Сroqswap и\u00a0на\u00a0своем мобильном устройстве!'
            }
            type="img"
          />
        </div>
        <M_LandingFooter />
        {modal ? (
          <O_LogInModal
            value={this.state.email}
            handleClose={() => this.setState({ modal: !modal })}
            handleChange={this.changeEmail}
          />
        ) : (
          ''
        )}
      </div>
    )
  }
}
