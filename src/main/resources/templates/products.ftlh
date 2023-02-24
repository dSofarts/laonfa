<#import "block/template.ftlh" as template>
<@template.template user>
  <h3 class="main-title">Все товары:</h3>
  <div class="row row-cols-1 row-cols-md-4 g-4">
      <#list products as product>
        <div class="col">
          <div class="card">
              <#if product.previewImageId??>
                <a href="/product/${product.id}"><img src="/images/${product.previewImageId}"
                                                      class="card-img-top card-img-products"
                                                      alt="${product.title}"></a>
              </#if>
            <div class="card-body">
              <h6 class="card-title"><a href="/product/${product.id}">${product.title}</a></h6>
              <h5 class="card-title">${product.price}&nbsp;&#8381;</h5>
              <p class="card-text">${product.city}</p>
            </div>
          </div>
        </div>
      <#else>
        <h4>Упс :(<br>Все товары закончились...</h4>
      </#list>
  </div>
</@template.template>