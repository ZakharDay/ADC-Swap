import React from 'react'

import M_LandingBlock from '../02_Molecules/M_LandingBlock'

export default class T_Landing extends React.Component {
  constructor(props) {
    super(props)
  }
  render() {
    return (
      <div className="T_Landing">
        <M_LandingBlock
          isFirst={true}
          headingContent={'Crowswap'}
          text={
            'Приложение, которое упростит твой обмен майнорми с\u00a0другим студентом Высшей Школы Экономики.'
          }
          handleClick={() => console.log('Click')}
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
        <div className="vave"></div>
      </div>
    )
  }
}
