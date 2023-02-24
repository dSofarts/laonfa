<#import "block/template.ftlh" as template>
<@template.template user>
  <div class="row">
    <div class="col-3">
      <img
          src="<#if user.avatar??>user/images/${user.avatar}<#else>/static/images/no-image.png</#if>"
          alt="${user.name}" id="preview-images" class="mb-3">
      <h4>${user.name}</h4>
      <hr>
      <nav class="vertical-nav">
        <a href="/profile" class="vertical-nav-item">Мои объявления</a>
        <a href="/profile/add-product" class="vertical-nav-item active-link">Добавить
          объявление</a>
        <a href="/profile/settings" class="vertical-nav-item">Настройки</a>
      </nav>
    </div>
    <div class="col-9">
      <h2 class="mb-4">Добавить новое объявление:</h2>
      <form action="/product/create" method="post" enctype="multipart/form-data">
        <div class="row mb-3">
          <label for="inputTitle" class="col-sm-2 col-form-label">Название*</label>
          <div class="col-sm-10">
            <input type="text" name="title" class="form-control" id="inputTitle"
                   placeholder="Название объявления" required>
          </div>
        </div>
        <div class="row mb-3">
          <label for="inputDescription" class="col-sm-2 col-form-label">Описание*</label>
          <div class="col-sm-10">
                        <textarea class="form-control" name="description" id="inputDescription"
                                  placeholder="Описание объявления" required></textarea>
            <div class="form-text">Не указывайте в описании телефон и e-mail — для этого
              есть отдельные поля.
            </div>
          </div>
        </div>
        <div class="row mb-3">
          <label for="inputPrice" class="col-sm-2 col-form-label">Цена*</label>
          <div class="col-lg-2 col-sm-10" style="min-width: 200px;">
            <input type="number" class="form-control" name="price" id="inputPrice"
                   placeholder="Цена" required>
          </div>
        </div>
        <div class="row mb-3">
          <label for="inputCity" class="col-sm-2 col-form-label">Город*</label>
          <div class="col-lg-2 col-sm-10" style="min-width: 300px;">
            <input type="text" class="form-control" name="city" id="inputCity"
                   placeholder="Город" required>
          </div>
        </div>
        <div class="row mb-3">
          <label for="file1" class="col-sm-2 col-form-label">Основное фото*</label>
          <div class="col-sm-10">
            <input type="file" name="file1" id="file1" class="form-control" required>
          </div>
        </div>
        <div class="row mb-3">
          <label for="file2" class="col-sm-2 col-form-label">Доп. фото</label>
          <div class="col-sm-10">
            <input type="file" name="file2" id="file2" class="form-control">
          </div>
        </div>
        <div class="row mb-4">
          <label for="file3" class="col-sm-2 col-form-label">Доп. фото</label>
          <div class="col-sm-10">
            <input type="file" id="file3" name="file3" class="form-control">
          </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn">Добавить объявления</button>
        <div class="form-text">* обязательные поля</div>
      </form>
    </div>
  </div>
</@template.template>