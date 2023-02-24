<#import "block/template.ftlh" as template>
<@template.template user>
  <div class="row">
    <div class="col-lg-9">
      <div class="mb-5">
        <h2 class="product-title">${product.title}</h2>
        <p class="mb-3 text-muted"><small>ID объявления: ${product.id}</small></p>
        <div id="carouselExample" class="carousel slide">
          <div class="carousel-inner">
            <#list images as image>
              <div class="carousel-item <#if product.previewImageId == image.id>active</#if>">
                <img src="/images/${image.id}" class="d-block w-100 img-product" alt="${product.title}">
              </div>
            </#list>
          </div>
          <#if images?size gt 1>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Предыдущий</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Следующий</span>
            </button>
          </#if>
        </div>
      </div>
      <div class="mb-5">
        <h4 class="mb-2">Адрес</h4>
        <p>${product.city}</p>
      </div>
      <div class="mb-5">
        <h4 class="mb-2">Описание</h4>
        <p>${product.description}</p>
      </div>
    </div>
    <div class="col-lg-3">
      <div>
        <h2 class="mb-5 product-title">${product.price}&nbsp;&#8381;</h2>
        <button type="button" id="phone-btn" class="btn mb-3" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
          <h3>Показать телефон</h3>
          <b>+7 XXX XXX-XX-XX</b>
        </button>
        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">Мобильный телефон продавца:</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Закрыть"></button>
              </div>
              <div class="modal-body">
                <h2>${product.user.phoneNumber}</h2>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn" data-bs-dismiss="modal">Закрыть</button>
              </div>
            </div>
          </div>
        </div>
        <div class="mb-3 row align-items-center">
          <div class="col-lg-8 col-10">
            <h5><a href="/user/${product.user.id}">${product.user.name}</a></h5>
            <p class="text-muted"><small>ID пользователя: ${product.user.id}</small></p>
          </div>
          <div class="col-lg-4 col-2">
            <img src="<#if product.user.avatar??>user/images/${product.user.avatar}<#else>/static/images/no-image.png</#if>" alt="${product.user.name}" id="preview-images-product" class="mb-3">
          </div>
        </div>
        <#if user.isAdmin() || user.findProduct(product)>
          <div>
            <form action="/product/delete/${product.id}" method="post">
              <input class="btn" type="submit" value="Удалить">
              <input type="hidden" name="_csrf" value="${_csrf.token}">
            </form>
          </div>
        </#if>
      </div>
    </div>
  </div>
</@template.template>