<#macro form>
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
    <div class="row justify-content-center mt-3">
      <div class="col-10 col-lg-3">
        <a href="/" id="logo"><img src="/static/images/logo.svg" alt="LAONFA" width="100%"></a>
      </div>
    </div>
  </div>
</header>
<div class="container">
  <#nested>
</div>
<script type="text/javascript" src="/static/js/bootstrap.bundle.min.js"></script>
</body>
</html>
</#macro>