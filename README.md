# Askme

## Описание

Сайт вопрсов и ответов. После регистрации пользователь заполняет свою анкету и может начать, как от своего имени, так и анонимно задавать и отвечать на вопросы других пользователей. 

## Preview

https://evgen-askme.herokuapp.com/

## Установка

Для корректной работы приложения, на вашем компьютере должен быть установлен Ruby 2.7.1 и Rails 6.0.3. 

```
$ git clone https://github.com/ProhorA8/askme.git
$ cd ./askme
$ bundle install --without production
$ yarn install --check-files
$ rails db:migrate
```
## Дополнительные функции


Вы можете использовать в приложении reCPTCHA v.2 - Google. 
Для этого нужно получить соответствующие [ключи](https://www.google.com/recaptcha/about/) и прописать их в credentials.
```
$ rm -rf config/credentials.yml.enc
$ EDITOR=vim rails credentials:edit
```
```
recaptcha:
  public_key: Ваш public key
  private_key: Ваш private key
```
> :warning: **ВАЖНО!** Не храните файл ```master.key``` от Вашего credentilas в публичных репозиториях!
## Запуск

Запуск осуществляется командой
```
$ bundle exec rails s
```
Приложение находится по адресу ```http://localhost:3000/``` или ```http://127.0.0.1:3000```
