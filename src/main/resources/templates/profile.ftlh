<#import "block/template.ftlh" as template>
<@template.template user>
  <div class="row">
    <div class="col-3">
      <img src="<#if user.avatar??>/images/${user.avatar.id}<#else>/static/images/no-image.png</#if>" alt="${user.name}" id="preview-images" class="mb-3">
      <h4>${user.name}</h4>
      <hr>
      <nav class="vertical-nav">
        <a href="/profile" class="vertical-nav-item active-link">Мои объявления</a>
        <a href="/profile/add-product" class="vertical-nav-item">Добавить объявление</a>
        <a href="/profile/settings" class="vertical-nav-item">Настройки</a>
        <#if user.isAdmin()><a href="/admin" class="vertical-nav-item">Панель администратора</a></#if>
      </nav>
    </div>
    <div class="col-9">
      <h2 class="mb-4">Мои объявления</h2>
        <#list user.products as product>
          <div class="card mb-3">
            <div class="row g-0">
              <div class="col-md-3">
                <img src="/images/${product.previewImageId}" class="img-fluid rounded-start product-card-img" alt="${product.title}">
              </div>
              <div class="col-md-9">
                <div class="card-body">
                  <a href="/product/${product.id}"><h6 class="card-title">${product.title}</h6></a>
                  <h5 class="card-title">${product.price}&nbsp;&#8381;</h5>
                  <p class="d-inline-block card-text text-truncate">${product.description}</p>
                  <p class="card-text"><small class="text-muted">${product.city}</small></p>
                </div>
              </div>
            </div>
          </div>
        <#else>
          <h4>Товаров еще нет :(<br><a href="/profile/add-product">Добавить новый товар</a></h4>
        </#list>
    </div>
  </div>
</@template.template>