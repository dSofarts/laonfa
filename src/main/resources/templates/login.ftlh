<#import "block/form-template.ftlh" as form>
<@form.form>
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
  <form action="/login" method="post" class="row justify-content-center">
    <div class="col col-lg-4">
      <h3 class="main-title">Авторизация:</h3>
      <div class="mb-2 form-group">
        <label for="inputEmail" class="form-label">Адрес электронной почты</label>
        <input type="email" name="username" class="form-control" id="inputEmail" aria-describedby="emailHelp" required>
      </div>
      <div class="mb-3 form-group">
        <label for="inputPassword" class="form-label">Пароль</label>
        <input type="password" name="password" class="form-control" id="inputPassword" required>
      </div>
      <input type="hidden" name="_csrf" value="${_csrf.token}">
      <button type="submit" class="btn mb-2">Войти в аккаунт</button><br>
      <a href="/signup">Нет аккаунта? Зарегистрироваться</a>
    </div>
  </form>
</@form.form>