<#import "block/template.ftlh" as template>
<@template.template user>
  <h3 class="main-title">Редактирование пользователя: <a href="/user/${user.id}">${user.name}</a></h3>
  <form action="/admin/user/edit" method="post" class="mb-5">
      <div class="form-group mb-3">
        <p>Изменить роль:</p>
        <#list roles as role>
          <div class="form-check">
            <input class="form-check-input" type="radio" value="${role}" name="roles" id="${role}" <#if user.roles?seq_contains(role)>checked</#if>>
            <label class="form-check-label" for="${role}">
              ${role}
            </label>
          </div>
        </#list>
      </div>
    <input type="hidden" value="${user.id}" name="userId">
    <input type="hidden" name="_csrf" value="${_csrf.token}">
    <button type="submit" class="btn">Сохранить</button>
  </form>
  <a href="/admin/user/delete/${user.id}"><button class="btn">Удалить пользователя</button></a>
</@template.template>