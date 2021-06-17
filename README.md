# SETUP

```
rails db:create
rails db:migrate
//закомменитровать строку 9 в ADC-Swap/app/models/user.rb
rails db:seed
//раскомментировать строку 9 в ADC-Swap/app/models/user.rb
rails s -b 0.0.0.0
```

## API Call

```javascript
fetch('http://localhost:3000/api/v1/exchange_minors/')
  .then((response) => response.json())
  .then((data) => console.log(data))
```

# API tasks

## Спроектировать API

### Design

- Продумать все endpoints
- Продумать структуру данных для ответов на GET запросы
- Продумать структуру данных для POST запросов (что мы должны отправлять на сервер)
- Продумать ответы на POST запросы (что должно произойти, какая информация появиться/удалиться с экрана)

### Development

- В контроллер экшенах написать код

### Test

- Написать автотесты
<!-- Test -->
