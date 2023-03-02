<#import "block/template.ftlh" as template>
<@template.template user>
  <div class="row">
    <div class="col-3">
      <img src="<#if user.avatar??>/images/${user.avatar.id}<#else>/static/images/no-image.png</#if>" alt="${user.name}" id="preview-images" class="mb-3">
      <h4>${user.name}</h4>
      <hr>
      <nav class="vertical-nav">
        <a href="/profile" class="vertical-nav-item">Мои объявления</a>
        <a href="/profile/add-product" class="vertical-nav-item">Добавить объявление</a>
        <a href="/profile/settings" class="vertical-nav-item active-link">Настройки</a>
        <#if user.isAdmin()><a href="/admin" class="vertical-nav-item">Панель администратора</a></#if>
      </nav>
    </div>
    <div class="col-9">
      <h2 class="mb-4">Настройки</h2>
        <#if message??>
          <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi flex-shrink-0 me-2" viewBox="0 0 16 16">
                <#if messageType == "success">
                  <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
                <#else>
                  <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                </#if>
            </svg>
              ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Закрыть"></button>
          </div>
        </#if>
      <form action="/profile/settings" method="post" enctype="multipart/form-data" class="mb-3">
        <fieldset disabled>
          <div class="mb-2 form-group">
            <label for="inputEmail" class="form-label">Электронная почта</label>
            <input type="email" name="email" class="form-control" id="inputEmail" value="${user.email}" >
          </div>
        </fieldset>
        <div class="mb-2 form-group">
          <label for="inputName" class="form-label">Имя пользователя</label>
          <input type="text" name="name" class="form-control" id="inputName" aria-describedby="emailHelp" placeholder="${user.name}">
        </div>
        <div class="mb-2 form-group">
          <label for="file1" class="col-sm-2 col-form-label">Установить фотографию профиля</label>
          <div class="col-sm-10">
            <input type="file" name="file1" id="file1" class="form-control">
          </div>
        </div>
        <div class="mb-3 form-group">
          <label for="inputPhone" class="form-label">Телефон</label>
          <input type="tel" name="phoneNumber" class="form-control" id="inputPhone" placeholder="${user.phoneNumber}">
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" class="btn">Изменить данные</button>
      </form>
      <h4 class="mb-3">Сменить пароль:</h4>
      <form action="/profile/settings/password" method="post">
        <div class="mb-2 form-group">
          <label for="inputPassword1" class="form-label">Старый пароль</label>
          <input type="password" name="oldPassword" class="form-control" id="inputPassword1" required minlength="6" maxlength="30">
        </div>
        <div class="mb-2 form-group">
          <label for="inputPassword2" class="form-label">Новый пароль</label>
          <input type="password" name="password" class="form-control" id="inputPassword2" required minlength="6" maxlength="30">
          <div class="form-text">Пароль должен быть длинной от 6 до 30 символов.</div>
        </div>
        <div class="mb-3 form-group">
          <label for="inputPassword3" class="form-label">Повторите пароль</label>
          <input type="password" name="confirmPassword" class="form-control" id="inputPassword3" required minlength="6" maxlength="30">
          <div class="form-text">Пароль должен быть длинной от 6 до 30 символов.</div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" class="btn">Изменить пароль</button>
      </form>
    </div>
  </div>
</@template.template>