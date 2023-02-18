<#macro template user>
  <!DOCTYPE html>
  <html lang="ru">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laonfa</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/main.css">
  </head>
  <body>
  <header id="header" class="sticky-top">
    <div class="container">
      <div class="row align-items-center">
        <div class="col-2 align-items-center">
          <a href="/" id="logo"><img src="/static/images/logo.svg" alt="LAONFA" width="100%"></a>
        </div>
        <div class="col-8">
          <form action="/" method="get" class="row align-items-center">
            <div class="col-10">
              <input type="text" name="title" placeholder="Поиск по объявлениям" class="form-control">
            </div>
            <div class="col-2 d-grid gap-2">
              <button type="submit" class="btn"><i class="bi bi-search"> </i>Поиск</button>
            </div>
          </form>
        </div>
        <div class="col-2 text-end">
            <#if user.email??>
              <div class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">${user.name}</a>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="/user/${user.id}">Профиль</a></li>
                    <#if user.isAdmin()><li><a class="dropdown-item" href="/admin">Панель администратора</a></li></#if>
                  <li><hr class="dropdown-divider"></li>
                  <li>
                    <form action="/logout" method="post">
                      <input type="hidden" name="_csrf" value="${_csrf.token}">
                      <input class="dropdown-item" type="submit" value="Выход из аккаунта">
                    </form>
                  </li>
                </ul>
              </div>
            <#else>
              <a href="/login">Войти в аккаунт</a>
            </#if>
        </div>
      </div>
    </div>
  </header>
  <div class="container">
      <#nested/>
  </div>
  <script type="text/javascript" src="/static/js/bootstrap.bundle.min.js"></script>
  </body>
  </html>
</#macro>