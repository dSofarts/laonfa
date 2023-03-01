<#import "block/template.ftlh" as template>
<@template.template user>
  <h3 class="main-title">Панель администратора</h3>
  <div class="table-responsive">
    <table class="table table-sm table-hover caption-top">
      <caption>Список пользователей</caption>
      <tr>
        <th>ID</th>
        <th>Email</th>
        <th>Имя пользователя</th>
        <th>Номер телефона</th>
        <th>Активность</th>
        <th>Роль</th>
        <th>Бан</th>
        <th>Редактирование</th>
        <th>Подробная информация</th>
      </tr>
        <#list users as user>
          <tr class="<#if user.isAdmin()>table-danger<#else><#if !user.isActive()>table-warning</#if></#if>">
            <th>${user.id}</th>
            <td>${user.email}</td>
            <td>${user.name}</td>
            <td>${user.phoneNumber}</td>
            <td><#if user.active>-<#else>НЕАКТИВЕН</#if></td>
            <td><#list user.roles as role>${role.name()}</#list></td>
            <td>
              <form action="/admin/user/ban/${user.id}" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Бан" class="btn">
              </form></td>
            <td><a href="/admin/user/edit/${user.id}">Редактировать</a></td>
            <td><a href="/user/${user.id}">Подробнее</a></td>
          </tr>
        </#list>
    </table>
  </div>
</@template.template>