# Laonfa 🧑‍💻
Интернет-сервис для размещения и поиска объявлений о товарах, а также услугах от частных лиц или компаний. 

**В данном сервисе реализованно:** регистрация, 
авторизация, аутентификация, создание объявлений, поиск, просмотр объявлений конкретного пользователя, личный кабинет и многое другое.

**Приложение находиться в разработке!**

## Стек и требования

Java 17, Maven, Spring Boot 3.0.2, Spring Web, PostgreSQL, Spring Data JPA, Freemarker, Spring Security, Java Mail Sender, Lombok, Thymleaf, Hybernate, Bootstrap.

## Как запустить?
После копирования репозитория неободимо изменить данные в [application.properties](https://github.com/dSofarts/laonfa/blob/main/src/main/resources/application.properties).
Я ипользую PostgreSQL, но вы можете использовать любую другую СУБД. Пример заполнения:
    
    spring.datasource.url=jdbc:postgresql://localhost:5432/laonfa
    spring.datasource.username=username
    spring.datasource.password=password

Далее необходимо заполнить ифнормацию об электрнной почте, с которой приходят сообщения пользователям. Пример заполнения: 

    spring.mail.host=smtp.email.com
    spring.mail.username=email@email.com
    spring.mail.password=password
    spring.mail.port=555
    spring.mail.protocol=smtps
    
После настройки application.properties необходимо запустить приложение. Для запуска вам обязательно потребуется **Java 17** 

---

Если у Вас возникли сложности или вопросы, пожалуйста пишите на почту: [DronovEgorVl@yandex.com](mailto:DronovEgorVl@yandex.com)
<div id="badges">
  <a href="https://github.com/dSofarts">
    <img src="https://img.shields.io/badge/dSofarts-161b22?style=for-the-badge&logo=github&logoColor=white" alt="github Badge"/>
  </a>
  <a href="https://t.me/psvmger/">
    <img src="https://img.shields.io/badge/Telegram-blue?style=for-the-badge&logo=Telegram&logoColor=white" alt="Telegram Badge"/>
  </a>
  <a href="https://stackoverflow.com/users/20419526/dsofarts">
    <img src="https://img.shields.io/badge/stackoverflow-f2740d?style=for-the-badge&logo=stackoverflow&logoColor=white" alt="stackoverflow Badge"/>
  </a>
</div>
