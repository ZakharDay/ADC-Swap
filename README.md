# SETUP

```
rails db:create
rails db:migrate
rails db:seed
rails s
```

## API Call

```javascript
fetch("http://localhost:3000/api/v1/exchange_minors/")
  .then((response) => response.json())
  .then((data) => console.log(data));
```
