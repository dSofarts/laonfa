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
      <form action="/profile/settings/change" method="post" enctype="multipart/form-data">
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
          <label for="file1" class="col-sm-2 col-form-label">Фото</label>
          <div class="col-sm-10">
            <input type="file" name="file1" id="file1" class="form-control">
          </div>
        </div>
        <div class="mb-3 form-group">
          <label for="inputPhone" class="form-label">Телефон</label>
          <input type="tel" name="phoneNumber" class="form-control" id="inputPhone" placeholder="${user.phoneNumber}">
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" id="submit" class="btn mb-2">Изменить данные</button><br>
      </form>
    </div>
  </div>
</@template.template>